variable "user" {
  description = "Gitlab user configuration"
  type = object({
    email             = string                     // The e-mail address of the user.
    name              = string                     // The name of the user.
    username          = string                     // The username of the user.
    can_create_group  = optional(bool, false)      // Whether to allow the user to create groups.
    is_admin          = optional(bool, false)      // Whether to enable administrative privileges
    is_external       = optional(bool, false)      //  Whether a user has access only to some internal or private projects. External users can only access projects to which they are explicitly granted access.
    namespace_id      = optional(number)           // The ID of the user's namespace. Available since GitLab 14.10.
    note              = optional(string)           // The note associated to the user.
    password          = optional(string)           // The password of the user.
    projects_limit    = optional(string)           // Integer, defaults to 0. Number of projects user can create.
    reset_password    = optional(bool, false)      // Send user password reset link.
    skip_confirmation = optional(bool, true)       // Whether to skip confirmation.
    state             = optional(string, "active") // The state of the user account. Valid values are active, deactivated, blocked.
  })
  default = null
}

variable "custom_attributes" {
  description = "Configure user custom attributes"
  type = list(object({
    user  = number // The id of the user.
    key   = string // Key for the Custom Attribute.
    value = string // Value for the Custom Attribute.
  }))
  default = []
}

variable "gpgkey" {
  description = "Gitlab user GPG key configuration"
  type = object({
    key     = string           // The armored GPG public key.
    user_id = optional(string) // The ID of the user to add the GPG key to. 
  })
  default = null
}

variable "gpgkeys" {
  description = "Gitlab user GPG key configuration"
  type = list(object({
    key     = string           // The armored GPG public key.
    user_id = optional(string) // The ID of the user to add the GPG key to. 
  }))
  default = []
}

variable "sshkey" {
  description = "Gitlab user ssh keys"
  type = object({
    key        = string           // The ssh key.
    title      = string           // The title of the ssh key.
    expires_at = optional(string) // The expiration date of the SSH key in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
    user_id    = string           // The ID or username of the user.
  })
  // validation {
  //   condition = var.sshkey == null ? true : can(regex("\\d{4}-\\d{2}-\\d{2}", var.sshkey.expires_at))
  //   error_message = "The date must be in the format YYYY-MM-DD."
  // }
  default = null
}

variable "sshkeys" {
  description = "Gitlab user ssh keys"
  type = list(object({
    key        = string           // The ssh key.
    title      = string           // The title of the ssh key.
    expires_at = optional(string) // The expiration date of the SSH key in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
    user_id    = string           // The ID or username of the user.
  }))
  // validation {
  //   condition = length(var.sshkeys) > 0 ? alltrue([
  //     for ssh in var.sshkeys : can(regex("\\d{4}-\\d{2}-\\d{2}", ssh.expires_at))
  //   if ssh.expires_at != null]) : true
  //   error_message = "The date must be in the format YYYY-MM-DD."
  // }
  default = []
}

variable "access_token" {
  description = "Configure the personal access token for a specified user"
  type = object({
    expires_at = string       // The token expires at midnight UTC on that date. The date must be in the format YYYY-MM-DD.
    name       = string       // The name of the personal access token.
    scopes     = list(string) // The scope for the personal access token.
    user_id    = string       // The id of the user.
  })
  // validation {
  //   condition = var.access_token.scopes != null ? length(setsubtract(
  //       var.access_token.scopes,
  //       [
  //         "api", "read_user", "read_api", "read_repository",
  //         "write_repository", "read_registry",
  //         "write_registry", "sudo", "admin_mode", "create_runner"
  //       ],
  //     )) == 0 : true
  //   error_message = <<EOT
  //     Valid values are: api, read_user, read_api, 
  //     read_repository, write_repository, read_registry, 
  //     write_registry, sudo, admin_mode, create_runner.
  //     EOT
  // }
  // validation {
  //   condition = var.access_token.expires_at != null ? can(regex("(\\d{4})-(\\d{2})-(\\d{2})", var.access_token.expires_at)): true
  //   error_message = "The date must be in the format YYYY-MM-DD."
  // }
  default = null
}

variable "access_tokens" {
  description = "Configure the personal access token for a specified user"
  type = list(object({
    expires_at = string       // The token expires at midnight UTC on that date. The date must be in the format YYYY-MM-DD.
    name       = string       // The name of the personal access token.
    scopes     = list(string) // The scope for the personal access token.
    user_id    = number       // The id of the user.
  }))
  validation {
    condition = length(var.access_tokens) > 0 ? alltrue([
      for token in var.access_tokens : length(setsubtract(
        token.scopes,
        [
          "api", "read_user", "read_api", "read_repository",
          "write_repository", "read_registry",
          "write_registry", "sudo", "admin_mode", "create_runner"
        ],
      )) == 0
    ]) : true
    error_message = <<EOT
      Valid values are: api, read_user, read_api, 
      read_repository, write_repository, read_registry, 
      write_registry, sudo, admin_mode, create_runner.
      EOT
  }
  validation {
    condition = length(var.access_tokens) > 0 ? alltrue([
      for token in var.access_tokens : can(regex("(\\d{4})-(\\d{2})-(\\d{2})", token.expires_at))
    ]) : true
    error_message = "The date must be in the format YYYY-MM-DD."
  }
  default = []
}

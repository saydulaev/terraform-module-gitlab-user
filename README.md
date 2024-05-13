<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | 16.11.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | 16.11.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_personal_access_token.this](https://registry.terraform.io/providers/gitlabhq/gitlab/16.11.0/docs/resources/personal_access_token) | resource |
| [gitlab_user.this](https://registry.terraform.io/providers/gitlabhq/gitlab/16.11.0/docs/resources/user) | resource |
| [gitlab_user_custom_attribute.this](https://registry.terraform.io/providers/gitlabhq/gitlab/16.11.0/docs/resources/user_custom_attribute) | resource |
| [gitlab_user_gpgkey.this](https://registry.terraform.io/providers/gitlabhq/gitlab/16.11.0/docs/resources/user_gpgkey) | resource |
| [gitlab_user_sshkey.this](https://registry.terraform.io/providers/gitlabhq/gitlab/16.11.0/docs/resources/user_sshkey) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/3.6.1/docs/resources/password) | resource |
| [gitlab_users.this](https://registry.terraform.io/providers/gitlabhq/gitlab/16.11.0/docs/data-sources/users) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tokens"></a> [access\_tokens](#input\_access\_tokens) | Configure the personal access token for a specified user | <pre>list(object({<br>    expires_at = string<br>    name       = string<br>    scopes     = list(string)<br>    user_id    = number<br>  }))</pre> | `[]` | no |
| <a name="input_custom_attributes"></a> [custom\_attributes](#input\_custom\_attributes) | Configure user custom attributes | <pre>list(object({<br>    user  = number<br>    key   = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_gpgkeys"></a> [gpgkeys](#input\_gpgkeys) | Gitlab user GPG key configuration | <pre>list(object({<br>    key     = string<br>    user_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_sshkeys"></a> [sshkeys](#input\_sshkeys) | Gitlab user ssh keys | <pre>list(object({<br>    key        = string // The ssh key.<br>    title      = string // The title of the ssh key.<br>    expires_at = optional(string)<br>    user_id    = string<br>  }))</pre> | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | Gitlab user configuration | <pre>object({<br>    email             = string                     // The e-mail address of the user.<br>    name              = string                     // The name of the user.<br>    username          = string                     // The username of the user.<br>    can_create_group  = optional(bool, false)      // Whether to allow the user to create groups.<br>    is_admin          = optional(bool, false)      // Whether to enable administrative privileges<br>    is_external       = optional(bool, false)      //  Whether a user has access only to some internal or private projects. External users can only access projects to which they are explicitly granted access.<br>    namespace_id      = optional(number)           // The ID of the user's namespace. Available since GitLab 14.10.<br>    note              = optional(string)           // The note associated to the user.<br>    password          = optional(string)           // The password of the user.<br>    projects_limit    = optional(string)           // Integer, defaults to 0. Number of projects user can create.<br>    reset_password    = optional(bool, false)      // Send user password reset link.<br>    skip_confirmation = optional(bool, true)       // Whether to skip confirmation.<br>    state             = optional(string, "active") // The state of the user account. Valid values are active, deactivated, blocked.<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_attributes"></a> [custom\_attributes](#output\_custom\_attributes) | User custom attributes id |
| <a name="output_gpgkeys_id"></a> [gpgkeys\_id](#output\_gpgkeys\_id) | User gpg key resource id |
| <a name="output_gpgkeys_key_id"></a> [gpgkeys\_key\_id](#output\_gpgkeys\_key\_id) | User gpg key id |
| <a name="output_id"></a> [id](#output\_id) | Gitlab user id |
| <a name="output_sshkeys_id"></a> [sshkeys\_id](#output\_sshkeys\_id) | Gitlab user ssh key resource id |
| <a name="output_sshkeys_key_id"></a> [sshkeys\_key\_id](#output\_sshkeys\_key\_id) | Gitlab user ssh key id |
<!-- END_TF_DOCS -->
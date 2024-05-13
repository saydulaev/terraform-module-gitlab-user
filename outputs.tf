output "id" {
  description = "Gitlab user id"
  value       = one(gitlab_user.this[*].id)
}

output "custom_attributes" {
  description = "User custom attributes id"
  value = length(try(var.custom_attributes, [])) > 0 ? [
    for attr in var.custom_attributes : merge({
      user = attr.user
      id   = gitlab_user_custom_attribute.this[attr.key].id
  })] : []
}

output "gpgkeys_id" {
  description = "User gpg key resource id"
  value       = values(gitlab_user_gpgkey.this)[*].id
}

output "gpgkeys_key_id" {
  description = "User gpg key id"
  value       = values(gitlab_user_gpgkey.this)[*].key_id
}

output "sshkeys_id" {
  description = "Gitlab user ssh key resource id"
  value       = values(gitlab_user_sshkey.this)[*].id
}

output "sshkeys_key_id" {
  description = "Gitlab user ssh key id"
  value       = values(gitlab_user_sshkey.this)[*].key_id
}

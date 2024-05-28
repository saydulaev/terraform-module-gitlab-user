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

output "gpgkey_id" {
  description = "User gpg key resource id"
  value       = one(gitlab_user_gpgkey.key[*].id)
}

output "gpgkeys_id" {
  description = "User gpg key resource id"
  value       = values(gitlab_user_gpgkey.keys)[*].id
}

output "gpgkeys_key_id" {
  description = "User gpg key id"
  value       = values(gitlab_user_gpgkey.keys)[*].key_id
}

output "sshkey_id" {
  description = "Gitlab user ssh key resource id"
  value       = one(gitlab_user_sshkey.key[*].id)
}

output "sshkeys_id" {
  description = "Gitlab user ssh key resource id"
  value       = values(gitlab_user_sshkey.keys)[*].id
}

output "sshkeys_key_id" {
  description = "Gitlab user ssh key id"
  value       = values(gitlab_user_sshkey.keys)[*].key_id
}

output "personal_access_token" {
  description = "Gitlab user access tokens"
  value       = one(gitlab_personal_access_token.token[*])
}

output "personal_access_tokens" {
  description = "Gitlab user access tokens"
  value       = values(gitlab_personal_access_token.tokens)[*]
}

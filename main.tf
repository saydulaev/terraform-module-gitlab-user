resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "gitlab_user" "this" {
  count = var.user != null && length(keys(var.user)) > 0 ? 1 : 0

  email             = var.user.email
  name              = var.user.name
  username          = var.user.username
  can_create_group  = var.user.can_create_group
  is_admin          = var.user.is_admin
  is_external       = var.user.is_external
  namespace_id      = var.user.namespace_id
  note              = var.user.note
  password          = var.user.password == null ? random_password.this.result : var.user.password
  projects_limit    = var.user.projects_limit
  reset_password    = var.user.reset_password
  skip_confirmation = var.user.skip_confirmation
  state             = var.user.state
}

data "gitlab_users" "this" {
  active = true
  depends_on = [
    gitlab_user.this
  ]
}

locals {
  _users = { for user in data.gitlab_users.this.users : user.username => user }
}

resource "gitlab_user_custom_attribute" "this" {
  for_each = {
    for attr in var.custom_attributes : attr.key => attr
    if length(var.custom_attributes) > 0
  }

  user  = coalesce(local._users[each.value.user].id, one(gitlab_user.this[*].id))
  key   = each.value.key
  value = each.value.value
}

resource "gitlab_user_gpgkey" "this" {
  for_each = {
    for gpg in var.gpgkeys :
    substr(gpg.key, 36, 27) => gpg if length(var.gpgkeys) > 0
  }
  user_id = coalesce(local._users[each.value.user_id].id, one(gitlab_user.this[*].id))
  key     = each.value.key
}

resource "gitlab_user_sshkey" "this" {
  for_each = {
    for ssh in var.sshkeys :
    substr(ssh.key, 0, 27) => ssh if length(var.sshkeys) > 0
  }
  user_id    = coalesce(local._users[each.value.user_id].id, one(gitlab_user.this[*].id))
  title      = each.value.title
  key        = each.value.key
  expires_at = each.value.expires_at
}

resource "gitlab_personal_access_token" "this" {
  for_each = {
    for token in var.access_tokens :
    token.name => token if length(var.access_tokens) > 0
  }
  user_id    = coalesce(local._users[each.value.user].id, one(gitlab_user.this[*].id))
  name       = each.value.name
  expires_at = each.value.expires_at
  scopes     = each.value.scopes
}

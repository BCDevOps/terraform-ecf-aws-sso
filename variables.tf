variable "kc_realm" {
  description = "KeyCloak realm where terraform client has been created and where users/groups to be created/manipulated exist."
  type        = string
}

variable "kc_terraform_auth_client_id" {
  description = "Client ID of client that terraform will authenticate against in order to do its work."
  type        = string
}

variable "kc_terraform_auth_client_secret" {
  description = "Client secret used by Terraform KeyCloak provider authenticate against KeyCloak."
  type        = string
}

variable "kc_iam_auth_client_id" {
  description = "Client ID of client where KC roles corresponding to AWS roles will be created."
  type        = string
}

variable "kc_base_url" {
  description = "Base URL of KeyCloak instance to interact with."
  type        = string
}

variable "custom_login_url" {
  description = "URL of custom login page/app."
  type        = string
  default     = null
}

variable "project_accounts" {
  type        = map(any)
  description = "A map of the project accounts (with structure matching output of aws_organizations_account) for which we will be creating roles and IDP resources, keyed by the name of the envrionment."
}

variable "workload_account_role_config" {
  description = "A mapping of role names to be created to (existing) policy arns."
  type = list(object({
    aws_role_name       = string
    aws_policy_arns     = list(string)
    keycloak_group_name = string
    environments        = list(string)
  }))
}

variable "tenancy_root_group_name" {
  type    = string
  default = "Project Team Groups"
}

variable "project_spec" {
  description = "List of projects/(accounts) that product teams' workloads run within."
  type = object({
    identifier = string
    name       = string
    tags = object({
      account_coding = string
      # ministry_name       = string
      admin_contact_email = string
      admin_contact_name  = string
      billing_group       = string
      additional_contacts = optional(list(object({
        name  = optional(string, null)
        email = optional(string, null)
      })))
    })
    accounts = list(object({
      name        = string
      environment = string
    }))
  })
}

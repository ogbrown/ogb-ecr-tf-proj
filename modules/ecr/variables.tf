variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}
variable "general_kms_key_alias" {
  description = "Alias of my KMS Key for Encrypt Decrypt operations"
  type        = string
}
variable "tags" {
  type = map(string)
}
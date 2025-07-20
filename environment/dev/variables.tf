variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"

}


variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}
variable "tags" {
  type = map(string)
}


variable "general_kms_key_alias" {
  description = "Alias of my KMS Key for Encrypt Decrypt operations"
  type        = string
}
locals {
  global_tags = merge(
    var.tags,
    {
      LastApplied = timestamp()
    }
  )
}
data "aws_caller_identity" "current" {}

data "aws_kms_key" "aurora_kms_key" {
  key_id = "alias/${var.general_kms_key_alias}" # Replace with your KMS key alias
}


module "ecr" {
  source                = "../../modules/ecr"
  short_project_name    = var.short_project_name
  tags                  = local.global_tags
  general_kms_key_alias = var.general_kms_key_alias
}

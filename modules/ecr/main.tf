data "aws_kms_key" "ecr_kms_key" {
  key_id = "alias/${var.general_kms_key_alias}" # Replace with your KMS key alias
}

resource "aws_ecr_repository" "main" {
  name                 = "${var.short_project_name}-repo"
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = "${data.aws_kms_key.ecr_kms_key.arn}"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "cleanup" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than 7 days"
        selection    = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
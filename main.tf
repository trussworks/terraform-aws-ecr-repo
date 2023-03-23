locals {
  # Use our standard lifecycle policy if none passed in.
  policy = var.lifecycle_policy == "" ? file("${path.module}/lifecycle-policy.json") : var.lifecycle_policy

  tags = {
    Automation = "Terraform"
  }
}

resource "aws_ecr_repository" "main" {
  name                 = var.container_name
  image_tag_mutability = var.image_tag_mutability
  tags                 = merge(local.tags, var.tags)
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  dynamic "encryption_configuration" {
    for_each = var.encryption_configuration == null ? [] : [var.encryption_configuration]
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key         = encryption_configuration.value.kms_key

    }
  }
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = local.policy
}

# Only create the resource if policy is specified. By Default AWS does not
# attach a ECR policy to a repository.
resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = var.ecr_policy
  count      = length(var.ecr_policy) > 0 ? 1 : 0
}

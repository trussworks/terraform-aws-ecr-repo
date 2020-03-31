locals {
  # Use our standard lifecycle policy if none passed in.
  policy = "${var.lifecycle_policy == "" ? file("${path.module}/lifecycle-policy.json") : var.lifecycle_policy}"

  tags = {
    Automation = "Terraform"
  }
}

resource "aws_ecr_repository" "main" {
  name = var.name
  tags = merge(local.tags, var.tags)
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = local.policy
}

data "aws_iam_policy_document" "ecr" {
  statement {
    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${local.easi_dev_account}:root",
        "arn:aws:iam::${local.easi_impl_account}:root",
        "arn:aws:iam::${local.easi_prod_account}:root",
      ]
    }

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalOrgID"
      # This is our organization-wide identifier which can be found after
      # log-in to AWS: <https://console.aws.amazon.com/organizations/home>
      values = [var.org_id]
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
    ]
  }
}


resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = length(var.ecr_policy) > 0 ? var.ecr_policy : aws_iam_policy_document.ecr
}

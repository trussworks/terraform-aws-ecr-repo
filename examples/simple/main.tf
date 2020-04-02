data "aws_organizations_organization" "user_org" {}

data "aws_iam_policy_document" "org_ecr" {
  statement {

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalOrgID"
      values   = [data.aws_organizations_organization.user_org.id]
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

module "aws_ecr" {
  source         = "../../"
  container_name = var.test_name
  ecr_policy     = data.aws_iam_policy_document.org_ecr.json
}

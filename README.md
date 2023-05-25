# Terraform AWS ECR Repo

Creates a basic ECR repository.

It's highly suggested to provide your own lifecycle policy and IAM role policy.

By default, this module will not create an IAM role policy to attach to the ECR repo that is created with this module.

Please see [AWS Documentation on Lifecycle Policies](https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html) for example lifecycle policies.

The default lifecycle policy included in this module will keep the latest tagged image and delete all untagged images after 14 days.

## Usage

### Put an example usage of the module here

```hcl
module "example" {
  source = "trussworks/ecr-repo/aws"

  container_name = "example"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.4.0 |
| aws | ~> 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| container\_name | Container name. | `string` | n/a | yes |
| ecr\_policy | ECR IAM permission policy for external access. | `string` | `""` | no |
| encryption\_configuration | ECR encryption configuration. By default, this uses AWS's server-side encryption using AES-256 | ```object({ encryption_type = string kms_key = any })``` | `null` | no |
| force\_delete | Whether to delete the repository even if it contains images | `bool` | `false` | no |
| image\_tag\_mutability | Whether allow image tags to be mutable. | `string` | `"IMMUTABLE"` | no |
| lifecycle\_policy | ECR repository lifecycle policy document. Used to override the default policy. | `string` | `""` | no |
| scan\_on\_push | Scan image on push to repo. | `bool` | `true` | no |
| tags | Additional tags to apply. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | Full ARN of the repository. |
| repo\_url | The URL for the repository created. |
<!-- END_TF_DOCS -->

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit tfenv terraform-docs
pre-commit install --install-hooks
```

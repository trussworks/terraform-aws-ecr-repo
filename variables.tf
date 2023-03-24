variable "container_name" {
  type        = string
  description = "Container name."
}

variable "ecr_policy" {
  type        = string
  description = "ECR IAM permission policy for external access."
  default     = ""
}

variable "encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key         = any
  })
  description = "ECR encryption configuration. By default, this uses AWS's server-side encryption using AES-256"
  default     = null
}

variable "force_delete" {
  type        = bool
  description = "Whether to delete the repository even if it contains images"
  default     = false
}

variable "image_tag_mutability" {
  type        = string
  description = "Whether allow image tags to be mutable."
  default     = "IMMUTABLE"
}

variable "lifecycle_policy" {
  type        = string
  description = "ECR repository lifecycle policy document. Used to override the default policy."
  default     = ""
}

variable "scan_on_push" {
  type        = bool
  description = "Scan image on push to repo."
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "Additional tags to apply."
  default     = {}
}

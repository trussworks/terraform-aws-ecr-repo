variable "container_name" {
  type        = string
  description = "Container name."
}

variable "lifecycle_policy" {
  type        = string
  description = "ECR repository lifecycle policy document. Used to override the default policy."
  default     = ""
}

variable "ecr_policy" {
  type        = string
  description = "ECR Permission Policy for external access."
  default     = ""
}

variable "tags" {
  type        = map(any)
  description = "Additional tags to apply."
  default     = {}
}

variable "scan_on_push" {
  type        = bool
  description = "Scan image on push to repo."
  default     = true
}

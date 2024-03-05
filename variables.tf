variable "name" {
  description = "The name of the function"
  type        = string
}

variable "description" {
  description = "The description of the function"
  type        = string
}

variable "location" {
  description = "The location (region) of the function"
  type        = string
}

variable "runtime" {
  description = "Which runtime to run the function with"
  type        = string
}

variable "entry_point" {
  description = "The entry point to execute the function from"
  type        = string
}


variable "source_code" {
  description = "The source code of the function"
  type = object({
    bucket = string
    object = string
  })
}

variable "available_memory" {
  description = "The memory to allocate to the function in MB"
  type        = number
  default     = 256
}

variable "max_instance_count" {
  description = "The maximum number of instances to run"
  type        = number
  default     = 1
}

variable "environment_variables" {
  description = "The environment variables for the function"
  type        = map(string)
  default     = {}
}

variable "service_account" {
  description = "Information about the service account used by the function"
  default     = {}

  type = object({
    name        = optional(string, null)
    description = optional(string, null)
  })
}

variable "event_trigger" {
  description = "The event triggering the function"

  default = null

  type = object({
    event_type   = string
    pubsub_topic = string

    service_account_email = optional(string, null)

    retry_policy   = optional(string, "RETRY_POLICY_DO_NOT_RETRY")
    trigger_region = optional(string, null)
  })
}

variable "key_name" {
  description = "key name to create"
type = string
default = "dev-key" # here u can put the name u want ur key to answer
}

variable "filename" {
  default = "dev-key.pem"
}

variable "file_permission" {
  default = 400
}
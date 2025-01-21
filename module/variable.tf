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

variable "aws-region" {
  type = string  # when u can add many value
  default = "us-east-1"
}

variable "output_pemfile" {
  default = "local_file.ssh_key.filename"
}

variable "output_keyname" {
  default = "aws_key_pair.aws_key.key_name"
}

variable "aws_ami" {
  default = "data.aws_ami.amazon-2.id "
}

variable "instance_type" {
  default = "t2.micro"
}

# define subnet variables
variable "subnet_cidr_private" {
  description = "cidr blocks for the private subnets"
  default     = ["10.20.20.0/28", "10.20.20.16/28"]
  type        = list(any)
}

# define availability zones
variable "availability_zone" {
  description = "availability zones for the private subnets"
  default     = ["us-east-1a", "us-east-1b"]
  type        = list(any)
}

# define subnet variables
variable "subnet_cidr_public" {
  description = "cidr blocks for the private subnets"
  default     = ["10.20.21.0/28", "10.20.20.16/28"]
  type        = list(any)
}

## lightsail variable
variable "lightsail-name" {
  description = "value"
  default = "dev1"
}
variable "availability_zone" {
  description = "value"
  default = "us-east-1b"
}
variable "blueprint_id" {
  default = "amazon_linux_2"
}
variable "bundle_id" {
  default = "nano_3_0"
}
variable "instance_name" {
  default = "udt"
}
variable "env" {
  default = "dev"
}
variable "Team" {
  default = "qa"
}

variable "aws_iam_user" {
  default = "valery"
  type = list()
}

variable "aws_iam_group" {
  default = "developer"
  type = list()
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "my_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "my_key" {
  type    = string
  default = "wema_class"
}

variable "my_key_path" {
  description = "Full path extension of private key file"
  default     = "~/DevOps_Class/Ken_study/WEMA/wema_class.pem"
}

variable "ssh_config_path_windows" {
  description = "Full path extension of windows ssh config file"
  default     = "C:/users/kjwat/.ssh/config"
}

variable "os" {
  description = "Where is this terraform code being run? \nPlease enter <linux> for mac/linux os and <windows> for windows os."
  validation {
    condition     = var.os == "linux" || var.os == "windows"
    error_message = "Invalid os value. Please enter <linux> or <windows>."
  }
  #default = "linux"
}

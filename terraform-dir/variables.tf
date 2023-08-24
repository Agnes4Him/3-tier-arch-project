variable aws_region {
  description = "AWS region to deploy the infrastructure"
  default     = "us-east-1"
}

variable aws_profile {
  description = "AWS CLI profile to use for authentication"
  default     = "default"
}

variable vpc_cidr {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable web_subnetA {
  description = "CIDR block for the web tier subnet A - public"
  default     = "10.0.1.0/24"
}

variable web_subnetB {
  description = "CIDR block for the web tier subnet B - public"
  default     = "10.0.2.0/24"
}

variable app_subnetA {
  description = "CIDR block for the app tier subnet A - private"
  default     = "10.0.3.0/24"
}

variable app_subnetB {
  description = "CIDR block for the app tier subnet B - private"
  default     = "10.0.4.0/24"
}

variable db_subnetA {
  description = "CIDR block for the database tier subnet A - private"
  default     = "10.0.5.0/24"
}

variable db_subnetB {
  description = "CIDR block for the database tier subnet B - private"
  default     = "10.0.6.0/24"
}

variable az_1 {
  description = "Availability zone 'a' for the default AWS region"
  default     = "us-east-1a"
}

variable az_2 {
  description = "Availability zone 'b' for the default AWS region"
  default     = "us-east-1b"
}

variable my_ip {
  description = "My IP address"
  default     = ""
}

variable web_instance_type {
  description = "EC2 instance type for the web tier"
  default     = "t2.micro"
}

variable app_instance_type {
  description = "EC2 instance type for the app tier"
  default     = "t2.micro"
}

variable db_instance_class {
  description = "RDS instance class for the database tier"
  default     = "db.t2.micro"
}

variable db_username {
  description = "Username for the RDS instance"
  default     = ""
}

variable db_password {
  description = "Password for the RDS instance"
  sensitive   = true
}

variable db_name {
  description = "Database name at creation"
  default   = "demo-db"
}

variable multi_az {
  description = "Multi-az deployment for RDS"
  default     = true
}
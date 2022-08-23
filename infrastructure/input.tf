variable "ADMIN_JWT_SECRET" {
    type = string
    sensitive = true
}

variable "API_TOKEN_SALT" {
    type = string
    sensitive = true
}

variable "APP_KEYS" {
    type = string
    sensitive = true
}

variable "JWT_SECRET" {
    type = string
    sensitive = true
}

variable "DATABASE_HOST" {
    type = string
    sensitive = true
}

variable "DATABASE_NAME" {
    type = string
}

variable "DATABASE_PASSWORD" {
    type = string
    sensitive = true
}

variable "DATABASE_USERNAME" {
    type = string
}
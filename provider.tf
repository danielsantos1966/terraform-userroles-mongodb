terraform {
  required_version = ">= 0.13"

  required_providers {
    mongodb = {
      source = "Kaginari/mongodb"
    }
  }
}

provider "mongodb" {
  host = "localhost"
  port = "27017"
  username = "user"
  password = "pass"
  ssl = false
  auth_database = "admin"
}

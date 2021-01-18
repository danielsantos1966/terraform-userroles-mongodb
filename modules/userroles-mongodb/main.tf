resource "mongodb_db_user" "user" {
  auth_database = var.database
  name = var.username
  password = var.password

  role {
    role = "readWrite"
    db =   "exemple"
  }
}

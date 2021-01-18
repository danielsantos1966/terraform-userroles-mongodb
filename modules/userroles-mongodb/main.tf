#resource "mongodb_db_role" "role" {
#  name = "test"
#  privilege {
#    db = "exemple"
#    collection = "log"
#    actions = ["collStats"]
#  }
#  privilege {
#    db = "ds"
#    collection = "*"
#    actions = ["collStats"]
#  }
#}

#resource "mongodb_db_role" "role_2" {
#  depends_on = [mongodb_db_role.role]
#  database = "admin"
#  name = "new_role3"
#  inherited_role {
#    role = mongodb_db_role.role.name
#    db =   "admin"
#  }
#}

#resource "mongodb_db_role" "role4" {
#  depends_on = [mongodb_db_role.role]
#  database = "exemple"
#  name = "new_role4"
#}

resource "mongodb_db_user" "user" {
  auth_database = var.database
  name = var.username
  password = var.password
#  role {
#    role = mongodb_db_role.role.name
#    db =   "admin"
#  }
#  role {
#    role = "readAnyDatabase"
#    db =   "admin"
#  }
#  role {
#    role = "readWrite"
#    db =   "local"
#  }
#  role {
#    role = "readWrite"
#    db =   "monta"
#  }

  role {
    role = "readWrite"
    db =   "exemple"
  }

}

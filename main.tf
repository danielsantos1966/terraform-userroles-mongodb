module "user_roles" {
for_each = var.users
source = "./modules/userroles-mongodb"
username = each.value.username
password = each.value.password
database = each.key
}

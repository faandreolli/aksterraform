module "modulos" {
source = "../Modulos"
resoucegroup = var.resoucegroup
environment = var.environment
location    = var.location
aksname = var.aksname
aksdnsprefix = var.aksdnsprefix

}
module "aks" {
    source = "./AKS"
    resoucegroup = var.resoucegroup
    environment = var.environment
    location    = var.location
    aksname = var.aksname
    aksdnsprefix = var.aksdnsprefix
}
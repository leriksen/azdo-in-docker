module "globals" {
  source = "./modules/context/globals"
}

module "subscription" {
  source       = "./modules/context/subscription"
  subscription = "nonprod"
}

module "environment" {
  source      = "./modules/context/environment"
  environment = "prd"
}
module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}


module "automation_account" {
  source  = "cloudnationhq/aa/azure"
  version = "~> 2.0"

  config = {
    name           = module.naming.automation_account.name_unique
    resource_group = module.rg.groups.demo.name
    location       = module.rg.groups.demo.location
  }
}

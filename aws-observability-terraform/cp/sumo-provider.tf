terraform {
  required_providers {
    sumologic = {
      source  = "SumoLogic/sumologic"
      version = "2.31.3"
    }
  }
}


provider "sumologic" {
  environment = "eu"
  access_id   = local.sumologiccreds["access_id"]
  access_key  = local.sumologiccreds["access_key"]
  admin_mode  = true
}

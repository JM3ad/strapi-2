terraform {
  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "dustvale"
  location = "UK South"
}

resource "azurerm_service_plan" "main" {
  name                = "ASP-dustvale-9ac7"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "dustvale-api"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  https_only = true
  site_config {
    always_on = false
    application_stack {
      docker_image     = "jackmead/strapi"
      docker_image_tag = "latest"
    }
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL = "https://index.docker.io"
    HOST = "0.0.0.0"

    ADMIN_JWT_SECRET = var.ADMIN_JWT_SECRET
    API_TOKEN_SALT = var.API_TOKEN_SALT
    APP_KEYS = var.APP_KEYS
    JWT_SECRET = var.JWT_SECRET
    DATABASE_HOST = var.DATABASE_HOST
    DATABASE_NAME = var.DATABASE_NAME
    DATABASE_PASSWORD = var.DATABASE_PASSWORD
    DATABASE_USERNAME = var.DATABASE_USERNAME

    STORAGE_ACCOUNT = azurerm_storage_account.main.name
    STORAGE_ACCOUNT_KEY = azurerm_storage_account.main.primary_access_key
    STORAGE_CONTAINER_NAME = azurerm_storage_container.main.name
    STORAGE_URL = azurerm_storage_account.main.primary_blob_endpoint
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "dustvaleimages"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "main" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "blob"
}
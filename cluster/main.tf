
provider "azurerm" {
skip_provider_registration = "true"
version = "~>2.0"
features {}
}

resource "random_id" "id" {
	  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "paas-fis-workpace-${random_id.id.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "solution" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.workspace.id
  workspace_name        = azurerm_log_analytics_workspace.workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                                = local.aks_cluster_name
  location                            = var.location
  dns_prefix                          = local.aks_cluster_name
  resource_group_name                 = var.resource_group_name

  #seperate resource group ending -aks will be created for Nodes. K8s will exist in reguler RG., OPTIONAL.
  node_resource_group                 = format("%s-aks", var.resource_group_name) 
  
  kubernetes_version                  = var.aks_version

  tags                                = var.tags

  api_server_authorized_ip_ranges     = var.api_server_authorized_ip_ranges
  
  enable_pod_security_policy          = var.enable_pod_security

  role_based_access_control {
    enabled                           = var.enable_pod_security == true ? true : var.rbac_enabled
  }

  service_principal {
    client_id = var.client_id
    client_secret = var.client_secret
  }

  dynamic "network_profile" {
    for_each                          = [var.network_profile_model]
    content {
      dns_service_ip                  = lookup(network_profile.value, "dns_service_ip", null)
      docker_bridge_cidr              = lookup(network_profile.value, "docker_bridge_cidr", null)
      load_balancer_sku               = lookup(network_profile.value, "load_balancer_sku", null)
      network_plugin                  = network_profile.value.network_plugin
      network_policy                  = network_profile.value.network_policy
      pod_cidr                        = lookup(network_profile.value, "pod_cidr", null)
      service_cidr                    = lookup(network_profile.value, "service_cidr", null)
    }
  }

  default_node_pool {
    name                              = "default"
    vm_size                           = var.node_vm_size
    availability_zones                = var.azs
    type                              = "VirtualMachineScaleSets"
    enable_node_public_ip             = var.enable_node_public_ip
    os_disk_size_gb                   = var.node_vm_disk_size
    enable_auto_scaling               = var.auto_scaling
    node_count                        = var.node_count
  }

  addon_profile {
    oms_agent {
      enabled                         = false
    }
    http_application_routing {
      enabled                         = var.http_application_routing_enabled
    }

    dynamic"aci_connector_linux" {
      for_each                        = var.aci_connector_enabled == true ? [var.aci_subnet_name] : []
      content {
        enabled                       = true
        subnet_name                   = aci_connector_linux.value
      }
    }

    azure_policy {
      enabled                         = var.azure_policy_enabled
    }
    kube_dashboard {
      enabled                         = var.kube_dashboard_enabled
    }
  }

  lifecycle {
    ignore_changes = [windows_profile, tags]
  }
  
  depends_on = [var.my_dependencies]
}
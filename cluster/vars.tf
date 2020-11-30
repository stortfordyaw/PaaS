#### Required Variables ####
variable "naming_convention" {
  type        = map(string)
  description = "(Required) Array of naming convention variables."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The resource group name."
}

variable "azs" {
  type        = list(string)
  description = "(Required) Which Availability Zones will the nodes deploy to."
}

variable "dns_zone_id" {
  type        = string
  description = "(Required) Defines the dns zone id"
}

variable "client_secret" {
  description = "Enter secret"
}

variable "client_id" {
  description = "ENter ID"
}

#### Optional Variables ####
variable "tags" {
  type        = map(string)
  description = "(Optional) List of tags to apply to DB."
  default     = {
    E-mail   = "PaaS.Cloud.Support@fisglobal.com"
    BUC       = "2114.518419.9835.000000.0000.0000.1200"
    Environment = "Development"

  }
}

variable "azurerm_log_analytics_workspace" {
  type = string  
  default = ""
}

variable "admin_username" {
  type        = string
  description = "(Required) Username applied to AKS cluster."
  default     = "aksadmin"
}

variable "ssh_public_key" {
  default     = "~/.ssh/id_rsa.pub"
  description = "(Optional) path of ssh key used by the linux nodes. Default = ~/.ssh/id_rsa.pub"
}

variable "location" {
  default     = "northeurope"
  description = "(Optional) The azure location where the AKS cluster will be deployed. Default = eastus."
}

variable "network_profile_model" {
  type        = map(string)
  description = "(Optional) Specified the AKS network strategy . Default = kubenet"
  default = {
    network_plugin = "azure"
    network_policy = "calico"
  }
}

variable "workspace_id" {
  type        = string
  description = "(Optional) Workspace ID for log analytics."
  default     = ""
}

variable "node_count" {
  type        = number
  description = "(Optional) Number of Nodes in the node pool. Default = 3"
  default     = 3
}

variable "node_vm_size" {
  type        = string
  description = "(Optional) Size of the VMs deployed into the node pool. Default = Standard_D16s_v3"
  default     = "Standard_D4_v3"
}

variable "node_vm_disk_size" {
  type        = number
  description = "(Optional) Size of the disks attached to the VMs deployed into the node pool. Default = 100"
  default     = 100
}

variable "aks_version" {
  type        = string
  description = "(Optional) Version of Kubernetes to run. Default = 1.19.0"
  default     = "1.19.1"
}

variable "rbac_enabled" {
  type = bool
  description = "(Optional) Enable RBAC for K8s Access.  Deafult = true (bool)"
  default = true
}

variable "http_application_routing_enabled" {
  type = bool
  description = "(Optional) Enable HTTP application Routing, not recommended for production environments. Default = false (bool)"
  default = false 
}

variable "kube_dashboard_enabled" {
  type = bool
  description = "(Optional) Enable Kubernetes Dashboard. Default = true (bool)"
  default = false 
}

variable "aci_connector_enabled" {
  type = bool
  description = "(Optional) Enable the use of AKS Virutal Nodes. Default = false (bool)"
  default = false 
}

variable "aci_subnet_name" {
  type = string
  description = "(Optional) Name of the subnet to add AKS Virtual Nodes to."
  default = "" 
}

variable "azure_policy_enabled" {
  type = bool
  description = "(Optional) Enable the Azure Policy for AKS. Default = false (bool)"
  default = false 
}

variable "auto_scaling" {
  type = bool
  description = "(Optional) Enable AutoScaling of VMs. Default = false (bool)"
  default = false 
}

variable "enable_node_public_ip" {
  type = bool
  description = "(Optional) Enable Node VMs to have Public IPs. Default = false (bool)"
  default = false 
}

variable "enable_pod_security" {
  type = bool
  description = "(Optional) Enable K8s Pod Security Policies RBAC is required if this is to be enabled. Default = false (bool)"
  default = false
}

variable "api_server_authorized_ip_ranges" {
  type = list
  description = "(Optional) List of IP addresses to allow for connectivity to the K8s API."
  default = []
}

variable "my_dependencies" {
  type    = list(string)
  default = []
}
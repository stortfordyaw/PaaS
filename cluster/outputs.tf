output "kube_authentication" {
  value = {
    "host"                   = azurerm_kubernetes_cluster.k8s.kube_config[0].host
    "client_key"             = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
    "client_certificate"     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
    "cluster_ca_certificate" = azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
    "cluster_username"       = azurerm_kubernetes_cluster.k8s.kube_config[0].username
    "cluster_password"       = azurerm_kubernetes_cluster.k8s.kube_config[0].password
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "aks_resource_group_name" {
  value = azurerm_kubernetes_cluster.k8s.node_resource_group
}

output "lb_ip_resource" {
  value = azurerm_kubernetes_cluster.k8s.network_profile[0].load_balancer_profile[0].effective_outbound_ips
}


output "host" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.host}"
}
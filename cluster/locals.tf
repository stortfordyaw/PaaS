locals {
  aks_cluster_name = format (
    "aks-%s-%s-%s-%s",
    var.naming_convention["reg"],
    var.naming_convention["env"],
    var.naming_convention["app"],
    var.naming_convention["no"],
  )
}

terraform {
  backend "azurerm" {}
}
module "k8s" {
	source = ".//cluster"
	azs = ["1", "2", "3"]
	dns_zone_id = "/subscriptions/bfc181d8-0a2b-483a-95eb-23944b2724f1/resourceGroups/RESOURCE_GROUP/providers/Microsoft.Network/dnszones/www.paas_2.com"
	naming_convention = {"reg":"northeurope","env":"sbx","app":"paas","no":"01"}
	resource_group_name = "lc5622315-NorthEurope-01"
	client_id = "093feb33-41c3-4b67-8da4-a97bf68f4c5f"
	client_secret = "H0SRNL73okqo-.uzMm58c2Wy_Wc~FP8I4_"
}
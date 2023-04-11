module "gke_standard_private_cluster" {
    source = "../../tf-modules/standard-private/gke-cluster"
    count = var.create_gke == "std-private" ? 1 : 0

  project_id                             = "terraformer-376507"
  cluster_name                           = "pt2-toro-ccs-mtxx-cluster"
  env                                    = "pt2"
  network                                = "default"
  subnetwork                             = "default"
  cluster_region                         = "northamerica-northeast2"
  cluster_region_zones                   = ["northamerica-northeast2-a", "northamerica-northeast2-b", "northamerica-northeast2-c"]
  node_version                           = "1.23.12-gke.100"
  default_max_pods_per_node              = 30
  cluster_ipv4_cidr                      = "198.18.208.0/20"
  service_account                        = "terrformersakey@terraformer-376507.iam.gserviceaccount.com"
  cluster_secondary_range_name           = "default"
  services_secondary_range_name          = "default"
  # cidr_block                             = var.cidr_block
  master_ipv4_cidr_block                 = "198.19.49.224/28"
  dns_cache_config_enabled               = false
  gce_persistent_disk_csi_driver_enabled = true
  gcp_filestore_csi_driver_enabled       = true
  horizontal_pod_autoscaling_enabled     = false
  http_load_balancing_enabled            = false
  cluster_autoscaling_enabled            = false
  master_global_access_config_enabled    = true
  network_policy_enabled                 = false
  machine_type                           = "e2-standard-8"
  meta_data                              = { matrixx = "engine-s1e2", disable-legacy-endpoints = "true" }
  description                            = "clusterdescription"
  cidr_blocks                            = [{ cidr_block = "10.17.174.192/28", display_name = "Bastion-subnet" }]
  resourcelimits                         = 8 

}

module "gke_standard_public_cluster" {
    source = "../../tf-modules/standard-public/gke-cluster"
    count = var.create_gke == "std-public" ? 1 : 0

  project_id                             = "terraformer-376507"
  cluster_name                           = "pt2-toro-ccs-mtxx-cluster"
  env                                    = "pt2"
  network                                = "default"
  subnetwork                             = "default"
  cluster_region                         = "northamerica-northeast2"
  cluster_region_zones                   = ["northamerica-northeast2-a", "northamerica-northeast2-b", "northamerica-northeast2-c"]
  node_version                           = "1.23.12-gke.100"
  default_max_pods_per_node              = 30
  cluster_ipv4_cidr                      = "198.18.208.0/20"
  service_account                        = "terrformersakey@terraformer-376507.iam.gserviceaccount.com"
  cluster_secondary_range_name           = "default"
  services_secondary_range_name          = "default"
  # cidr_block                             = var.cidr_block
  master_ipv4_cidr_block                 = "198.19.49.224/28"
  dns_cache_config_enabled               = false
  gce_persistent_disk_csi_driver_enabled = true
  gcp_filestore_csi_driver_enabled       = true
  horizontal_pod_autoscaling_enabled     = false
  http_load_balancing_enabled            = false
  cluster_autoscaling_enabled            = false
  master_global_access_config_enabled    = true
  network_policy_enabled                 = false
  machine_type                           = "e2-standard-8"
  meta_data                              = { matrixx = "engine-s1e2", disable-legacy-endpoints = "true" }
  description                            = "clusterdescription"
  resourcelimits                         = 8 

}


module "nodepools-std-private" {
  source = "../../tf-modules/standard-private/node-pools"
  count = var.create_gke == "std-private" ? 1 : 0

  project_id          = "terraformer-376507"
  cluster_name        = "pt2-toro-ccs-mtxx-cluster"
  gke_version         = "1.23.12-gke.100"
  cluster_region      = "northamerica-northeast2"
  #cluster_region       = module.gke-cluster.cluster_region

  #nodepools
  nodelpools = var.nodelpools
}
module "nodepools-std-public" {
  source = "../../tf-modules/standard-public/node-pools"
  count = var.create_gke == "std-public" ? 1 : 0

  project_id          = "terraformer-376507"
  cluster_name        = "pt2-toro-ccs-mtxx-cluster"
  gke_version         = "1.23.12-gke.100"
  cluster_region      = "northamerica-northeast2"
  #cluster_region       = module.gke-cluster.cluster_region

  #nodepools
  nodelpools = var.nodelpools
}

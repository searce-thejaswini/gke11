variable "node_version" {
  description = "k8s node version"
}

variable "project_id" {
  description = "project id"
}


variable "env" {

}

variable "cluster_ipv4_cidr" {
  #default     = "198.18.64.0/20"
  description = "cluster ipv4 subnet range"
}

variable "default_max_pods_per_node" {
  #default     = 30
  description = "max pods per node"
}

variable "cluster_secondary_range_name" {
  description = "native-vpc-1-mtrl-ccs-net-5-pod-np"
}

variable "services_secondary_range_name" {
  description = "native-vpc-1-mtrl-ccs-net-5-service-np"
}

# variable "cidr_block" {
#   description = "10.17.174.192/28"
# }

variable "service_account" {
  description = "default"
}

variable "master_ipv4_cidr_block" {
  description = "198.19.49.64/28"

}

variable "cluster_name" {
  description = "clsuter name"
}

variable "network" {
  description = "max number of gke nodes for autoscaling"
}

variable "subnetwork" {

}

variable "description" {

}

variable "cluster_region" {
  description = "region"
}

variable "cluster_region_zones" {
  type = list(string)

}

variable "dns_cache_config_enabled" {
  default = false
}

variable "gce_persistent_disk_csi_driver_enabled" {
  default = false
}

variable "gcp_filestore_csi_driver_enabled" {
  default = false
}

variable "horizontal_pod_autoscaling_enabled" {
  default = false
}

variable "http_load_balancing_enabled" {
  default = false
}

variable "cluster_autoscaling_enabled" {
  default = false
}

variable "master_global_access_config_enabled" {
  default = true
}

variable "network_policy_enabled" {
  default = false
}

variable "network_policy_config_disabled" {
  default = true
}

variable "cidr_blocks" {
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
}

variable "resourcelimits" {
  type = list(object({
    resource_type = string
    minimum = number
    maximum = number
  }))
}

variable "machine_type" {
  
}

variable "meta_data" {
  type = map
}


 


variable "create_gke" {
    type = string
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region - Montreal/Toronto"
}

variable "region_zones" {
  type        = list(string)
  default     = []
  description = "(optional) A list of zones of region1"
}

variable "network" {
  description = "gke cluster host vpc"
}

variable "node_version" {
  #default     = "1.23.12-gke.100"
  description = "k8s node version"
}

variable "environment" {
  description = "ccs-matrix env"
}

variable "subnetwork" {
  description = "gke cluster host subnet"
}

variable "cluster_name" {
  description = "clustr name"
}

variable "default_max_pods_per_node" {
  description = "value"
}
    
variable "cluster_ipv4_cidr" {
  description = "value"
}

variable "service_account" {
  description = "value"
  
}

variable "cluster_secondary_range_name" {
  description = "value"
}

# variable "cidr_block" {
#   description = "value"
# }

variable "services_secondary_range_name" {
  description = "value"
}

variable "master_ipv4_cidr_block" {
  description = "value"
}

variable "cluster_description" {
  
}

variable "meta_data" {
  type = map(any)
}

variable "dns_cache_config_enabled" {
  type = bool
}

variable "gce_persistent_disk_csi_driver_enabled" {
  type = bool
}

variable "gcp_filestore_csi_driver_enabled" {
  type = bool
}

variable "horizontal_pod_autoscaling_enabled" {
  type = bool
}

variable "http_load_balancing_enabled" {
  type = bool
}

variable "cluster_autoscaling_enabled" {
  type = bool
}

variable "master_global_access_config_enabled" {
  type = bool
}

variable "network_policy_enabled" {
  type = bool
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

variable "default_node_machine_type" {}
              

# node pool #####################################
variable "nodelpools" {
  description = "node pool configurations"
  type = list(object({
    autoscaling_info     = map(any)
    # max_node_count      = number
    # min_node_count      = number}))
    service_account     = string
    max_pods_per_node   = number
    name                = string
    pod_ipv4_cidr_block = string
    pod_range           = string
    initial_node_count  = number
    node_count          = number
    disk_size_gb        = number
    disk_type           = string
    image_type          = string
    machine_type        = string
    max_surge           = number
    max_unavailable     = number
    metadata            = map(any)
    node_locations      = list(string)
    placementpolicy    = map(any)
    labels              = map(any)
    tags                = list(string)
  }))
}

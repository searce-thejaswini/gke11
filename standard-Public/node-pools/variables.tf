#common  #####################################
variable "project_id" {
  description = "project id"
}

variable "cluster_region" {
  description = "region"
}

variable "cluster_name" {
  description = "clsuter name"
}

variable "gke_version" {
  description = "k8s version"
}

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



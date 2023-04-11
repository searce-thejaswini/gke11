resource "google_container_node_pool" "cluster_nodepools" {
  project       = var.project_id
  cluster       = var.cluster_name
  location      = var.cluster_region
  version       = var.gke_version

  for_each     = { for i, v in var.nodelpools : i => v } 

  node_count     = each.value.node_count
  #initial_node_count = each.value.initial_node_count
  max_pods_per_node = each.value.max_pods_per_node
  name = each.value.name
  node_locations = each.value.node_locations

  
  management {
    auto_repair = true
  }

  # network_config {
  #   pod_ipv4_cidr_block = each.value.pod_ipv4_cidr_block
  #   pod_range           = each.value.pod_range
  # }

  node_config {
    disk_size_gb = each.value.disk_size_gb
    disk_type    = each.value.disk_type
    image_type   = each.value.image_type
    machine_type = each.value.machine_type

    metadata = each.value.metadata

    oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only", 
                       "https://www.googleapis.com/auth/logging.write", 
                       "https://www.googleapis.com/auth/monitoring", 
                       "https://www.googleapis.com/auth/service.management.readonly", 
                       "https://www.googleapis.com/auth/servicecontrol", 
                       "https://www.googleapis.com/auth/trace.append"]
    service_account =each.value.service_account

    shielded_instance_config {
      enable_integrity_monitoring = true
    }
      
    workload_metadata_config {
      mode          = "GKE_METADATA"
      #node_metadata = "GKE_METADATA_SERVER"
    }

    labels = each.value.labels

    tags = each.value.tags
  }

  upgrade_settings {
    max_surge       = each.value.max_surge
    max_unavailable = each.value.max_unavailable
  }

  
  # autoscaling {
  #   min_node_count = each.value.min_node_count
  #   max_node_count = each.value.max_node_count
  # }
  dynamic "autoscaling" {
  for_each = each.value.autoscaling_info

  content {
    max_node_count   = autoscaling.key
    min_node_count   = autoscaling.value
  }
  }

  provider = google-beta
  dynamic "placement_policy" {
    for_each = each.value.placementpolicy

    content {
      type = placement_policy.value
    }

  }
  #placement_policy  { type = "COMPACT" }
}
  


resource "google_container_cluster" "searce_cluster" {
  project                   = var.project_id
  subnetwork                = var.subnetwork
  name                      = var.cluster_name
  network                   = var.network
  location                  = var.cluster_region
  node_locations            = var.cluster_region_zones
  #node_version              = var.node_version
  min_master_version        = var.node_version
  remove_default_node_pool  = true
  initial_node_count        = 1
  enable_shielded_nodes     = true
  default_max_pods_per_node = var.default_max_pods_per_node
  datapath_provider         = "LEGACY_DATAPATH"
  description               = var.description
  networking_mode = "VPC_NATIVE"

  addons_config {
    dns_cache_config {
      enabled = var.dns_cache_config_enabled
    }

    gce_persistent_disk_csi_driver_config {
      enabled = var.gce_persistent_disk_csi_driver_enabled
    }

    gcp_filestore_csi_driver_config {
      enabled = var.gcp_filestore_csi_driver_enabled
    }

    horizontal_pod_autoscaling {
      disabled = var.horizontal_pod_autoscaling_enabled
    }

    http_load_balancing {
      disabled = var.http_load_balancing_enabled
    }

    network_policy_config {
      disabled = var.network_policy_config_disabled
    }
  }

  cluster_autoscaling {
    #autoscaling_profile = "BALANCED"
    enabled = var.cluster_autoscaling_enabled

    dynamic "resource_limits" {
    for_each = var.resourcelimits

      content {
         resource_type  = resource_limits.value.resource_type
         minimum        = resource_limits.value.minimum
         maximum        = resource_limits.value.maximum
      }
    }
    # resource_limits {
    #   resource_type = "cpu"
    #   minimum = var.cpu_minimum
    #   maximum = var.cpu_maximum
    # }
    # resource_limits {
    #   resource_type = "memory"
    #   minimum = var.mem_minimum
    #   maximum = var.mem_maximum
    # }
  }

  database_encryption {
    state = "DECRYPTED"
  }

  default_snat_status {
    disabled = false
  }

  ip_allocation_policy {
    #cluster_ipv4_cidr_block       = var.cluster_ipv4_cidr_block
    cluster_secondary_range_name = var.cluster_secondary_range_name
    # services_ipv4_cidr_block      = var.services_ipv4_cidr_block
    services_secondary_range_name = var.services_secondary_range_name
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      #for_each = {for i, v in var.cidr_blocks:  i => v}
      for_each = var.cidr_blocks
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  network_policy {
    enabled  = var.network_policy_enabled
    provider = "PROVIDER_UNSPECIFIED"
  }

  # node_config {
  #   disk_size_gb = 100
  #   disk_type    = "pd-standard"
  #   image_type   = "COS_CONTAINERD"
  #   machine_type = var.machine_type

  #   #metadata = var.meta_data
  #   # metadata = {
  #   #   for key, value in var.meta_data : key => value
  #   # }
  
  #   oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  #   service_account = var.service_account

  #   shielded_instance_config {
  #     enable_integrity_monitoring = true
  #   }

  #   workload_metadata_config {
  #     mode = "GKE_METADATA"
  #     # node_metadata = "GKE_METADATA_SERVER"
  #   }
  # }

  notification_config {
    pubsub {
      enabled = false
    }
  }

  # pod_security_policy_config {
  #   enabled = false
  # }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true

    master_global_access_config {
      enabled = var.master_global_access_config_enabled
    }

    master_ipv4_cidr_block = var.master_ipv4_cidr_block
  }



  release_channel {
    channel = "UNSPECIFIED"
  }

  resource_labels = {
    environment = var.env
  }



  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

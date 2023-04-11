output "cluster_name" {
    description = "The name of cluster"
    value = google_container_cluster.searce_cluster.name
}

output "project_id" {
    description = "The projec name of cluster"
    value = google_container_cluster.searce_cluster.project 
}

output "node_version" {
    description = "The gke version of cluster"
    value = google_container_cluster.searce_cluster.node_version
}


output "cluster_region" {
   value = google_container_cluster.searce_cluster.location
}

output "cluster_region_zones" {
   value = google_container_cluster.searce_cluster.node_locations
}


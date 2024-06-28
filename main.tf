resource "hcp_hvn" "hvn" {
  hvn_id         = "hvn"
  cloud_provider = "aws"
  region         = var.region
  cidr_block     = var.hvn_cidr
}

resource "hcp_vault_cluster" "vault" {
  cluster_id = var.cluster_id
  hvn_id     = hcp_hvn.hvn.hvn_id
  tier       = var.cluster_tier

  lifecycle {
    prevent_destroy = true
  }
}
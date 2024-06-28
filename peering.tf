resource "hcp_aws_network_peering" "peer" {
  count           = var.peering == true ? 1 : 0
  hvn_id          = hcp_hvn.hvn.hvn_id
  peering_id      = "hcp-to-aws"
  peer_vpc_id     = data.aws_vpc.vpc.id
  peer_account_id = data.aws_vpc.vpc.owner_id
  peer_vpc_region = var.region
}

resource "hcp_hvn_route" "peer" {
  count            = var.peering == true ? 1 : 0
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = "hcp-to-aws"
  destination_cidr = data.aws_vpc.vpc.cidr_block
  target_link      = hcp_aws_network_peering.peer[0].self_link
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  count                     = var.peering == true ? 1 : 0
  vpc_peering_connection_id = hcp_aws_network_peering.peer[0].provider_peering_id
  auto_accept               = true
}
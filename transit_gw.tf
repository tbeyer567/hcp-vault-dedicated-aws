resource "aws_ram_resource_share" "tgw" {
  count                     = var.peering == true ? 0 : 1
  name                      = "tgw-resource-share"
  allow_external_principals = true
}

resource "aws_ram_principal_association" "tgw" {
  count              = var.peering == true ? 0 : 1
  resource_share_arn = aws_ram_resource_share.tgw[0].arn
  principal          = hcp_hvn.hvn.provider_account_id
}

resource "aws_ram_resource_association" "tgw" {
  count              = var.peering == true ? 0 : 1
  resource_share_arn = aws_ram_resource_share.tgw[0].arn
  resource_arn       = data.aws_ec2_transit_gateway.tgw.arn
}

resource "hcp_aws_transit_gateway_attachment" "tgw" {
  count = var.peering == true ? 0 : 1
  depends_on = [
    aws_ram_principal_association.tgw,
    aws_ram_resource_association.tgw
  ]
  hvn_id                        = hcp_hvn.hvn.hvn_id
  transit_gateway_attachment_id = "hcp-tgw-attachment"
  transit_gateway_id            = data.aws_ec2_transit_gateway.tgw.id
  resource_share_arn            = aws_ram_resource_share.tgw[0].arn
}

resource "hcp_hvn_route" "tgw" {
  count            = var.peering == true ? 0 : 1
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = "hvn-to-tgw"
  destination_cidr = data.aws_vpc.vpc.cidr_block
  target_link      = hcp_aws_transit_gateway_attachment.tgw[0].self_link
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "tgw" {
  count                         = var.peering == true ? 0 : 1
  transit_gateway_attachment_id = hcp_aws_transit_gateway_attachment.tgw[0].provider_transit_gateway_attachment_id
}
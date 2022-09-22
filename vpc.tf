# data "aws_availability_zones" "available" {
#   state = "available"
# }


# # creating vpc
# resource "aws_vpc" "stg-vpc" {
#   cidr_block           = "10.1.0.0/16"
#   instance_tenancy     = "default"
#   enable_dns_hostnames = "true"

#   tags = {
#     Name      = "stg-vpc"
#     terraform = "true"
#   }
# }


# # creating igw
# resource "aws_internet_gateway" "stg-igw" {
#   vpc_id = aws_vpc.stg-vpc.id

#   tags = {
#     Name = "stg-igw"
#   }
# }


# # creating subnets
# resource "aws_subnet" "stg-public" {
#   count                   = length(data.aws_availability_zones.available.names)
#   vpc_id                  = aws_vpc.stg-vpc.id
#   cidr_block              = element(var.pub-cidr, count.index)
#   map_public_ip_on_launch = "true"
#   availability_zone       = element(data.aws_availability_zones.available.names, count.index)

#   tags = {
#     Name      = "stg-public${count.index + 1} subnet"
#     terraform = "true"
#   }
# }

# resource "aws_subnet" "stg-private" {
#   count             = length(data.aws_availability_zones.available.names)
#   vpc_id            = aws_vpc.stg-vpc.id
#   cidr_block        = element(var.pri-cidr, count.index)
#   availability_zone = element(data.aws_availability_zones.available.names, count.index)

#   tags = {
#     Name      = "stg-private${count.index + 1} subnet"
#     terraform = "true"
#   }
# }

# resource "aws_subnet" "stg-data" {
#   count             = length(data.aws_availability_zones.available.names)
#   vpc_id            = aws_vpc.stg-vpc.id
#   cidr_block        = element(var.data-cidr, count.index)
#   availability_zone = element(data.aws_availability_zones.available.names, count.index)

#   tags = {
#     Name      = "stg-data${count.index + 1} subnet"
#     terraform = "true"
#   }
# }


# # creating natgw
# resource "aws_eip" "eip" {
#   vpc = true
# }

# resource "aws_nat_gateway" "stg-natgw" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.stg-public[0].id

#   tags = {
#     Name = "stg-natgw"
#   }

#   depends_on = [aws_eip.eip]
# }

# # creating route table and adding igw and natgw
# resource "aws_route_table" "stg-pub-route" {
#   vpc_id = aws_vpc.stg-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.stg-igw.id
#   }


#   tags = {
#     Name = "stg-pub-route"
#   }
# }

# resource "aws_route_table" "stg-pri-route" {
#   vpc_id = aws_vpc.stg-vpc.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.stg-natgw.id
#   }
#   tags = {
#     Name = "stg-pri-route"
#   }
# }


# # assocating subnets to route table

# resource "aws_route_table_association" "public" {
#   count          = length(aws_subnet.stg-public[*])
#   subnet_id      = element(aws_subnet.stg-public[*].id, count.index)
#   route_table_id = aws_route_table.stg-pub-route.id
# }

# resource "aws_route_table_association" "private" {
#   count          = length(aws_subnet.stg-public[*])
#   subnet_id      = element(aws_subnet.stg-private[*].id, count.index)
#   route_table_id = aws_route_table.stg-pri-route.id
# }

# resource "aws_route_table_association" "data" {
#   count          = length(aws_subnet.stg-public[*])
#   subnet_id      = element(aws_subnet.stg-data[*].id, count.index)
#   route_table_id = aws_route_table.stg-pri-route.id
# }



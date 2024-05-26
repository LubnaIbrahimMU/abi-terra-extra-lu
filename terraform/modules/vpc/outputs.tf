output "vpc_id" {
  value = aws_vpc.abi-lu.id
}

# output "public_subnet_ids" {
#   value = [
#     aws_subnet.public-lu1.id,
#     aws_subnet.public-lu2.id
#   ]
# }



output "public_subnet_id" {
  value = aws_subnet.public-lu1.id
}
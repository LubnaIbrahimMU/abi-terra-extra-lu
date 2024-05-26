
output "key" {
  value = aws_key_pair.key
}



output "private_key_pem" {
  value     = tls_private_key.pk.private_key_pem
  sensitive = true
}


output "instance_ids" {
  value = [for i in aws_instance.lu-ab : i.id]
}

output "instance_ips" {
  value = aws_instance.lu-ab[*].public_ip
}

# output "instance_ids" {
#   value = aws_instance.lu-ab[*].id
# }
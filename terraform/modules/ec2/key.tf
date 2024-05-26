resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key" {
  key_name   = "lu00"
  public_key = tls_private_key.pk.public_key_openssh

  #   provisioner "local-exec" 


  provisioner "local-exec" {
    command = <<EOT
    rm -f ../ansible/lu00.pem
    echo '${tls_private_key.pk.private_key_pem}' > ../ansible/lu00.pem
    chmod 400 ../ansible/lu00.pem
  EOT
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = all
  }



}
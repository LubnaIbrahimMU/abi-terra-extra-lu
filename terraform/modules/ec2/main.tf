#Create EC2
resource "aws_instance" "lu-ab" {
  count                       = 2
  ami                         = var.image_id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  key_name                    = "lu00"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]

  tags = {
    Name = "lu-ab${count.index + 1}"
  }



  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> ../ansible/inventory"
  }
}

# Initialize the inventory file
resource "null_resource" "initialize_inventory" {
  provisioner "local-exec" {
    command = "echo '[lu-ab]' > ../ansible/inventory"
  }
}

# Wait for instances to be ready
resource "null_resource" "wait_for_instance" {
  depends_on = [aws_instance.lu-ab]

  provisioner "local-exec" {
    command = "sleep 30"
  }
}

# Run the Ansible playbook after all instances are created
resource "null_resource" "ansible_playbook" {
  depends_on = [null_resource.wait_for_instance]


  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory --private-key ../ansible/lu00.pem ../ansible/wordpress.yml -vvvv"
  }

  # provisioner "local-exec" {
  #   command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory --private-key ../ansible/lu00.pem ../ansible/wordpress.yml "
  # }





}

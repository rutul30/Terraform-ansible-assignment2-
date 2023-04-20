resource "null_resource" "ansible_provisioner" {
  count = var.nb_count

  triggers = {
    # Trigger the provisioner whenever the public IP address changes
    instance_public_ip = azurerm_public_ip.linux-pip[count.index].ip_address
  }

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux-pip[count.index].ip_address
    user        = "rj3099"
    private_key = file("/home/rutul/.ssh/id_rsa")
    timeout     = "2m"
  }

  provisioner "local-exec" {
  command = "ssh-keyscan ${azurerm_public_ip.linux-pip[count.index].ip_address} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${azurerm_public_ip.linux-pip[count.index].ip_address},' -u ${var.admin_username} --private-key=${var.private_key_path} ./ansible/groupX-playbook.yml"
     
  }
}
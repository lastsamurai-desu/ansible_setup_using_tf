resource "null_resource" "vscode-config" {
  depends_on = [time_sleep.wait_for_instance]

  provisioner "local-exec" {
    command = templatefile("${var.os}-ssh-script.tpl", {
      hostname        = aws_instance.ubuntu.public_ip
      user            = "ansible",
      IdentityFile    = var.my_key_path
      SSH_CONFIG_PATH = var.ssh_config_path_windows
    })
    interpreter = var.os == "windows" ? ["powershell", "-Command"] : ["bash", "-c"]
  }
}

resource "time_sleep" "wait_for_instance" {
  create_duration = "180s"

  depends_on = [aws_instance.ubuntu]
}

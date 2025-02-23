
build {
  sources = [
    "source.azure-arm.vm"
  ]

  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "apt-get update",
      "apt-get clean"
    ]
  }

  # We use CURL to grab the server download page from Minecraft.net. With this page, we can scan it and make sure we are grabbing the latest download link.
  # This saves time by ensuring the latest version is always downloaded.
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["apt-get -y install curl"]
  }

  # The wget package is what we will use to download the Minecraft Bedrock server to Ubuntu.
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["apt-get -y install wget"]
  }

  # This package is the simplest package we are installing and is what we need to extract the server from the downloaded archive.
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "apt-get update",
      "apt-get -y install unzip"
    ]
  }

  # We use the grep package to extract the correct download link from the page we grabbed using curl.
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["apt-get -y install grep"]
  }

  # Screen will make accessing the servers command line easier remotely when we run the server as a service.
  # This package allows us to create a detached screen where the Bedrock server will run.
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["apt-get -y install screen"]
  }

  # The Minecraft Bedrock server requires the OpenSSL library to run.
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["apt-get -y install openssl"]
  }

  # required by Minecraft Bedrock
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -O libssl1.1.deb",
      "dpkg -i libssl1.1.deb",
      "rm libssl1.1.deb"
      ]
  }

  # Setup Minecraft User Account
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "useradd -m mcserver",
      "usermod -a -G mcserver $USER",
      "mkdir -p /home/mcserver/minecraft_bedrock"
      ]
  }

  # Download/Install latest version of Minecraft
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "randomint=$(tr -dc 0-9 < /dev/urandom 2>/dev/null | head -c 4 | xargs)",
      "DOWNLOAD_URL=$(curl -H \"Accept-Encoding: identity\" -H \"Accept-Language: en\" -s -L -A \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$${randomint}.212 Safari/537.36\" https://www.minecraft.net/en-us/download/server/bedrock/ |  grep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/[^\"]*')",
      "curl -o /home/mcserver/minecraft_bedrock/bedrock-server.zip -H \"Accept-Encoding: identity\" -H \"Accept-Language: en\" -s -L -A \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$${randomint}.212 Safari/537.36\" \"$DOWNLOAD_URL\"",
      "unzip /home/mcserver/minecraft_bedrock/bedrock-server.zip -d /home/mcserver/minecraft_bedrock/",
      "rm /home/mcserver/minecraft_bedrock/bedrock-server.zip",
      "chown -R mcserver: /home/mcserver/"
      ]
  }

  # Minecraft start_server.sh
  provisioner "file" {
    source = "./files/start_server.sh"
    destination = "/tmp/start_server.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/start_server.sh /home/mcserver/minecraft_bedrock/",
      "chmod +x /home/mcserver/minecraft_bedrock/start_server.sh"
    ]
  }

  # Minecraft stop_server.sh
  provisioner "file" {
    source = "./files/stop_server.sh"
    destination = "/tmp/stop_server.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/stop_server.sh /home/mcserver/minecraft_bedrock/",
      "chmod +x /home/mcserver/minecraft_bedrock/stop_server.sh"
    ]
  }

  # Minecraft restore.sh
  provisioner "file" {
    source = "./files/mcops-restore.sh"
    destination = "/tmp/mcops-restore.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/mcops-restore.sh /home/mcserver/minecraft_bedrock/",
      "chmod +x /home/mcserver/minecraft_bedrock/mcops-restore.sh"
    ]
  }

  # Minecraft upgrade.sh
  provisioner "file" {
    source = "./files/mcops-upgrade.sh"
    destination = "/tmp/mcops-upgrade.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/mcops-upgrade.sh /home/mcserver/minecraft_bedrock/",
      "chmod +x /home/mcserver/minecraft_bedrock/mcops-upgrade.sh"
    ]
  }

  # Minecraft systemctl service
  provisioner "file" {
    source = "./files/mcbedrock.service"
    destination = "/tmp/mcbedrock.service"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["cp /tmp/mcbedrock.service /etc/systemd/system/"]
  }
  
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["chown -R mcserver: /home/mcserver/"]
  }


  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    only = ["azure-arm"]
  }

}
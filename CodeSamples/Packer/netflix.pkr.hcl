packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

source "azure-arm" "netflix" {
  # Auth to Azure
  client_id                         = "22235162-a3b7-46ff-8c26-6fa7d263c984"
  client_secret                     = "OiJ8Q~4kJWaCc1RanQstRnXH7ieH6IpC0VHiSbQW"
  subscription_id                   = "1075ec7a-b17a-4f37-bf3f-9d68c4506dc1"
  tenant_id                         = "0f7010fd-209e-4344-8457-043ffb37143b"

  # Base Image
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_publisher                   = "canonical"
  image_sku                         = "22_04-lts"

  # Temporary VM Details
  location                          = "East US"
  os_type                           = "Linux"
  vm_size                           = "Standard_DS2_v2"

  # Final Image Details
  managed_image_resource_group_name = "rg-devopsinsiders"
  managed_image_name                = "netflix-image"
}

build {
  sources = ["source.azure-arm.netflix"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline          = ["apt-get update", "apt-get upgrade -y", "apt-get -y install nginx","cd /tmp", "git clone https://github.com/devopsinsiders/StreamFlix.git","cp -r /tmp/StreamFlix/* /var/www/html", "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    inline_shebang  = "/bin/sh -x"
  }
}
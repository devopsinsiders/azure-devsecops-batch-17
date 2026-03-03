# =========================
# Variables
# =========================
$RG = "Demo-RG"
$Location = "centralindia"

$VNet = "Demo-VNet"
$VNetPrefix = "10.0.0.0/8"

$FrontSubnet = "Frontend-Subnet"
$FrontPrefix = "10.0.1.0/24"

$BackSubnet = "Backend-Subnet"
$BackPrefix = "10.0.196.0/24"

$NSG = "Backend-NSG"

$VM1 = "vm001"
$VM2 = "vm002"

$AdminUser = "devopsadmin"
$AdminPass = "P@ssw01rd@123"   # Change for production!


# =========================
# Create Resource Group
# =========================
az group create `
    --name $RG `
    --location $Location

# =========================
# Create VNet + Frontend Subnet
# =========================
az network vnet create `
    --resource-group $RG `
    --name $VNet `
    --address-prefix $VNetPrefix `
    --subnet-name $FrontSubnet `
    --subnet-prefix $FrontPrefix

# =========================
# Create Backend Subnet
# =========================
az network vnet subnet create `
    --resource-group $RG `
    --vnet-name $VNet `
    --name $BackSubnet `
    --address-prefix $BackPrefix

# =========================
# Create NSG
# =========================
az network nsg create `
    --resource-group $RG `
    --name $NSG

# =========================
# Allow SSH from Frontend to Backend
# =========================
az network nsg rule create `
    --resource-group $RG `
    --nsg-name $NSG `
    --name Allow-Frontend-To-Backend-SSH `
    --priority 100 `
    --source-address-prefixes 10.0.1.0/24 `
    --destination-address-prefixes 10.0.196.0/24 `
    --destination-port-ranges 22 `
    --protocol Tcp `
    --access Allow

# =========================
# Associate NSG to Backend Subnet
# =========================
az network vnet subnet update `
    --resource-group $RG `
    --vnet-name $VNet `
    --name $BackSubnet `
    --network-security-group $NSG

# =========================
# Create Public IP for VM1
# =========================
az network public-ip create `
    --resource-group $RG `
    --name vm1-pip `
    --allocation-method Static

# =========================
# Create VM1 (Frontend) with Public IP
# =========================
az vm create `
    --resource-group $RG `
    --name $VM1 `
    --image Ubuntu2204 `
    --admin-username $AdminUser `
    --admin-password $AdminPass `
    --vnet-name $VNet `
    --subnet $FrontSubnet `
    --public-ip-address vm1-pip

# =========================
# Create VM2 (Backend) without Public IP
# =========================
az vm create `
    --resource-group $RG `
    --name $VM2 `
    --image Ubuntu2204 `
    --admin-username $AdminUser `
    --admin-password $AdminPass `
    --vnet-name $VNet `
    --subnet $BackSubnet `
    --public-ip-address "" `
    --nsg ""
# 🧾 **1. Create an Azure VM**

You can create a VM via the Azure Portal or CLI.

## ✅ Using Azure CLI:

```bash
# Login to Azure
az login

# Create a resource group (optional if you have one)
az group create --name MyResourceGroup --location eastus

# Create a VM
az vm create \
  --resource-group MyResourceGroup \
  --name MyVM \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys
```

## ✅ Open Port 80 for HTTP (Nginx)

```bash
az vm open-port \
  --resource-group MyResourceGroup \
  --name MyVM \
  --port 80
```

---

# 🔐 **2. SSH into the Azure VM**

```bash
ssh azureuser@<public-ip-of-your-vm>
```

* Replace `<public-ip-of-your-vm>` with the actual IP shown after VM creation (`publicIpAddress` field in CLI output).

---

## 🌐 **3. Install Nginx**

Once logged into the VM:

```bash
# Update package index
sudo apt update

# Install Nginx
sudo apt install nginx -y
```

* Nginx will automatically start and enable on boot.

---

## 📄 **4. Copy the `index.html` for the Love Calculator**

Assuming you have an `index.html` file locally:

## Option 1: Use `scp` to copy from your local machine

```bash
scp ./index.html azureuser@<public-ip-of-your-vm>:/tmp/
```

Then SSH into the VM and move it:

```bash
sudo mv /tmp/index.html /var/www/html/index.html
```

## Option 2: Create/Edit directly on the VM

```bash
sudo nano /var/www/html/index.html
```

Paste the content of your `love calculator` HTML file and save.

---

# ✅ **5. Test Your Setup**

* In your browser, go to: `http://<public-ip-of-your-vm>`
* You should see the love calculator web page.

---

## 🔄 **(Optional) Restart Nginx**

```bash
sudo systemctl restart nginx
```
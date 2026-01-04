# Class Notes: Introduction to Terraform

## 🌱 Started Learning Terraform

- Terraform is an open-source infrastructure as code software tool created by HashiCorp.
- It allows users to define and provision data center infrastructure using a high-level configuration language known as HashiCorp Configuration Language (HCL), or optionally JSON.

## 🧐 How to Do Google Search

- Using Google search effectively can help in finding solutions to Terraform-related problems.
- It's important to use specific keywords related to the issue to get relevant results.

## 🛠 Installing Terraform on Windows

1. **Download Terraform:**
   - Visit the [Terraform Downloads page](https://www.terraform.io/downloads.html) and download the appropriate `terraform.exe` for Windows.
  
2. **Extract the Executable:**
   - Unzip the downloaded file to extract `terraform.exe`.

3. **Add to PATH:**
   - Move `terraform.exe` to a directory of your choice (e.g., `C:\Terraform`).
   - Open the Start Menu, search for “Environment Variables” and select "Edit the system environment variables".
   - In the System Properties window, click on **Environment Variables**.
   - Under **System variables**, select **Path** and click **Edit...**.
   - Click **New** and add the path to the directory containing `terraform.exe` (e.g., `C:\Terraform`).
   - Click **OK** to close all windows.

4. **Verify Installation:**
   - Open a new Command Prompt and run:
     ```cmd
     terraform --version
     ```
   - Confirm that Terraform's version is displayed.
  
To be continued...
# Deploy Starbucks Clone on Nginx Server

1. **Access the Killerkoda Ubuntu Playground:**
   - Open your web browser and navigate to [Killerkoda Ubuntu Playground](https://killercoda.com/playgrounds/scenario/ubuntu).

![alt text](images/image.png)

2. **Initialize the Playground:**
   - Click on the "Start" button to initialize the Ubuntu environment.

![alt text](images/image-1.png)

3. **Update the System:**
   - Once the playground is ready, update the package list by running:
     ```sh
     sudo apt update
     ```
![alt text](images/image-2.png)

4. **Install Nginx:**
   - Install Nginx web server:
     ```sh
     sudo apt install nginx -y
     ```
![alt text](images/image-3.png)

5. **Clone the Starbucks Clone Repository:**
   - Clone the repository containing the build artifacts:
     ```sh
     git clone https://github.com/devopsinsiders/starbucks-clone.git
     ```
![alt text](images/image-4.png)

6. **Copy Build Artifacts to Nginx Directory:**
   - Navigate to the cloned repository:
     ```sh
     cd starbucks-clone
     ```
![alt text](images/image-5.png)

   - Copy the build artifacts to the Nginx web root directory:
     ```sh
     sudo cp -r * /var/www/html/
     ```
![alt text](images/image-6.png)

7. **Check Nginx Status:**
   - Check Nginx  Status:
     ```sh
     sudo systemctl status nginx
     ```
![alt text](images/image-7.png)

9. **Expose Port 80:**
    - In the Killerkoda interface, look for the option to expose a port. This is typically done by clicking on an option labeled "Expose" or similar and then selecting or entering port `80`.

![alt text](images/image-8.png)

10. **Access Starbucks Clone:**
    - Once port 80 is exposed, you should see a URL or a button to open the application in a new tab. Click on it, and you should be able to access the Starbucks Clone application.

![alt text](images/image-9.png)

![alt text](images/image-10.png)

By following these steps, the Starbucks Clone application should be deployed and accessible via port 80 on the Killerkoda Ubuntu playground.


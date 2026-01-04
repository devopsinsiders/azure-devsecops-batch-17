# 🛠️ Understanding the NPM Build Process in React

### Why Do We Need to Build React Apps?

Modern frameworks like **React** allow us to write code using **JSX (JavaScript + HTML)**, and use features like **modules, ES6 syntax, imports, components**, etc. But here's the catch:

> **Browsers can't directly understand React or JSX code.**
> They only understand:

* **HTML**
* **CSS**
* **JavaScript (plain, ES5-compatible)**

So, to make our React app browser-ready, we need to:

1. **Convert JSX → JavaScript**
2. **Bundle all JS files together**
3. **Minify and optimize files**
4. **Prepare static files that the browser can load directly**

This is where the **NPM build process** comes in.

---

### 📦 What Happens During `npm run build`?

When you run:

```bash
npm run build
```

React (via **Webpack and Babel**) does the following:

| Step             | Description                                                                          |
| ---------------- | ------------------------------------------------------------------------------------ |
| 🔄 Transpilation | Converts JSX and ES6+ syntax to plain JavaScript using Babel                         |
| 📦 Bundling      | Combines all components and modules into a few files (e.g., `main.js`) using Webpack |
| ⚙️ Optimization  | Minifies and compresses files to make them smaller and faster to load                |
| 📁 Output        | Generates static files (HTML, CSS, JS) in the `build/` directory                     |

After this, your app is just static content ready to be served by **any web server**.

---

### 📤 Why Deploy to `/var/www/html` on Nginx?

Nginx is a fast, reliable **static web server**. It doesn’t care whether your app was built using React or anything else — it just serves files.

Once your app is built:

1. You get a folder like this:

   ```
   build/
   ├── index.html
   ├── static/
   │   ├── js/
   │   └── css/
   └── favicon.ico
   ```

2. Copy all files from the `build/` directory to Nginx's web root:

   ```bash
   sudo cp -r build/* /var/www/html/
   ```

3. When users visit your app's URL, Nginx serves the `index.html`, and the browser loads the CSS and JS to render the UI.

---

### Summary 📘

* Browsers understand only **HTML, CSS, and JS**
* React apps need to be **built** using `npm run build` to convert JSX → browser-compatible code
* The build output is a set of static files
* These files are deployed to `/var/www/html` for **Nginx** to serve them
Great! Since you're using **password-based authentication**, your `scp` and `ssh` commands will **prompt for a password** instead of requiring a private key. Here's the updated section you can **add under "Deployment 🚀"** in your README:


### Deployment 🚀

5. **Deploy to Nginx Server (Azure VM):**

   #### 📦 Step 1: Copy Build Artifacts to Azure VM

   After building the project with `npm run build`, copy the generated static files to your Azure VM using the `scp` command:

   ```bash
   scp -r build/* azureuser@<Azure_VM_Public_IP>:/tmp/build/
   ```

   Replace `<Azure_VM_Public_IP>` with your actual VM's public IP. This will prompt you to enter your VM password.

   #### 🖥️ Step 2: SSH into Azure VM and Deploy to Nginx

   ```bash
   ssh azureuser@<Azure_VM_Public_IP>
   ```

   Then run the following commands on the VM:

   ```bash
   sudo rm -rf /var/www/html/*
   sudo cp -r /tmp/build/* /var/www/html/
   sudo systemctl restart nginx
   ```

   This will replace the old frontend with the newly built React app and restart Nginx to apply changes.


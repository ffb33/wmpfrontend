dnf module disable nginx -y
dnf module enable nginx:1.26 -y
dnf install -y nginx

echo ""Start & Enable Nginx service.""

systemctl enable nginx
systemctl start nginx

echo "'Node.js is required to build the frontend application from source."""


curl -fsSL https://rpm.nodesource.com/setup_22.x | bash -
dnf install -y nodejs


echo "" Verify the installation. ""

node --version
npm --version

#### Download & Build and Download the frontend source code to a temporary directory.""

curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz
mkdir -p /tmp/frontend
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz


echo "" Install dependencies and build.""

cd /tmp/frontend
npm ci
npm run build


echo ""Remove the default Nginx content and copy the built frontend.""

rm -rf /usr/share/nginx/html/*
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/

### Configure Nginx ##


echo ""restart service""

systemctl restart nginx
#!/bin/bash

echo "Updating packages..."
sudo yum update -y

echo "Installing Apache..."
sudo yum install httpd -y

echo "Starting Apache..."
sudo systemctl start httpd

echo "Enabling Apache..."
sudo systemctl enable httpd

echo "Creating sample homepage..."

cat <<EOF | sudo tee /var/www/html/index.html

<html>
<head>
<title>Enterprise Infrastructure Deployment</title>
</head>

<body>

<h1>Enterprise Cloud Infrastructure Deployment & Administration</h1>

<p>Apache Web Server Successfully Deployed on Amazon Linux EC2.</p>

</body>

</html>

EOF

echo "Apache deployment complete."
# Enterprise Cloud Infrastructure Deployment Guide

---

# Table of Contents

1. Prerequisites
2. AWS Account Setup
3. IAM Configuration
4. Launch Amazon EC2
5. Connect to EC2
6. Update Linux
7. Install Apache HTTP Server
8. Deploy Website
9. Linux User Administration
10. Amazon S3 Configuration
11. Backup Automation
12. Cron Scheduling
13. Server Health Monitoring
14. Amazon EBS Snapshot
15. Documentation
16. Verification
17. Cleanup
18. Troubleshooting

---

# Project Overview

This guide explains every step required to recreate the complete infrastructure used in this repository.

The deployment includes:

- Amazon EC2
- Amazon Linux 2023
- Apache HTTP Server
- IAM
- Security Groups
- Amazon S3
- Amazon EBS Snapshot
- AWS CLI
- Bash Automation
- Cron Scheduler

By following this document another engineer should be able to reproduce the entire project from scratch.

---

# 1. Prerequisites

Before beginning, ensure you have the following.

## AWS Account

Create an AWS account.

https://aws.amazon.com/

---

## AWS Free Tier

This project is designed to run using AWS Free Tier eligible services.

---

## Software Required

Windows

- Windows Terminal
- VS Code
- Git
- WinSCP (optional)

Linux

- SSH Client

---

## Basic Knowledge

Recommended

- Linux Basics
- AWS Console
- Terminal Commands

---

# 2. AWS Account Setup

## Step 1

Login to AWS Console.

Open

```
https://console.aws.amazon.com/
```

---

## Step 2

Open

```
IAM
```

---

## Step 3

Enable Multi Factor Authentication (MFA)

Purpose

Protect the AWS Root Account.

Verification

Your AWS account should display

```
MFA Enabled
```

---

# 3. IAM Configuration

Although the AWS Root account can perform administrative tasks, it should never be used for day-to-day infrastructure management.

Instead, create an IAM Administrator User.

---

## Create IAM User

Navigate

```
IAM

↓

Users

↓

Create User
```

Name

```
admin
```

Enable

```
Provide user access to AWS Management Console
```

Permissions

```
AdministratorAccess
```

Purpose

Using an IAM user instead of the Root account follows AWS security best practices and minimizes risk.

Verification

Login using the newly created IAM user before continuing.

---

# 4. Launch Amazon EC2

Navigate

```
EC2

↓

Instances

↓

Launch Instance
```

Instance Name

```
aegis-linux-web
```

Amazon Machine Image (AMI)

```
Amazon Linux 2023
```

Instance Type

```
t3.micro
```

Key Pair

Create a new key pair.

Download

```
aegis-key.pem
```

Store this file securely.

It will be required whenever connecting through SSH or WinSCP.

Never upload the PEM file to GitHub.

---

Security Group

Allow

SSH

```
22
```

HTTP

```
80
```

Leave all other inbound rules disabled.

Purpose

SSH allows administrative access.

HTTP allows visitors to access the hosted website.

Verification

After launching the instance the status should become

```
Running
```

with

```
2/2 Status Checks Passed
```
---

# 5. Connect to the EC2 Instance

Once the EC2 instance reaches the **Running** state, it is ready for administration.

There are multiple methods available to connect.

## Method 1 – EC2 Instance Connect (Recommended)

Navigate to:

```
EC2
↓
Instances
↓
Select your instance
↓
Connect
↓
EC2 Instance Connect
↓
Connect
```

This opens a browser-based Linux terminal without requiring any additional software.

---

## Method 2 – Windows Terminal (SSH)

If you downloaded the key pair during instance creation, connect using SSH.

```bash
ssh -i "aegis-key.pem" ec2-user@<Public-IP>
```

Example:

```bash
ssh -i "aegis-key.pem" ec2-user@15.xxx.xxx.xxx
```

---

## Verify the Connection

Run the following commands:

```bash
hostname
whoami
pwd
```

Expected Output

```
aegis-linux-web
ec2-user
/home/ec2-user
```

These commands confirm:

- You are connected to the correct server.
- You are logged in as the correct user.
- Your current working directory.

---

# 6. Update the Operating System

Before installing any software, update the operating system.

```bash
sudo dnf update -y
```

Purpose

- Install the latest security patches.
- Update installed packages.
- Ensure package compatibility.

Expected Output

```
Complete!
```

Verification

Check the operating system version.

```bash
cat /etc/os-release
```

Example Output

```
PRETTY_NAME="Amazon Linux 2023"
```

---

# 7. Install Apache HTTP Server

Apache will be used to host the website.

Install Apache.

```bash
sudo dnf install httpd -y
```

Expected Output

```
Complete!
```

---

## Start Apache

```bash
sudo systemctl start httpd
```

Purpose

Starts the Apache service immediately.

---

## Enable Apache on Boot

```bash
sudo systemctl enable httpd
```

Purpose

Ensures Apache automatically starts after every reboot.

---

## Verify Apache Status

```bash
sudo systemctl status httpd
```

Expected Output

```
Active: active (running)
```

If Apache is not running:

```bash
sudo systemctl restart httpd
```

Check again.

---

# 8. Deploy the Website

Navigate to the Apache web root.

```bash
cd /var/www/html
```

Confirm your location.

```bash
pwd
```

Expected Output

```
/var/www/html
```

---

## Create the Homepage

Open the default page.

```bash
sudo nano index.html
```

Replace the existing content with your custom HTML page.

Save the file.

```
Ctrl + O
Enter
Ctrl + X
```

---

## Verify Locally

```bash
curl localhost
```

Expected Output

Your HTML page should be displayed directly inside the terminal.

---

## Verify Through Browser

Open:

```
http://<Public-IP>
```

Example

```
http://15.xxx.xxx.xxx
```

If the webpage loads successfully, Apache has been configured correctly.

---

### Common Errors

#### Browser shows "This site can't be reached"

Possible causes:

- EC2 instance is stopped.
- Wrong Public IP.
- HTTP not allowed in Security Group.

---

#### Connection Refused

Check Apache.

```bash
sudo systemctl status httpd
```

If inactive:

```bash
sudo systemctl start httpd
```

---

#### Permission Denied

Verify file permissions.

```bash
ls -l /var/www/html
```

---

# 9. Linux User Administration

A production Linux server should never rely on a single administrator account.

Create additional users.

```bash
sudo adduser devops
sudo adduser support
```

Verify.

```bash
id devops
id support
```

Expected Output

```
uid=...
gid=...
groups=...
```

---

## Grant Administrative Privileges

```bash
sudo usermod -aG wheel devops
```

Purpose

Adds the **devops** user to the administrative group.

Verify.

```bash
groups devops
```

Expected Output

```
devops wheel
```

---

## Verify User Information

```bash
cat /etc/passwd | grep devops
```

This confirms the account was successfully created.

---

### Why Multiple Users?

Using separate Linux accounts improves security by:

- Tracking user activity.
- Preventing shared administrator credentials.
- Following the principle of least privilege.
---

# 10. Configure Amazon S3

The next objective is to configure cloud-based backup storage.

Instead of storing backup files only on the EC2 instance, backups will be uploaded to Amazon S3. This provides durable, highly available storage and simulates a common enterprise backup workflow.

---

## Create an Amazon S3 Bucket

Navigate to:

```
AWS Console
↓
Amazon S3
↓
Create Bucket
```

Bucket Name

```
preethi-aegis-backups-2026
```

*(Use a globally unique bucket name if this one is unavailable.)*

Region

Select the same AWS Region as your EC2 instance.

Leave the remaining settings at their default values for this project.

Click:

```
Create Bucket
```

---

## Verify Bucket Creation

Open the bucket.

It should initially be empty.

Verification

```
Bucket Created Successfully
```

---

# 11. Configure IAM Role for EC2

Instead of storing AWS Access Keys on the server, the EC2 instance will authenticate using an IAM Role.

This is considered an AWS security best practice because credentials are automatically managed by AWS and are never stored on the server.

---

## Create IAM Role

Navigate to:

```
IAM
↓
Roles
↓
Create Role
```

Trusted Entity

```
AWS Service
```

Use Case

```
EC2
```

Permissions

Attach the following managed policy:

```
AmazonS3FullAccess
```

Role Name

```
EC2-S3-Backup-Role
```

Click

```
Create Role
```

---

## Attach the IAM Role

Navigate to

```
EC2
↓
Instances
↓
Actions
↓
Security
↓
Modify IAM Role
```

Select

```
EC2-S3-Backup-Role
```

Click

```
Update IAM Role
```

---

## Verify IAM Role

Connect to the EC2 instance.

Run:

```bash
aws sts get-caller-identity
```

Expected Output

```json
{
    "Account": "...",
    "Arn": "...",
    "UserId": "..."
}
```

This confirms that the EC2 instance can securely authenticate with AWS.

---

## Verify AWS CLI

Amazon Linux 2023 includes AWS CLI by default.

Run:

```bash
aws --version
```

Expected Output

```text
aws-cli/2.x.x
```

---

# 12. Create the Backup Automation Script

Navigate to the home directory.

```bash
cd ~
```

Create the script.

```bash
nano backup_to_s3.sh
```

Paste the following:

```bash
#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)

cp /var/www/html/index.html backup-$DATE.html

aws s3 cp backup-$DATE.html s3://preethi-aegis-backups-2026/

echo "Backup completed at $(date)"
```

Save the file.

```
Ctrl + O

Enter

Ctrl + X
```

---

## Make the Script Executable

```bash
chmod +x backup_to_s3.sh
```

Verification

```bash
ls -l backup_to_s3.sh
```

Expected Output

```
-rwxr-xr-x
```

The **x** permission confirms the script can be executed.

---

## Execute the Script

```bash
./backup_to_s3.sh
```

Expected Output

```
upload: ./backup-2026-xx-xx.html to s3://...
Backup completed at ...
```

---

## Verify the Upload

```bash
aws s3 ls s3://preethi-aegis-backups-2026/
```

Expected Output

```
backup-2026-xx-xx.html
```

If the backup file appears, the upload was successful.

---

### Common Errors

#### Access Denied

Cause

IAM Role is missing or does not have S3 permissions.

Solution

Verify the IAM Role is attached to the EC2 instance and includes the required S3 permissions.

---

#### Bucket Does Not Exist

Cause

Incorrect bucket name.

Solution

Confirm the bucket name exactly matches the name used in the script.

---

#### AWS CLI Cannot Find Credentials

Cause

IAM Role has not propagated yet.

Solution

Wait a few minutes after attaching the IAM Role, then run:

```bash
aws sts get-caller-identity
```

again.

---

# Why Use Amazon S3?

Amazon S3 provides durable object storage that is commonly used for:

- Application backups
- Log storage
- Static website assets
- Disaster recovery
- Data archival

Using S3 instead of storing backups locally protects data even if the EC2 instance is terminated.
---

# 13. Schedule Automatic Backups Using Cron

The backup script currently requires manual execution.

To automate the process, Linux Cron can be used to execute the script at scheduled intervals.

---

## Open Cron Editor

```bash
crontab -e
```

If prompted for an editor, choose:

```
nano
```

---

## Add the Following Entry

```cron
0 2 * * * /home/ec2-user/backup_to_s3.sh
```

Meaning

| Field | Value | Description |
|-------|-------|-------------|
| Minute | 0 | At minute 0 |
| Hour | 2 | 2 AM |
| Day | * | Every day |
| Month | * | Every month |
| Weekday | * | Every day of the week |

---

## Save

Nano

```
Ctrl + O

Enter

Ctrl + X
```

---

## Verify

```bash
crontab -l
```

Expected Output

```cron
0 2 * * * /home/ec2-user/backup_to_s3.sh
```

---

## Why Cron?

Cron allows Linux administrators to automate repetitive administrative tasks such as:

- backups
- log cleanup
- monitoring
- package updates
- maintenance jobs

---

# 14. Server Health Monitoring

Routine monitoring helps administrators identify infrastructure issues before they impact users.

Create a health check script.

```bash
nano server_health_check.sh
```

Paste the health check script included in this repository.

---

## Make Executable

```bash
chmod +x server_health_check.sh
```

---

## Execute

```bash
./server_health_check.sh
```

The report displays:

- Current date and time
- Hostname
- Logged-in user
- System uptime
- Operating system
- Kernel version
- Memory usage
- Disk usage
- Mounted storage devices
- Apache status
- Running services
- Network interfaces
- Listening ports
- Public IP address

---

## Verification

A successful execution should end with

```
Health Check Completed Successfully
```

---

# 15. Create an Amazon EBS Snapshot

Snapshots provide point-in-time backups of an EBS volume.

Navigate to

```
EC2

↓

Volumes

↓

Select Root Volume

↓

Actions

↓

Create Snapshot
```

Description

```
Initial Infrastructure Backup
```

Click

```
Create Snapshot
```

---

## Verify

Navigate

```
EC2

↓

Snapshots
```

Status

```
Completed
```

---

## Why Snapshots?

Snapshots provide:

- disaster recovery

- data protection

- infrastructure restoration

- backup versioning

---

# 16. Generate Project Documentation

Generate a list of installed packages.

```bash
rpm -qa > installed-packages.txt
```

---

Generate a system report.

```bash
echo "===== SERVER REPORT =====" > system-report.txt

date >> system-report.txt

hostname >> system-report.txt

uptime >> system-report.txt

free -h >> system-report.txt

df -h >> system-report.txt

lsblk >> system-report.txt
```

---

Verify.

```bash
cat system-report.txt
```

---

# 17. Package Project Files

Create folders.

```bash
mkdir -p ~/project-docs/scripts

mkdir -p ~/project-docs/configs

mkdir -p ~/project-docs/backups

mkdir -p ~/project-docs/logs
```

Copy project files.

```bash
cp backup_to_s3.sh ~/project-docs/scripts/

cp server_health_check.sh ~/project-docs/scripts/
```

Archive the project.

```bash
cd ~/project-docs

zip -r project-files.zip .
```

Verification

```bash
ls
```

Expected

```
project-files.zip
```

---

# 18. Final Verification Checklist

Before publishing the project verify the following.

## AWS

- EC2 Running

- Apache Running

- S3 Bucket Created

- IAM Role Attached

- Backup Uploaded Successfully

- Snapshot Created

---

## Linux

- Apache Running

- Users Created

- Permissions Configured

- Backup Script Working

- Health Script Working

- Cron Working

---

## Documentation

- README Completed

- Deployment Guide Completed

- Commands Reference Added

- Screenshots Added

- Architecture Diagram Added

---

# 19. Cleanup

After the project has been documented and pushed to GitHub, remove AWS resources to avoid unnecessary charges.

Terminate EC2 Instance

```
EC2

↓

Instances

↓

Terminate Instance
```

Delete Snapshot

```
EC2

↓

Snapshots

↓

Delete
```

Delete S3 Objects

```
Amazon S3

↓

Empty Bucket
```

Delete Bucket

```
Amazon S3

↓

Delete Bucket
```

Delete IAM Role (Optional)

```
IAM

↓

Roles

↓

Delete
```

---

# Troubleshooting

## Apache not accessible

Verify

```bash
sudo systemctl status httpd
```

Restart

```bash
sudo systemctl restart httpd
```

---

## SSH Connection Failed

Verify

- EC2 is running
- Correct Public IP
- Security Group allows Port 22
- Correct PEM file

---

## AWS CLI Access Denied

Verify

```bash
aws sts get-caller-identity
```

Confirm IAM Role is attached.

---

## Backup Upload Failed

Verify bucket name.

```bash
aws s3 ls
```

Check IAM permissions.

---

## Cron Not Running

Verify

```bash
crontab -l
```

Restart Cron if required.

---

# Learning Outcomes

After completing this project you should be able to:

✅ Deploy an EC2 instance.

✅ Configure Apache HTTP Server.

✅ Create Linux users and groups.

✅ Manage file permissions.

✅ Configure Security Groups.

✅ Create IAM Users and IAM Roles.

✅ Use AWS CLI.

✅ Automate backups using Bash.

✅ Store backups in Amazon S3.

✅ Schedule automation using Cron.

✅ Monitor Linux servers.

✅ Create Amazon EBS snapshots.

✅ Troubleshoot common infrastructure issues.

✅ Document cloud infrastructure professionally.

---

# Conclusion

This project demonstrates the complete lifecycle of deploying, administering, securing, monitoring, documenting, and maintaining a Linux server on Amazon Web Services.

Rather than focusing only on resource creation, the project emphasizes operational administration, automation, backup strategies, troubleshooting, and documentation, reflecting responsibilities commonly performed by Cloud Support Engineers, Infrastructure Engineers, and Linux System Administrators.

It provides a strong foundation for future projects involving Docker, Kubernetes, Infrastructure as Code (Terraform), CI/CD pipelines, monitoring solutions, and highly available cloud architectures.

---

# Author

**Preethi M**

Bachelor of Engineering – Computer Science Engineering (Cyber Security)

GitHub

https://github.com/GitPreethiHub

---

# License

This project is licensed under the MIT License.
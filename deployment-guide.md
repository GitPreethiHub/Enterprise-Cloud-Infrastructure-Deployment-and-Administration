# Enterprise Cloud Infrastructure Deployment Guide

---

# Table of Contents

1. Project Overview
2. Prerequisites
3. AWS Account Preparation
4. Create IAM Resources
5. Create the Network Infrastructure
6. Launch the Linux EC2 Instance
7. Launch the Windows Server Instance
8. Configure Apache Web Server
9. Perform Linux Administration
10. Configure Amazon EFS
11. Configure Amazon RDS MySQL
12. Configure Amazon CloudWatch
13. Configure Automation
14. Backup & Recovery
15. Verification
16. Cleanup
17. Troubleshooting

---

# 1. Project Overview

This guide explains how to recreate the complete enterprise cloud infrastructure implemented in this repository.

The deployment combines networking, compute, storage, databases, monitoring, automation, and system administration using Amazon Web Services.

The completed environment includes:

- Custom Amazon VPC
- Public and Private Subnets
- Internet Gateway
- Route Tables
- Security Groups
- Amazon Linux 2023 EC2
- Windows Server 2022 EC2
- Apache HTTP Server
- Amazon EFS
- Amazon RDS MySQL
- Amazon CloudWatch
- Amazon S3
- Amazon EBS Snapshots
- Bash Automation
- Python Automation

---

# 2. Prerequisites

Before beginning ensure the following requirements are available.

## AWS

- AWS Account
- Root Account MFA Enabled
- Billing Enabled
- AWS Free Tier (recommended)

---

## Local Software

Windows

- Visual Studio Code
- Git
- Windows Terminal
- RDP Client

Linux

- SSH Client

---

## Recommended Knowledge

- Basic Linux Commands
- AWS Console
- Networking Fundamentals
- Windows Server Basics

---

# 3. AWS Account Preparation

## Step 1

Login to the AWS Console.

```
https://console.aws.amazon.com
```

---

## Step 2

Enable Multi-Factor Authentication for the Root account.

Navigate:

```
IAM

↓

Root User

↓

Security Credentials

↓

Assign MFA Device
```

Purpose:

Protect the AWS account from unauthorized access.

---

## Step 3

Create an IAM Administrator User.

Navigate:

```
IAM

↓

Users

↓

Create User
```

Configuration:

Name

```
admin
```

Enable

```
AWS Management Console Access
```

Permissions

```
AdministratorAccess
```

Sign in using the IAM user for all remaining deployment steps.

---

# 4. Create IAM Resources

## Create CloudWatch Role

Navigate:

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

Attach Policy

```
CloudWatchAgentServerPolicy
```

Role Name

```
EC2-CloudWatch-Role
```

Create the role.

---

## Attach the Role

Navigate:

```
EC2

↓

Instances

↓

Linux Instance

↓

Actions

↓

Security

↓

Modify IAM Role
```

Attach

```
EC2-CloudWatch-Role
```

Verification

Run:

```bash
aws sts get-caller-identity
```

Expected:

The command should return your AWS Account information without requiring AWS credentials.

---

# 5. Create the Network Infrastructure

Navigate:

```
VPC

↓

Create VPC
```

Configuration

| Setting | Value |
|---------|-------|
| Name | enterprise-vpc |
| CIDR | 10.0.0.0/16 |

Create the VPC.

---

## Create Public Subnet

```
10.0.1.0/24
```

Availability Zone

```
ap-south-1a
```

Enable

```
Auto Assign Public IPv4
```

---

## Create Private Subnet

```
10.0.2.0/24
```

Availability Zone

```
ap-south-1b
```

Leave public IP assignment disabled.

---

## Create Internet Gateway

Navigate

```
VPC

↓

Internet Gateways

↓

Create
```

Name

```
enterprise-igw
```

Attach it to the VPC.

---

## Create Public Route Table

Create a Route Table.

Associate it with the Public Subnet.

Add Route

Destination

```
0.0.0.0/0
```

Target

```
Internet Gateway
```

---

## Create Security Groups

Create separate Security Groups for:

- Linux EC2
- Windows Server
- Amazon RDS
- Amazon EFS

Recommended Rules

Linux

| Port | Purpose |
|------|----------|
|22|SSH|
|80|HTTP|

Windows

| Port | Purpose |
|------|----------|
|3389|RDP|

RDS

| Port | Purpose |
|------|----------|
|3306|MySQL|

EFS

| Port | Purpose |
|------|----------|
|2049|NFS|

Verification

Confirm that:

- VPC is Available
- Public Subnet exists
- Private Subnet exists
- Internet Gateway is Attached
- Route Table is Active
- Security Groups are Created

---

# 6. Launch the Linux EC2 Instance

Navigate:

```
EC2

↓

Launch Instance
```

Configuration

| Setting | Value |
|---------|-------|
| Name | enterprise-linux-server |
| AMI | Amazon Linux 2023 |
| Instance Type | t3.micro |
| Key Pair | Create New |
| VPC | enterprise-vpc |
| Public Subnet | Yes |
| Security Group | enterprise-linux-sg |

Launch the instance.

Wait until

```
Running

2/2 Status Checks Passed
```

---

## Connect

Use

```
EC2 Instance Connect
```

or

```
SSH
```

Verify

```bash
hostname

whoami

cat /etc/os-release
```

Expected

Amazon Linux 2023.

---

# 7. Launch the Windows Server EC2 Instance

Navigate:

```
EC2

↓

Launch Instance
```

Configuration

| Setting | Value |
|---------|-------|
| Name | enterprise-windows-server |
| AMI | Microsoft Windows Server 2022 Base |
| Instance Type | t3.micro |
| Key Pair | Existing Key Pair |
| VPC | enterprise-vpc |
| Public Subnet | Yes |
| Security Group | enterprise-windows-sg |

Launch the instance.

Wait until:

```
Running

2/2 Status Checks Passed
```

---

## Connect using Remote Desktop

Navigate:

```
EC2

↓

Instance

↓

Connect

↓

RDP Client
```

Retrieve the Windows Administrator password using the key pair.

Connect using Microsoft Remote Desktop.

---

## Verify Windows Administration Tools

Open and verify the following tools.

### System Information

- Windows Version
- CPU
- Installed Memory

---

### Computer Management

Verify

- Shared Folders
- Local Users
- Device Manager
- Event Logs

---

### Services

Open

```
services.msc
```

Verify that Windows Services are operational.

---

### Event Viewer

Open

```
eventvwr.msc
```

Inspect:

- Application Logs
- System Logs
- Security Logs

---

### Windows Defender Firewall

Verify firewall configuration.

---

### Disk Management

Open

```
diskmgmt.msc
```

Inspect available storage volumes.

---

# 8. Configure Apache HTTP Server

Connect to the Linux EC2 instance.

Update packages.

```bash
sudo dnf update -y
```

Install Apache.

```bash
sudo dnf install httpd -y
```

Start Apache.

```bash
sudo systemctl start httpd
```

Enable Apache.

```bash
sudo systemctl enable httpd
```

Verify.

```bash
sudo systemctl status httpd
```

Create the sample webpage.

```bash
sudo nano /var/www/html/index.html
```

Access the server using:

```
http://<EC2-Public-IP>
```

Expected Result

The sample Apache webpage should load successfully.

---

# 9. Linux Administration

Perform routine administration tasks.

---

## System Information

```bash
hostname

uptime

free -h

df -h

top
```

---

## Package Management

```bash
sudo dnf check-update

sudo dnf install git python3 -y
```

---

## User Management

Create a user.

```bash
sudo adduser developer
```

Set a password.

```bash
sudo passwd developer
```

Verify.

```bash
id developer

groups developer
```

---

## Service Management

Check Apache.

```bash
sudo systemctl status httpd
```

Restart Apache.

```bash
sudo systemctl restart httpd
```

---

## File Permissions

```bash
ls -la

chmod

chown
```

---

# 10. Configure Amazon EFS

Navigate:

```
Amazon EFS

↓

Create File System
```

Configuration

| Setting | Value |
|---------|-------|
| Name | enterprise-shared-storage |
| Performance Mode | General Purpose |
| Throughput | Elastic |
| Encryption | Enabled |

Create the file system.

---

## Configure Mount Target

Create a Mount Target inside the same VPC.

Assign

```
enterprise-efs-sg
```

Wait until

```
Available
```

---

## Install EFS Utilities

On Linux

```bash
sudo dnf install amazon-efs-utils -y
```

---

## Create Mount Directory

```bash
sudo mkdir /mnt/efs
```

---

## Mount Amazon EFS

```bash
sudo mount -t efs fs-xxxxxxxx:/ /mnt/efs
```

Replace

```
fs-xxxxxxxx
```

with your File System ID.

---

## Verify

```bash
df -h
```

Create a test file.

```bash
echo "Enterprise Infrastructure" | sudo tee /mnt/efs/test.txt
```

Verify.

```bash
cat /mnt/efs/test.txt
```

---

# 11. Configure Amazon RDS MySQL

Navigate:

```
Amazon RDS

↓

Create Database
```

Configuration

| Setting | Value |
|---------|-------|
| Engine | MySQL Community |
| Version | MySQL 8.x |
| Template | Free Tier |
| DB Identifier | enterprise-mysql-db |
| Instance Class | db.t4g.micro |
| Storage | 20 GB |
| Public Access | No |

Create the database.

---

## Configure Security

Attach

```
enterprise-rds-sg
```

Allow inbound MySQL traffic on

```
3306
```

from the Linux EC2 Security Group.

---

## Verify

Wait until the database status becomes

```
Available
```

Record the endpoint for future connections.

Example

```
enterprise-mysql-db.xxxxxxxxx.ap-south-1.rds.amazonaws.com
```

No application was deployed in this project; the RDS instance was provisioned and configured to demonstrate managed database deployment and secure network connectivity within the VPC.

---
---

# 12. Configure Amazon CloudWatch

Amazon CloudWatch was configured to monitor the Linux EC2 instance beyond the default EC2 metrics.

---

## Install CloudWatch Agent

```bash
sudo dnf install amazon-cloudwatch-agent -y
```

Verify installation.

```bash
amazon-cloudwatch-agent-ctl -a status
```

---

## Configure the Agent

Run the configuration wizard.

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
```

Configuration used:

| Setting | Value |
|---------|-------|
| Environment | EC2 |
| User | cwagent |
| Host Metrics | Enabled |
| Per-Core CPU | No |
| EC2 Dimensions | Enabled |
| Collection Interval | 60 Seconds |
| Metrics | Basic |
| Logs | Disabled |
| X-Ray | Disabled |
| Store in SSM | No |

---

## Attach IAM Role

Attach an IAM Role containing:

```
CloudWatchAgentServerPolicy
```

Restart the CloudWatch Agent.

```bash
sudo systemctl restart amazon-cloudwatch-agent
```

Verify.

```bash
sudo systemctl status amazon-cloudwatch-agent
```

---

## Create Dashboard

Navigate:

```
CloudWatch

↓

Dashboards

↓

Create Dashboard
```

Add widgets for:

- CPU Utilization
- Memory Usage
- Disk Usage

---

## Create Alarm

Navigate:

```
CloudWatch

↓

Alarms

↓

Create Alarm
```

Configuration

Metric

```
CPUUtilization
```

Statistic

```
Average
```

Threshold

```
Greater than 70%
```

Period

```
5 Minutes
```

Create the alarm.

---

# 13. Infrastructure Automation

Automation was implemented using Bash scripts, Python, and Linux Cron.

---

## Apache Deployment Script

Location

```
Scripts/apache_setup.sh
```

Purpose

- Install Apache
- Start Service
- Enable Boot Startup
- Deploy Sample Webpage

Execute

```bash
bash Scripts/apache_setup.sh
```

---

## Server Health Script

Location

```
Scripts/server_health_check.sh
```

Execute

```bash
bash Scripts/server_health_check.sh
```

The script reports:

- Hostname
- Uptime
- Disk Usage
- Memory Usage
- System Information

---

## Python Health Report

Location

```
python/system_health_report.py
```

Execute

```bash
python3 python/system_health_report.py
```

Output includes:

- Date
- Hostname
- Uptime
- Disk Usage
- Available Disk Space

---

## Cron Scheduler

Open Cron.

```bash
crontab -e
```

Example

```cron
0 * * * * /home/ec2-user/Scripts/server_health_check.sh
```

Verify

```bash
crontab -l
```

---

# 14. Backup & Recovery

---

## Amazon S3 Backup

Execute

```bash
bash Scripts/backup_to_s3.sh
```

Verify uploaded files.

```
Amazon S3

↓

Bucket

↓

Objects
```

---

## Amazon EBS Snapshot

Navigate

```
EC2

↓

Volumes

↓

Create Snapshot
```

Verify

```
Snapshots

↓

Completed
```

---

# 15. Deployment Verification

Verify the following components.

| Component | Status |
|----------|--------|
| VPC | Created |
| Public Subnet | Created |
| Private Subnet | Created |
| Internet Gateway | Attached |
| Route Table | Configured |
| Security Groups | Configured |
| Linux EC2 | Running |
| Windows EC2 | Running |
| Apache | Accessible |
| Amazon EFS | Mounted |
| Amazon RDS | Available |
| CloudWatch Agent | Running |
| CloudWatch Dashboard | Created |
| CloudWatch Alarm | Created |
| Bash Scripts | Working |
| Python Script | Working |
| Amazon S3 Backup | Completed |
| Amazon EBS Snapshot | Created |

---

# 16. Cleanup

To avoid unnecessary AWS charges, remove or stop resources after completing the deployment.

Recommended cleanup order:

1. Delete the Amazon RDS instance.
2. Unmount and delete the Amazon EFS file system.
3. Stop the Windows Server EC2 instance.
4. Stop the Linux EC2 instance.
5. Delete EBS snapshots if no longer required.
6. Delete unused Security Groups if they are no longer attached.
7. Delete the custom VPC only after all dependent resources have been removed.

CloudWatch Dashboards, Alarms, IAM Roles, and repository files can be retained for documentation purposes.

---

# 17. Troubleshooting

| Issue | Solution |
|---------|----------|
| Apache page not loading | Verify Security Group allows TCP Port 80 and ensure the Apache service is running. |
| Unable to SSH into Linux EC2 | Confirm Port 22 is open and the correct key pair is being used. |
| Unable to connect to Windows Server | Verify Port 3389 is open and retrieve the correct Administrator password. |
| Amazon EFS not mounting | Check mount targets, DNS resolution, and Security Group rules allowing NFS (2049). |
| RDS inaccessible | Verify the RDS Security Group allows MySQL (3306) traffic from the EC2 Security Group. |
| CloudWatch metrics missing | Attach the CloudWatchAgentServerPolicy IAM Role and restart the CloudWatch Agent. |
| CloudWatch Dashboard empty | Wait a few minutes for metrics to populate after the agent starts. |
| S3 upload fails | Confirm AWS CLI permissions and bucket name are correct. |

---

# Deployment Complete

The environment now demonstrates an enterprise-style AWS infrastructure featuring secure networking, Linux and Windows administration, managed storage, relational databases, monitoring, automation, and backup strategies.

The completed deployment provides practical experience with common Infrastructure Engineer responsibilities, including provisioning cloud resources, configuring networking, implementing monitoring, automating administrative tasks, and documenting the deployment lifecycle.

Refer to the `README.md` for the complete project overview and the `screenshots/` directory for deployment evidence.
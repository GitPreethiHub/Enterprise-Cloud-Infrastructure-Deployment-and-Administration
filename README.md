# ☁️ Enterprise Cloud Infrastructure Deployment & Administration on AWS

<div align="center">

![Banner](assets/banner.png)

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazonaws)
![Amazon Linux](https://img.shields.io/badge/Amazon_Linux-2023-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Windows Server](https://img.shields.io/badge/Windows_Server-2022-0078D6?style=for-the-badge&logo=windows)
![CloudWatch](https://img.shields.io/badge/Amazon-CloudWatch-FF4F8B?style=for-the-badge&logo=amazonaws)
![Python](https://img.shields.io/badge/Python-Automation-3776AB?style=for-the-badge&logo=python)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

### Enterprise-Style AWS Infrastructure Deployment, Administration, Monitoring & Automation

</div>

---

# 📖 Project Overview

This project demonstrates the design, deployment, administration, monitoring, and automation of an enterprise-style AWS cloud infrastructure.

Unlike a basic EC2 deployment, this project simulates real-world Infrastructure Engineer responsibilities by integrating compute, networking, storage, databases, monitoring, automation, and Windows/Linux administration into a single environment.

The infrastructure includes custom networking, Amazon Linux and Windows Server EC2 instances, Amazon RDS MySQL, Amazon EFS shared storage, CloudWatch monitoring, automated backups, Bash scripting, Python automation, and infrastructure documentation.

The project was built manually through the AWS Management Console and Linux CLI to strengthen practical cloud administration skills while documenting every deployment step.

---

# 🎯 Project Objectives

The goals of this project were to:

- Deploy enterprise-style cloud infrastructure on AWS.
- Configure custom VPC networking.
- Deploy Linux and Windows EC2 servers.
- Configure secure Security Groups.
- Deploy Amazon RDS MySQL.
- Configure Amazon EFS shared storage.
- Implement CloudWatch monitoring and alerts.
- Automate administrative tasks using Bash.
- Develop Python-based health reporting.
- Perform Linux and Windows system administration.
- Create backup and recovery mechanisms.
- Produce professional deployment documentation.

---

# ☁️ AWS Services Used

| Service | Purpose |
|----------|----------|
| Amazon EC2 (Linux) | Apache Web Server |
| Amazon EC2 (Windows Server 2022) | Windows Administration |
| Amazon VPC | Network Isolation |
| Public & Private Subnets | Network Segmentation |
| Internet Gateway | Internet Connectivity |
| Route Tables | Traffic Routing |
| Security Groups | Firewall Rules |
| Amazon EFS | Shared File Storage |
| Amazon RDS MySQL | Relational Database |
| Amazon S3 | Backup Storage |
| Amazon EBS | Persistent Storage |
| Amazon EBS Snapshots | Disaster Recovery |
| Amazon CloudWatch | Monitoring & Alerting |
| IAM | Identity & Access Management |

---

# 🏗️ Infrastructure Architecture

<div align="center">

![Architecture Diagram](diagrams/architecture_diagram.png)

</div>

## Infrastructure Components

### Networking

- Custom VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Tables
- Multiple Security Groups

### Compute

- Amazon Linux 2023 EC2
- Windows Server 2022 EC2

### Storage

- Amazon EFS
- Amazon S3
- Amazon EBS
- Amazon EBS Snapshot

### Database

- Amazon RDS MySQL

### Monitoring

- Amazon CloudWatch Agent
- CloudWatch Dashboard
- CloudWatch Alarm

### Automation

- Bash Scripts
- Python Health Reporting
- Cron Scheduler

---

# 🚀 Key Features

## Infrastructure

- Custom AWS Networking
- Linux & Windows Server Deployment
- Apache HTTP Server
- Amazon RDS
- Amazon EFS
- Amazon S3
- Amazon EBS Snapshots

---

## Monitoring

- CloudWatch Agent
- Memory Monitoring
- Disk Monitoring
- CPU Monitoring
- CloudWatch Dashboard
- CloudWatch Alarm

---

## Linux Administration

- User Management
- File Permissions
- Package Management
- Service Management
- Process Monitoring
- Storage Management

---

## Windows Administration

- Windows Firewall
- Event Viewer
- Services Console
- Disk Management
- Computer Management
- System Information

---

## Automation

- Bash Backup Script
- Python Health Report
- Cron Scheduling
- S3 Backup Automation

---

## Security

- Security Groups
- IAM Authentication
- Private Networking
- Principle of Least Privilege
- Root MFA Enabled

---

# 📚 Technologies Used

| Category | Technologies |
|-----------|--------------|
| Cloud | Amazon Web Services |
| Compute | Amazon EC2 |
| Operating Systems | Amazon Linux 2023, Windows Server 2022 |
| Storage | Amazon EFS, Amazon S3, Amazon EBS |
| Database | Amazon RDS MySQL |
| Monitoring | Amazon CloudWatch |
| Scripting | Bash, Python |
| Version Control | Git |
| Repository | GitHub |
| IDE | Visual Studio Code |

---

# 📂 Repository Structure

```text
Enterprise-Cloud-Infrastructure-Deployment-and-Administration
│
├── README.md
├── deployment-guide.md
├── LICENSE
├── .gitignore
│
├── assets/
├── diagrams/
│   └── architecture_diagram.png
│
├── Documentation/
│   ├── cloudwatch-agent-config.json
│   ├── efs-mount-output.txt
│   ├── httpd.conf
│   ├── installed-packages.txt
│   ├── rds-connection-test.txt
│   ├── server-health-report.txt
│   └── system-report.txt
│
├── python/
│   └── system_health_report.py
│
├── Scripts/
│   ├── apache_setup.sh
│   ├── backup_to_s3.sh
│   ├── efs_mount.sh
│   └── server_health_check.sh
│
└── screenshots/
    ├── automation/
    ├── cloudwatch/
    ├── ec2/
    ├── efs/
    ├── networking/
    ├── rds/
    ├── s3-ebs/
    └── windows/
```

---
# 📸 Implementation Walkthrough

---

# 🌐 1. Creating the Network Infrastructure

A dedicated Virtual Private Cloud (VPC) was created to isolate the infrastructure from the default AWS networking environment.

The networking architecture includes:

- Custom VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Public Route Table
- Network segmentation

This provides a scalable and secure foundation for hosting cloud resources.

### VPC

![VPC](screenshots/networking/vpc.png)

### Public Subnet

![Public Subnet](screenshots/networking/public-subnet.png)

### Private Subnet

![Private Subnet](screenshots/networking/private-subnet.png)

### Internet Gateway

![Internet Gateway](screenshots/networking/internet-gateway.png)

### Public Route Table

![Route Table](screenshots/networking/public-route-table.png)

---

# 🔒 2. Configuring Security Groups

Separate Security Groups were created for each infrastructure component following the principle of least privilege.

Configured Security Groups include:

- Linux EC2
- Windows Server
- Amazon RDS
- Amazon EFS

Each Security Group allows only the required inbound traffic while denying unnecessary access.

### Linux Security Group

![Linux SG](screenshots/networking/security-group-linux.png)

### Windows Security Group

![Windows SG](screenshots/networking/security-group-windows.png)

### RDS Security Group

![RDS SG](screenshots/networking/security-group-rds.png)

### EFS Security Group

![EFS SG](screenshots/networking/security-group-efs.png)

---

# 🐧 3. Deploying the Amazon Linux EC2 Instance

An Amazon Linux 2023 EC2 instance was launched inside the public subnet.

The instance serves as the primary Linux administration server for the project.

Tasks performed include:

- Instance provisioning
- SSH access
- Package management
- Linux administration
- Apache deployment
- CloudWatch Agent installation
- Automation scripting

### Linux EC2 Instance

![Linux EC2](screenshots/ec2/ec2-instance-running.png)

---

# 🌍 4. Configuring Apache Web Server

Apache HTTP Server was installed and configured to host a sample enterprise webpage.

Configuration steps included:

- Installing Apache
- Starting the service
- Enabling automatic startup
- Verifying service status
- Testing browser access

### Apache Deployment

![Apache](screenshots/ec2/apache-web-server.png)

---

# 💻 5. Linux Administration

Routine Linux administration tasks were performed to simulate day-to-day infrastructure management.

Activities included:

- System monitoring
- Package management
- Service management
- Storage inspection
- User verification
- Process monitoring

### Linux Terminal

![Linux Terminal](screenshots/ec2/ec2-terminal.png)

---

# ❤️ 6. Server Health Reporting using Python

A Python utility was developed to generate a concise infrastructure health report.

The script displays:

- Current date and time
- Hostname
- Server uptime
- Disk usage
- Available storage

This demonstrates how Python can complement Bash for administrative reporting.

### Python Health Report

![Python Health Report](screenshots/automation/linux-system-health-report.png)

---

# 👥 7. Linux User Administration

Multiple Linux users were created to demonstrate role separation and privilege management.

Tasks performed include:

- Creating users
- Managing groups
- Assigning administrative privileges
- Verifying user information

### Linux Users

![Linux Users](screenshots/automation/linux-users.png)

---

# 🪟 8. Deploying Windows Server 2022

A Windows Server 2022 EC2 instance was deployed to demonstrate cross-platform administration within the AWS environment.

The server was accessed securely using Remote Desktop Protocol (RDP).

### Windows Instance

![Windows Instance](screenshots/windows/windows-instance-details.png)

### Windows Desktop

![Windows Desktop](screenshots/windows/windows-desktop.png)

---

# 🖥️ 9. Windows Server Administration

Several native Windows administration tools were explored to simulate common system administration tasks.

These include:

- Computer Management
- Services Console
- Event Viewer
- Disk Management
- Windows Defender Firewall
- System Information

### Computer Management

![Computer Management](screenshots/windows/windows-computer-management.png)

### Services

![Services](screenshots/windows/windows-services-console.png)

### Event Viewer

![Event Viewer](screenshots/windows/windows-event-viewer.png)

### Disk Management

![Disk Management](screenshots/windows/windows-disk-management.png)

### Windows Firewall

![Firewall](screenshots/windows/windows-firewall.png)

### System Information

![System Information](screenshots/windows/windows-system-information.png)

---
---

# 🗄️ 10. Deploying Amazon RDS MySQL

An Amazon RDS MySQL database instance was provisioned within the VPC to demonstrate managed relational database deployment.

The database was configured with:

- MySQL Community Edition
- Dedicated Security Group
- Private network accessibility
- Secure endpoint configuration

This approach removes the operational overhead of managing database servers while providing automated maintenance, backups, and high reliability.

### RDS Instance Overview

![RDS Overview](screenshots/rds/rds-instance-overview.png)

### Connectivity & Security

![RDS Connectivity](screenshots/rds/rds-connectivity-security.png)

---

# 📂 11. Configuring Amazon EFS Shared Storage

Amazon Elastic File System (EFS) was deployed to provide persistent shared storage for Linux workloads.

The EFS file system was mounted on the Linux EC2 instance using the Amazon EFS mount helper.

Tasks performed:

- Created Amazon EFS
- Configured Mount Target
- Configured Security Group
- Mounted EFS
- Verified file operations

### EFS Overview

![EFS Overview](screenshots/efs/efs-overview.png)

### Network Mount Target

![EFS Network](screenshots/efs/efs-network-mount-target.png)

### Mounted Filesystem

![EFS Mounted](screenshots/efs/efs-mounted-filesystem.png)

### File Write Verification

![EFS Verification](screenshots/efs/efs-file-write-verification.png)

---

# 📊 12. Monitoring with Amazon CloudWatch

Amazon CloudWatch Agent was installed on the Linux EC2 instance to collect operating system metrics beyond the default EC2 monitoring.

Collected metrics include:

- Memory Utilization
- Disk Utilization
- CPU Metrics

A custom CloudWatch dashboard was created to visualize infrastructure health, and an alarm was configured for high CPU utilization.

### CloudWatch Agent Configuration

![CloudWatch Configuration](screenshots/cloudwatch/linux-cloudwatch-agent-configuration.png)

### CloudWatch Agent Status

![CloudWatch Status](screenshots/cloudwatch/linux-cloudwatch-agent-status.png)

### CloudWatch Dashboard

![CloudWatch Dashboard](screenshots/cloudwatch/cloudwatch-dashboard.png)

### CPU Alarm

![CloudWatch Alarm](screenshots/cloudwatch/cloudwatch-cpu-alarm-created.png)

---

# ⚙️ 13. Infrastructure Automation

Routine administrative operations were automated using Bash scripts and the Linux Cron scheduler.

Automation tasks include:

- Apache deployment
- System health verification
- Amazon EFS mounting
- Backup preparation

These scripts reduce manual administrative effort and improve operational consistency.

---

## Apache Deployment Script

- Installs Apache HTTP Server
- Starts the service
- Enables automatic startup
- Deploys a sample webpage

---

## Server Health Check Script

Collects infrastructure information including:

- Hostname
- Uptime
- Disk Usage
- System Status

### Health Check Script

![Health Script](screenshots/ec2/linux-server-health-script.png)

---

## Python Health Report

A Python utility generates a formatted infrastructure health report for quick operational verification.

### Python Output

![Python Report](screenshots/automation/linux-system-health-report.png)

---

## Cron Job Automation

The server health check script was scheduled using Cron to demonstrate automated task execution.

### Cron Configuration

![Cron Job](screenshots/automation/cron-job.png)

---

# ☁️ 14. Backup & Recovery

A basic backup strategy was implemented using Amazon S3 and Amazon EBS Snapshots.

The Bash backup script prepares backup files for upload to Amazon S3, while Amazon EBS Snapshots provide block-level disaster recovery for EC2 storage.

---

## Amazon S3 Backup

Backup files are generated locally and uploaded to Amazon S3 using the AWS CLI.

### Backup Script

![Backup Script](screenshots/s3-ebs/backup-script.png)

### S3 Backups

![S3 Backup](screenshots/s3-ebs/s3-backups.png)

---

## Amazon EBS Snapshot

A point-in-time EBS Snapshot was created to demonstrate infrastructure recovery capabilities.

### Snapshot

![Snapshot](screenshots/s3-ebs/ebs-snapshot.png)

---

# 🔒 Security Implementation

Security best practices were followed throughout the deployment.

Implemented controls include:

- Root account protected with MFA
- Dedicated Security Groups
- Private database deployment
- Network isolation using VPC
- Least-privilege firewall rules
- SSH access restricted to Linux server
- RDP access restricted to Windows server
- Amazon EFS protected by dedicated Security Group
- CloudWatch monitoring for operational visibility

---

# 🛠️ Challenges Faced & Solutions

| Challenge | Solution |
|------------|----------|
| Designing a secure VPC architecture | Implemented custom VPC with separate public and private subnets. |
| Mounting Amazon EFS | Installed Amazon EFS utilities and verified mount targets and Security Groups. |
| CloudWatch Agent metrics not appearing | Attached an IAM Role with CloudWatchAgentServerPolicy and restarted the CloudWatch Agent. |
| Configuring RDS connectivity | Used dedicated Security Groups and private networking for secure database communication. |
| Managing Linux and Windows environments | Performed administration using both Linux CLI and Windows Server management tools. |
| Automating operational tasks | Implemented Bash scripts, Python reporting, and Cron scheduling. |

---

# 💼 Skills Demonstrated

## AWS

- Amazon EC2
- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- Route Tables
- Security Groups
- Amazon EFS
- Amazon RDS MySQL
- Amazon S3
- Amazon EBS
- Amazon EBS Snapshots
- Amazon CloudWatch
- IAM

---

## Linux

- Amazon Linux 2023
- Apache HTTP Server
- User Management
- File Permissions
- Package Management
- Service Management
- Storage Administration
- System Monitoring
- Bash Scripting
- Cron Jobs

---

## Windows

- Windows Server 2022
- Event Viewer
- Windows Defender Firewall
- Computer Management
- Services Console
- Disk Management
- System Information

---

## Automation

- Bash
- Python
- AWS CLI
- CloudWatch Monitoring
- Scheduled Tasks

---

# 📋 Frequently Used Commands

## Linux Administration

```bash
hostname
whoami
pwd
ls -la
df -h
free -h
uptime
top
systemctl status httpd
journalctl -xe
```

---

## Apache HTTP Server

```bash
sudo yum install httpd -y

sudo systemctl start httpd

sudo systemctl enable httpd

sudo systemctl status httpd
```

---

## Amazon EFS

```bash
sudo yum install amazon-efs-utils -y

sudo mkdir /mnt/efs

sudo mount -t efs fs-xxxxxxxx:/ /mnt/efs

df -h
```

---

## CloudWatch Agent

```bash
sudo systemctl status amazon-cloudwatch-agent

sudo amazon-cloudwatch-agent-ctl -m ec2 -a status

sudo systemctl restart amazon-cloudwatch-agent
```

---

## User Management

```bash
sudo adduser developer

sudo passwd developer

groups developer

id developer
```

---

## Cron Automation

```bash
crontab -e

crontab -l
```

---

## AWS CLI

```bash
aws --version

aws s3 ls

aws s3 cp

aws sts get-caller-identity
```

---

# 🎓 Learning Outcomes

Through this project, I gained practical experience in designing, deploying, administering, monitoring, and documenting enterprise-style cloud infrastructure on Amazon Web Services.

Key learning outcomes include:

- Designing custom AWS networking using VPC, public and private subnets, Internet Gateway, and Route Tables.
- Deploying and administering Amazon Linux 2023 and Windows Server 2022 EC2 instances.
- Configuring Apache HTTP Server for web hosting.
- Managing Linux users, services, storage, and system resources.
- Performing Windows Server administration using native management tools.
- Deploying and configuring Amazon RDS MySQL.
- Implementing shared storage using Amazon EFS.
- Monitoring infrastructure using Amazon CloudWatch Agent, Dashboards, and Alarms.
- Automating administrative tasks using Bash scripts.
- Developing Python utilities for infrastructure health reporting.
- Creating backup and recovery solutions using Amazon S3 and Amazon EBS Snapshots.
- Documenting enterprise infrastructure following professional GitHub project standards.

---

# 🚀 Future Improvements

Potential enhancements for future versions include:

- Infrastructure as Code using Terraform.
- Docker containerization.
- Kubernetes deployment using Amazon EKS.
- Application Load Balancer (ALB).
- Auto Scaling Groups.
- AWS Systems Manager integration.
- HTTPS with AWS Certificate Manager.
- AWS Secrets Manager for database credentials.
- CloudWatch Log Insights.
- CI/CD pipeline using GitHub Actions.

---

# 💼 Resume Description

**Enterprise Cloud Infrastructure Deployment & Administration on AWS**

Designed and deployed an enterprise-style AWS cloud infrastructure using Amazon EC2 (Linux & Windows Server), Amazon VPC, Security Groups, Amazon EFS, Amazon RDS MySQL, Amazon CloudWatch, Amazon S3, and Amazon EBS. Configured networking, storage, monitoring, automation, and system administration across Linux and Windows environments. Implemented Bash and Python automation, CloudWatch dashboards and alarms, backup and recovery mechanisms, and documented the complete infrastructure deployment using GitHub.

---

# 📂 Project Documentation

The repository contains supporting documentation and configuration files used throughout the deployment.

| File | Description |
|------|-------------|
| `deployment-guide.md` | Complete deployment walkthrough |
| `Documentation/httpd.conf` | Apache configuration |
| `Documentation/cloudwatch-agent-config.json` | CloudWatch Agent configuration |
| `Documentation/server-health-report.txt` | Generated health report |
| `Documentation/system-report.txt` | Linux system information |
| `Documentation/installed-packages.txt` | Installed packages reference |
| `Documentation/efs-mount-output.txt` | Amazon EFS verification |
| `Documentation/rds-connection-test.txt` | Amazon RDS deployment information |

---

# 📸 Screenshot Gallery

The repository contains over **35 deployment screenshots** documenting every stage of the infrastructure implementation, including:

- Networking
- Linux Administration
- Windows Administration
- Amazon EFS
- Amazon RDS
- CloudWatch Monitoring
- Bash Automation
- Python Automation
- Backup & Recovery

---

# 📚 References

- AWS Documentation — https://docs.aws.amazon.com/
- Amazon EC2 Documentation
- Amazon VPC Documentation
- Amazon EFS Documentation
- Amazon RDS Documentation
- Amazon CloudWatch Documentation
- Apache HTTP Server Documentation
- Python Documentation

---

# 👩‍💻 Author

**Preethi M**

Bachelor of Engineering  
Computer Science & Engineering (Cyber Security)

GitHub: https://github.com/GitPreethiHub

---

# 📄 License

This project is licensed under the MIT License.

See the LICENSE file for additional information.

---

# ⭐ Support

If you found this project useful or learned something from it, consider giving the repository a ⭐ on GitHub.

---

# 🎯 Conclusion

This project demonstrates practical experience in deploying and administering enterprise cloud infrastructure using Amazon Web Services.

The implementation combines networking, compute, storage, databases, monitoring, automation, and operating system administration across both Linux and Windows environments. By integrating Amazon VPC, EC2, EFS, RDS, CloudWatch, S3, and EBS with Bash and Python automation, the project reflects operational tasks commonly performed by Infrastructure Engineers, Cloud Engineers, and System Administrators.

Beyond provisioning cloud resources, the project emphasizes secure infrastructure design, system monitoring, operational automation, troubleshooting, backup and recovery strategies, and comprehensive technical documentation, providing a strong foundation for more advanced cloud engineering and DevOps practices.
# 🏗️ AWS Infrastructure with Terraform

Infrastructure as Code pentru AWS folosind Terraform cu suport pentru multiple environments (dev, prod).

## 📋 Componente

### Networking

- VPC cu CIDR configurable
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables

### Compute

- 3x EC2 instances (2 inițiale + 1 backup)
- Security Groups cu reguli pentru SSH, HTTP, HTTPS

### Storage & Monitoring

- S3 Bucket cu versioning și encryption
- CloudWatch Log Groups

## 🚀 Structura Proiectului

```
alex-vpc-ec2-v5/
├── modules/
│   ├── vpc/
│   ├── subnet/
│   ├── nat_gateway/
│   └── ec2/
├── main.tf
├── variables.tf
├── outputs.tf
├── upgrade.tf
├── versions.tf
├── terraform.tfvars.dev
├── terraform.tfvars.prod
└── .github/
    └── workflows/
        ├── terraform-ci.yml
        └── terraform-cd.yml
```

## 🛠️ Cum să folosești

### Prerequisites

- Terraform >= 1.0
- AWS CLI configurat
- Git

### Setup Local

```bash
# Clone repository
git clone https://github.com/USERNAME/alex-vpc-ec2-v5.git
cd alex-vpc-ec2-v5

# Initialize Terraform
terraform init

# Select workspace
terraform workspace select dev

# Plan
terraform plan -var-file="terraform.tfvars.dev"

# Apply
terraform apply -var-file="terraform.tfvars.dev"
```

### Cleanup

```bash
terraform destroy -var-file="terraform.tfvars.dev"
```

## 🔐 Security

- NU pune credentials în Git
- Folosește GitHub Secrets pentru CI/CD
- `.tfvars` files sunt în `.gitignore`

## 📊 Costuri estimate

- Dev: ~$45/lună
- Prod: ~$62/lună

## 👤 Author

Alex - DevOps Engineer in training 🚀

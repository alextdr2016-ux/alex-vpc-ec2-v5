# ========================================
# Referințe la resurse existente din STATE
# ========================================

# În loc de data source, folosește direct output-ul modulului
locals {
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
}

# ========================================
# UPGRADE 1: Al 3-lea EC2 (pentru load balancing)
# ========================================

resource "aws_instance" "web_backup" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = local.public_subnet_id  # ← Folosește local!
  associate_public_ip_address = true

  vpc_security_group_ids = [module.ec2.sg_id]

  tags = {
    Name    = "${var.environment}-web-backup-ec2"
    Purpose = "Backup Web Server"
  }
}

# ========================================
# UPGRADE 2: S3 Bucket pentru logs/storage
# ========================================

resource "aws_s3_bucket" "app_storage" {
  bucket = "${var.environment}-alex-app-storage-${local.vpc_id}"  # ← Folosește local!

  tags = {
    Name        = "${var.environment}-app-storage"
    Environment = var.environment
  }
}

# S3 Bucket versioning
resource "aws_s3_bucket_versioning" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# ========================================
# UPGRADE 3: CloudWatch Log Group
# ========================================

resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/ec2/${var.environment}-app"
  retention_in_days = 7

  tags = {
    Name        = "${var.environment}-app-logs"
    Environment = var.environment
  }
}

# ========================================
# OUTPUTS pentru upgrade
# ========================================

output "web_backup_instance_id" {
  description = "ID al instanței EC2 de backup"
  value       = aws_instance.web_backup.id
}

output "web_backup_public_ip" {
  description = "IP public al instanței EC2 de backup"
  value       = aws_instance.web_backup.public_ip
}

output "s3_bucket_name" {
  description = "Numele bucket-ului S3"
  value       = aws_s3_bucket.app_storage.id
}

output "s3_bucket_arn" {
  description = "ARN-ul bucket-ului S3"
  value       = aws_s3_bucket.app_storage.arn
}

output "cloudwatch_log_group" {
  description = "Numele Log Group-ului CloudWatch"
  value       = aws_cloudwatch_log_group.app_logs.name
}
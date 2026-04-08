terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project = "repte17"
      Owner   = "Richi"
    }
  }
}

resource "aws_ecr_repository" "repte17_web" {
  name                 = "repte17-web"
  image_tag_mutability = "MUTABLE"

  force_delete = true # <-- clave para que destroy funcione aunque haya imágenes

  image_scanning_configuration {
    scan_on_push = false
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}

output "ecr_repository_uri" {
  value = aws_ecr_repository.repte17_web.repository_url
}

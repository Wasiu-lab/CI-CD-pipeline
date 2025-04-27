provider "aws" {
  region  = var.aws_region
  profile = "myprofile"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

module "jenkins" {
  source         = "./modules/ec2_instance"
  instance_name  = "jenkins-server"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  vpc_id         = module.vpc.vpc_id
  security_ports = [22, 8080]
  install_script = file("${path.module}/user_data/jenkins.sh")
  subnet_id      = module.vpc.subnet_id
}

module "sonarqube" {
  source         = "./modules/ec2_instance"
  instance_name  = "sonarqube"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  vpc_id         = module.vpc.vpc_id
  security_ports = [22, 9000]
  install_script = file("${path.module}/user_data/sonarqube.sh")
  subnet_id      = module.vpc.subnet_id
}

module "docker" {
  source         = "./modules/ec2_instance"
  instance_name  = "docker"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  vpc_id         = module.vpc.vpc_id
  security_ports = [22, 2375]
  install_script = file("${path.module}/user_data/docker.sh")
  subnet_id      = module.vpc.subnet_id
}

output "jenkins_public_ip" {
  value = module.jenkins.public_ip
}

output "sonarqube_public_ip" {
  value = module.sonarqube.public_ip
}

output "docker_public_ip" {
  value = module.docker.public_ip
}

module "VPC" {
  source = "./modules/VPC"
  identifier = "shivani-module"
  total_subnets = 3
}

module "EC2" {
  source = "./modules/EC2"

  depends_on = [module.VPC]
  # Pass the VPC outputs as variables to the EC2 module
  vpc_id            = module.VPC.vpc_id
  public_subnet_ids = module.VPC.public_subnets
  private_subnet_ids = module.VPC.private_subnets
}

module "RDS" {
  source = "./modules/RDS"

  depends_on = [module.VPC]
  # Pass the VPC outputs as variables to the RDS module
  private_subnet_ids = module.VPC.private_subnets
  rds_username = "shivani"
  rds_password = "foobarbaz"
}

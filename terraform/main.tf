##vpc

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr_a = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.3.0/24"
  availability_zone    = "us-east-1a"
  vpc_id               = module.vpc.vpc_id


}



module "ec2" {
  source           = "./modules/ec2"
  image_id         = var.image_id
  public_subnet_id = module.vpc.public_subnet_id
  vpc_id           = module.vpc.vpc_id
  key              = module.ec2.key



}
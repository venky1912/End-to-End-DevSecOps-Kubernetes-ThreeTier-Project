### Cluster Outputs ##
output "vpc_id" {
    description = "EKS cluster VPC"
    value = module.devops-eks.vpc_id
}

### Cluster Outputs ##
output "eks-cluster" {
    description = "EKS Cluster endpoint"
    value = module.eks.cluster-name
}


env                   = "prod"
aws-region            = "eu-west-2"
vpc-cidr-block        = "10.16.0.0/16"
cidr-block            = "10.16.0.0/16"
vpc-name              = "devops-eks"
igw-name              = "igw"
pub-subnet-count      = 3
pub-cidr-block        = ["10.16.0.0/20", "10.16.16.0/20", "10.16.32.0/20"]
pub-availability-zone = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
pub-sub-name          = "subnet-public"
pri-subnet-count      = 3
pri-cidr-block        = ["10.16.128.0/20", "10.16.144.0/20", "10.16.160.0/20"]
pri-availability-zone = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
pri-sub-name          = "subnet-private"
public-rt-name        = "public-route-table"
private-rt-name       = "private-route-table"
eip-name              = "elasticip-ngw"
ngw-name              = "ngw"
eks-sg                = "eks-sg"

# EKS
is-eks-cluster-enabled     = true
is_eks_nodegroup_role_enabled = true
is_eks_role_enabled           = true
cluster-version            = "1.29"
cluster-name               = "devops-eks-cluster"
endpoint-private-access    = true
endpoint-public-access     = false
ondemand_instance_types    = ["t3a.medium"]
spot_instance_types        = ["c5a.large", "c5a.xlarge", "m5a.large", "m5a.xlarge", "c5.large", "m5.large", "t3a.large", "t3a.xlarge", "t3a.medium"]
desired_capacity_on_demand = "1"
min_capacity_on_demand     = "1"
max_capacity_on_demand     = "5"
desired_capacity_spot      = "1"
min_capacity_spot          = "1"
max_capacity_spot          = "10"
addons = [
  {
    name    = "vpc-cni",
    version = "v1.18.1-eksbuild.1"
  },
  {
    name    = "coredns"
    version = "v1.11.1-eksbuild.9"
  },
  {
    name    = "kube-proxy"
    version = "v1.29.3-eksbuild.2"
  },
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.30.0-eksbuild.1"
  },
  {
    name    = "aws-load-balancer-controller"
    version = "v2.4.7"
  },
  {
    name    = "cluster-autoscaler"
    version = "v1.26.2"
  },
  {
    name    = "aws-efs-csi-driver"
    version = "v1.5.9"
  },
  {
    name    = "kubernetes-dashboard"
    version = "v2.7.0"
  },
  {
    name    = "cloudwatch-container-insights"
    version = "v1.5.0"
  },
  {
    name    = "kube-state-metrics"
    version = "v2.5.0"
  },
  {
    name    = "prometheus-grafana"
    version = "v7.5.10"
  },
  {
    name    = "velero"
    version = "v1.9.5"
  },
  {
    name    = "cert-manager"
    version = "v1.9.1"
  },
  {
    name    = "external-dns"
    version = "v0.10.1"
  },
  {
    name    = "aws-app-mesh-controller"
    version = "v1.4.0"
  },
  {
    name    = "falco"
    version = "v0.32.1"
  },
  {
    name    = "kube-bench"
    version = "v0.6.7"
  },
  {
    name    = "trivy"
    version = "v0.34.0"
  },
  {
    name    = "opa-gatekeeper"
    version = "v3.7.0"
  },
  {
    name    = "calico"
    version = "v3.25.0"
  },
  {
    name    = "kyverno"
    version = "v1.9.0"
  }
  # Add more addons as needed
]
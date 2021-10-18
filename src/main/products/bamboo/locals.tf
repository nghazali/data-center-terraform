locals {

  required_tags = {
    product = "Bamboo"
  }

  namespace = "bamboo"

  # Two subnet CIDRs are required. Each VPC has a CIDR associated, such as '10.125.96.0/20'. Use an IP subnet calculator
  # to figure out what the subnet range is, then choose two smaller subnets that don't overlap with any other exising
  # subnets in the VPC.
  vpc_cidr            = "10.0.0.0/16"
  vpc_private_subnet  = ["10.0.10.0/24", "10.0.12.0/24"]
  vpc_public_subnet   = ["10.0.110.0/24", "10.0.112.0/24"]

  # Look at https://hello.atlassian.net/wiki/spaces/RELENG/pages/677332161/HOWTO%3A+IAM+Roles+in+PBC+%28Bamboo%29+using+IRSA
  # to find out how to modify these variables.
  # TLDR: The OIDC ARN can be found in the "Identity Providers" sub-menu in the AWS IAM console.
  build_role_oidc_arn = "arn:aws:iam::342470128466:oidc-provider/oidc-atlassian-kubernetes-cicd-prod.s3.us-east-1.amazonaws.com"
  build_role_builds = [
    # This value has to be defined for each build. It can be found by going to the build in Bamboo, clicking "Actions"
    # on the top right and choosing "View AWS IAM Subject ID for PBC"
    "kubernetes.cicd.buildeng-server-syd-bamboo.server-syd-bamboo/DCD-K8SHELMTEST/B/5307728059"
  ]

  # Additional IAM roles to add to the aws-auth configmap. See modules/eks/variables.tf for details.
  additional_map_roles = [
    {
      rolearn  = "arn:aws:iam::887764444972:role/dcd-private-sysadmin"
      username = "dcd-private-sysadmin"
      groups = [
        "system:masters"
      ]
    }
  ]

  # The value of OSQUERY_ENV that will be used to send logs to Splunk. It should not be something like “production”
  # or “prod-west2” but should instead relate to the product, platform, or team.
  osquery_env = "osquery_dcd_infrastructure"
}
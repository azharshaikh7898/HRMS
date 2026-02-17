# HRMS AWS Infrastructure (Terraform)

Production-ready Terraform workspace for an enterprise HRMS on AWS.

## Stack

- Networking: VPC across 3 AZs, public/private/db subnets, NAT per AZ
- Compute: EKS (managed node groups, ALB ingress compatible)
- Data: RDS PostgreSQL Multi-AZ + read replica option
- Storage: S3 buckets for documents, payslips, audit archive
- Security: IAM baseline, IRSA integration points, WAF, KMS encryption
- Observability: CloudWatch log groups + alarms baseline
- CI/CD: ECR + CodeBuild + CodePipeline skeleton

## Structure

```text
infra/
  global/
  modules/
  environments/
```

## Quick Start

1. Configure remote state backend resources (S3 bucket + DynamoDB table).
2. Copy `infra/global/backend.hcl.example` values into each env `backend.tf`.
3. Set environment values in `terraform.tfvars`.
4. Deploy:

```bash
cd infra/environments/dev
terraform init -backend-config=backend.hcl
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Promote the same artifacted image and Terraform version from `dev` -> `staging` -> `prod`.

## Security Baselines

- Enforce MFA + SSO for privileged operators.
- Enable CloudTrail/Config/GuardDuty/SecurityHub organization-wide.
- Use KMS CMKs for RDS and S3.
- Avoid static credentials; use OIDC/assume-role for CI.

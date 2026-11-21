# Project_1_Deploy_A_Linux_EC2_Web_Server_Using_Terraform
## Project 11 Branching Update
Infra change tracked via feature branch and pull request workflow.

## GitHub Actions credentials

The Terraform plan queries AWS and requires valid credentials. Configure the
`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` repository Actions secrets,
and set `AWS_SESSION_TOKEN` as well when using temporary credentials. The
credentials need permissions to read the AMI and networking resources and to
manage the resources in this configuration. The apply job uses the `production`
environment, whose secrets can override repository secrets; ensure they identify
the same AWS account used for the plan. The AWS provider is configured for
`us-east-1` in `main.tf`.

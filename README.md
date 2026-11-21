# Project_1_Deploy_A_Linux_EC2_Web_Server_Using_Terraform
## Project 11 Branching Update
Infra change tracked via feature branch and pull request workflow.

## GitHub Actions credentials

The Terraform plan queries AWS and requires valid credentials. Configure the
repository Actions secrets `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`;
also configure `AWS_SESSION_TOKEN` when using temporary credentials. The plan
credentials need permission to read the AMI, VPC, subnet, and other resources
referenced by the configuration. The apply credentials additionally need
permission to create and modify the configured resources.

The apply job uses the `production` environment, where environment secrets may
override repository secrets. Configure its credentials and any required
approval rules in GitHub. The AWS provider targets `us-east-1`.

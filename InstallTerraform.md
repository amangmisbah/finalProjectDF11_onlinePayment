# Get Started With Terraform

## How to Install Terraform for GCP
You can follow [this](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli) instruction to install terraform in your local computer.

## How to Use Terraform
All instruction to build infrastructure on GCP with Terraform can see [this](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build) instruction

1. Set up your GCP account. Get service account key to make an acess for Terraform to GCP. You can see how to make service account key file [here](StartWithGCP.md)
2. Make folder and file ```main.tf``` to configure the infrastructure on GCP
3. Initialize the directory with ```terraform init```
4. Make infrastructure with ```terraform apply```, after that you will see ```Enter a value:``` and type ```yes``` for accepting the proceed
5. You can see your infrastructure that configured in Terraform file on your GCP account

## File Structure
In this repo you can see in ```streamp_rocessing/infratrsuture``` or  ```batch_rocessing/infratrsuture``` many Terraform files
1. ```main.tf``` <br> This is the main file of Terraform to configure the infrastructure on GCP. All resource used in this project you can see in this [link](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object)
2. ```provider.tf```<br> This is file to configure which provider that we used. In this project, we use google provider to GCP
3. ```versions.tf```<br> This is file to configure provider version
4. ```variables.tf```<br> This is file to configure variable in main file. The variables used to avoid hard coded in main file
5. ```terraform.tfvars```<br> This is file to configure the value of variable


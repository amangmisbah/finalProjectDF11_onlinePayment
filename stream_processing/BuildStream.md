# Stream Processing
![](/assets/stream/stream_infrastructure.png)
## Data Pipeline Explanation

### CSV Dataset

### Producer

### Kafka

### Consumer

### Email to Customer/Fraud Victim

### Google Cloud Storage (Data Lake)

## How to Build The Infrastructure
1. Make service account key file json. Replace the path in ```terraform.tfvars``` in variable ```credentials_project```
2. Make public and private key with ```ssh-keygen```. Replace the path in ```terraform.tfvars``` in variable ```public_key_vm``` for public key file ```[name_file].pub``` and ```private_key_vm``` for private key file ```[name_file]```. Public and private key is used to access VM to upload file with Terraform
3. Prepare your GCP account and replace your name project in ```terraform.tfvars``` in variable ```project```
4. Download the [dataset](https://www.kaggle.com/datasets/ealaxi/paysim1) and replace the path in ```terraform.tfvars``` in variable ```name_dataset```
5. Inside ```stream_processing/infrastructure``` insialize terraform with ```terraform init```
6. Apply the terraform with ```terraform apply```
7. The infrastructure is already build on GCP

## How to Run The Pipeline
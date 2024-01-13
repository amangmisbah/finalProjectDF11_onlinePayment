# Batch Processing
![](/assets/batch/batch_infrastructure.png)
## Data Pipeline Explanation

### Google Cloud Storage (Data Lake)
Google Cloud Storage as a Data Lake is used to collect all JSON file as a result of stream processing. It collected in separated folder, ```transaction/``` for Non Fraud Transaction, ```fraud_confirmation/``` for Fraud Transaction, and ```email_confirmation/``` for collected email log.<br>

### Google Big Query (Data Warehouse)
Google Big Query as a Data Warehouse is used to save data with a good structured data model. We used Medallion Architecture to make data modeling with a step ```Bronze (Staging)```, ```Silver(intermediate)``` and ```Gold(Data Mart)```

### Airflow (Scheduler)
Airflow as a Scheduler is used to scheduling the batch processing when it start to process. This is scheduling data move from Google Cloud Storage to Google Big Query with Google Cloud Function and data modeling with dbt in Google Big Query.

## How to Build The Infrastructure
1. Make service account key file json. Replace the path in ```terraform.tfvars``` in variable ```credentials_project```
2. Make public and private key with ```ssh-keygen```. Replace the path in ```terraform.tfvars``` in variable ```public_key_vm``` for public key file ```[name_file].pub``` and ```private_key_vm``` for private key file ```[name_file]```. Public and private key is used to access VM to upload file with Terraform
3. Prepare your GCP account and replace your name project in ```terraform.tfvars``` in variable ```project```
4. Inside ```batch_processing/infrastructure``` insialize terraform with ```terraform init```
6. Apply the terraform with ```terraform apply```
7. The infrastructure is already build on GCP

## How to Run The Pipeline
1. Start the Airflow Instance VM on GCP with name ```batch-processing```
2. Click SSH
3. Type ```sudo docker compose up```
4. Copy the external IP and access ```[external IP]:8080``` to access Aiflow UI
5. Fill user name with ```airflow``` and password ```password```
6. Search ```online_payment_log``` in DAG's Airflow
7. Click button beside word DAG or if you want trigger the pipeline outside of the schedule, you can click run button to trigger<br>
![](/assets/batch/airflow.png)
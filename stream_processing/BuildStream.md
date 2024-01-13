# Stream Processing
![](/assets/stream/stream_infrastructure.png)
## Data Pipeline Explanation

### CSV Dataset
CSV Dataset is saved in Google Cloud Storage. This dataset has arround 6,3 millions row and will be iterated by Producer. The purpose of this scenario is to perform near real case scenario in online payment transaction.

### Producer
Producer is a VM on GCP to produce message from iteration dataset. The message is splitted to two topics, ```fraud_transaction``` and ```non_fraud_transaction``` based on column ```isFraud``` value.

### Kafka
Kafka build on GCP VM with 3 brokers. All message in Kafka is based Avro format. This format makes message has Schema structured. Message from Producer VM will be consumed by Consumer VM.

### Consumer
Consumer is separated to two VM, Consumer Fraud and Consumer Not Fraud Instance VM. This consumers consume message from Kafka based on topic that VM subscribe.<br>

The scenario of project, Consumer VM has connection to other process to send an email to customer. After that, the result of stream processing is upload as JSON file to Google Cloud Storage.

### Email to Customer/Fraud Victim
This email notification and confirmation system is used to check the fraud detection system with real customer interaction. The customer interaction for fraud detection system will decrease false positive fraud detection. The highest accuration of fraud detection has big impact to increase customer trust.<br>

For the Non Fraud Transaction, the system send email notification about the transaction to the customer. For the Fraud Transaction, the system send email notification and confirmation about the transaction to confirm that transaction is fraud or not. If the customer didn't know about the transaction, it can be reported as a fraud, but otherwise it can be reported as not fraud.<br>

In this project, we assumed that all fraud detection in ```isFraud``` column is corrected.

### Google Cloud Storage (Data Lake)
Google Cloud Storage as a Data Lake is used to collect all JSON file as a result of stream processing. It collected in separated folder, ```transaction/``` for Non Fraud Transaction, ```fraud_confirmation/``` for Fraud Transaction, and ```email_confirmation/``` for collected email log.

## How to Build The Infrastructure
1. Make service account key file json. Replace the path in ```terraform.tfvars``` in variable ```credentials_project```
2. Make public and private key with ```ssh-keygen```. Replace the path in ```terraform.tfvars``` in variable ```public_key_vm``` for public key file ```[name_file].pub``` and ```private_key_vm``` for private key file ```[name_file]```. Public and private key is used to access VM to upload file with Terraform
3. Prepare your GCP account and replace your name project in ```terraform.tfvars``` in variable ```project```
4. Download the [dataset](https://www.kaggle.com/datasets/ealaxi/paysim1) and replace the path in ```terraform.tfvars``` in variable ```name_dataset```
5. Inside ```stream_processing/infrastructure``` insialize terraform with ```terraform init```
6. Apply the terraform with ```terraform apply```
7. The infrastructure is already build on GCP

## How to Run The Pipeline
### Start Kafka
1. Start the Kafka Instance VM on GCP
2. Click SSH
3. Type ```sudo docker compose up```
4. Copy the external IP and access ```[external IP]:9080``` to access Kafka UI <br>
![](/assets/stream/kafka_ui.png)

### Start Consumer
1. Start Consumer Fraud and Consumer Not Fraud Instance VM on GCP
2. Click SSH
3. Upload manualy your service account key json to VM with name ```service-account.json```. This service account key json is used to access Google Cloud Storage for uploading json file result of the stream processing
4. Type ```python3 consumer_fraud_transaction.py``` for Consumer Fraud VM and ```python3 consumer_non_fraud_transaction.py``` for Consumer Not Fraud VM

### Start Producer
1. Start Producer Instance VM on GCP
2. Click SSH
3. Upload manualy your service account key json to VM with name ```service-account.json```. This service account key json is used to access Google Cloud Storage for get data from dataset
4. Type ```python3 produce_transaction.py``` for Producer VM
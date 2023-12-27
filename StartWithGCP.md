# Get Started With GCP

## Make GCP Account
1. Make your GCP account with your Google account in https://console.cloud.google.com/ . You can get free trial account with limited credit and time.
2. After you registered, you can see this page<br>
![](assets/gcp/gcp_overview.png)
3. You can see your project and tools in GCP<br>
![](assets/gcp/project_gcp.png)<br>
![](assets/gcp/tools_gcp.png)

## Service Account
We need to make service account key to give acess for us to running terraform and dbt.
1. Choose IAM & Admin and select service account<br>
![](assets/gcp/sa-step1.png)
2. Select create service account<br>
![](assets/gcp/sa-step2.png)
3. Fill with your service account name in first step<br>
![](assets/gcp/sa-step3.png)
4. In second step choose "Basic" with roles "Owner". After that click Done<br>
![](assets/gcp/sa-step4.png)
5. Service account will be created like this<br>
![](assets/gcp/sa-step5.png)
6. Click service account and choose "Keys"<br>
![](assets/gcp/sa-step6.png)
7. Click add key and then create new key<br>
![](assets/gcp/sa-step7.png)
8. Choose JSON and click create<br>
![](assets/gcp/sa-step8.png)
9. You can place and rename the json key file inside this folder project

## GCP Tools in Project
We use some tools in GCP to build this project

### Virtual Machine
All services in this project : producer, consumer, kafka and airflow is build with virtual machine <br>
![](assets/gcp/vm-gcp.png)

### Google Cloud Storage
Google Cloud Storage (GCS) as a data lake in this project <br>
![](assets/gcp/gcs-gcp.png)

### BigQuery
BigQuery is place as a data warehouse to store all data with medalion architecture to serve in dashboard <br>
![](assets/gcp/bq-gcp.png)

### Cloud Function
Cloud Function as a trigger for transfering result stream data from GCS to BigQuery <br>
![](assets/gcp/cloud_function-gcp.png)
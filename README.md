# GKE Modernization & Observability Platform

## 🏗️ Project Overview
This project demonstrates a transition from legacy infrastructure to a modern **Cloud-Native stack**. It features a regional **GKE cluster** provisioned via **Terraform**, with a full **Prometheus/Grafana** stack deployed via **Helm**.

## 🚀 Key Features
* **Infrastructure as Code:** GKE cluster lifecycle managed entirely via Terraform.
* **Remote State:** Terraform state managed in a **GCS bucket** with state locking.
* **Automated Observability:** Implementation of the **Prometheus Operator** pattern via Helm.
* **Proactive Alerting:** Integrated **Slack Webhooks** for real-time memory-threshold alerts.

## 📊 Monitoring in Action
![Grafana Dashboard](./screenshots/grafana-dashboard.png)
*Real-time cluster health visualization showing CPU overcommitment and Node health.*

## 🛠️ How to Deploy
1. `cd terraform && terraform apply`
2. `helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring`
3. `kubectl apply -f app-deployment.yaml`
# Caprivax GKE Modernization Platform ☸️
### Enterprise Kubernetes Orchestration with GitOps & Granular RBAC Security

![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Helm](https://img.shields.io/badge/helm-%230F1628.svg?style=for-the-badge&logo=helm&logoColor=white)
![GCP](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)

## 📌 Project Overview
A production-grade implementation of a **Google Kubernetes Engine (GKE)** cluster and Automated CI/CD Platform. This project demonstrates a mature GitOps workflow, providing a secure, scalable, and fully monitored environment for enterprise microservices using the **Principle of Least Privilege**.



### 🌟 Architectural Design
* **Infrastructure as Code:** Modular Terraform configuration with **GCS Remote Backend** for state locking and environment parity.
* **Hardened Security:** Implementation of **Workload Identity**, **IAP Tunneling**, and granular **K8s RBAC**.
* **GitOps Orchestration:** Jenkins-as-Code (Groovy DSL) managing multi-stage deployment pipelines.
* **Observability:** Full-stack monitoring via **Prometheus & Grafana** with integrated Slack Alerting.

---

## 📂 Project Structure
```text
caprivax-gke-project/
├── terraform/                # Modular GKE, VPC, and Node Pool definitions
├── kubernetes/               # Manifests for Workloads, Services, and RBAC
├── screenshots/              # Visual proof of Monitoring & Cluster Health
└── terraform-pipelines/      # Groovy DSL Jenkinsfiles for GitOps automation

🛠️ Operational Metrics Baseline
Monitoring is not just about charts; it's about knowing when to act. This project uses the following SRE baselines:

Metric            Normal Range        Critical Threshold      Action Plan
Node CPU          10-60%              >90%                    Trigger Horizontal Cluster Autoscaler
Pod Throttling    <1%                  >20%                    Increase Resource CPU Limits
Memory Usage      20-70%               >90%                    Investigate Memory Leaks / OOMKills

🚀 Technical Execution

1.Provisioning Infrastructure
Bash
cd terraform
terraform init
terraform apply -auto-approve

2. Observability & RBAC Troubleshooting
During deployment, I resolved a critical 403 Forbidden scraping error. Instead of granting cluster-admin (insecure), I authored a granular ClusterRole to grant Prometheus exactly the permissions needed to scrape metrics.

Accessing Grafana:
Bash
# Retrieve the auto-generated admin password
kubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Port-forward the dashboard
kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80

🔒 Security Posture & RBAC Fix
The RBAC Fix: Scoped a dedicated ServiceAccount and ClusterRoleBinding 
to allow metrics scraping while maintaining the Principle of Least Privilege.

Workload Identity: Eliminated the need for static service account keys by mapping K8s ServiceAccounts to GCP IAM roles.

👤 Author
Marcel Owhonda - Cloud & DevOps Engineer
- GitHub: [@Marcel2tight](https://github.com/Marcel2tight)
- LinkedIn: [Marcel Owhonda](https://www.linkedin.com/in/marcel-owhonda-devops)
Built to demonstrate mastery in Kubernetes modernization and cloud-native security.
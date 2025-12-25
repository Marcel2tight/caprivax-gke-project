Caprivax CI/CD & GKE Modernization Platform
Project Overview
A production-grade implementation of a Google Kubernetes Engine (GKE) cluster and Automated CI/CD Platform. This project demonstrates a 7-year evolution from manual cloud configuration to a mature GitOps and IaC workflow, providing a secure, scalable, and fully monitored environment for enterprise microservices.
Architectural Design
The platform is built using a Decoupled Modular Architecture to ensure environment parity across Dev, Staging, and Production.

Infrastructure as Code: Modular Terraform configuration with a GCS Remote Backend for state locking.

Security: Implementation of Workload Identity, IAP Tunneling, and granular RBAC (Principle of Least Privilege).

Orchestration: Jenkins-as-Code (Groovy DSL) managing multi-environment deployment pipelines.

Observability: Full-stack monitoring via Prometheus and Grafana with integrated Slack Alerting.
Technical Execution & Commands
Provisioning Infrastructure
Bash
cd terraform
terraform init
terraform apply -auto-approve
Observability & Troubleshooting
The monitoring stack was deployed via Helm. I resolved a critical 403 Forbidden scraping error by authoring a granular RBAC ClusterRole to grant Prometheus necessary permissions without using cluster-admin permissions.

Accessing the Dashboard:

Retrieve the admin password:

Bash

kubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
Port-forward the service:
Bash

kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80

Operational Metrics Baseline
Metric	          Normal	       Critical	      Action
Node CPU	        10-60%	       > 90%	        Scale Node Pool
Pod Throttling	  < 1%	         > 20%	        Increase CPU Limits
Memory Usage	    20-70%	       > 90%	        Check for Memory Leaks

Technical Challenges Overcome
The RBAC Fix: Scoped a dedicated ServiceAccount and ClusterRoleBinding to allow metrics scraping while maintaining the Principle of Least Privilege.
Git History Optimization: Optimized .gitignore and stripped bloated binary history to ensure a lightweight, clean GitOps workflow.
Msgpack Bug Fix: Implemented logic within the Jenkins pipeline to handle Terraform encoding errors, ensuring CI/CD resilience.

Cleanup
To avoid unnecessary GCP costs, infrastructure is managed by a full lifecycle command:
Bash
terraform destroy -auto-approve






Caprivax GKE Modernization Project 🚀A production-grade implementation of a Google Kubernetes Engine (GKE) cluster using Infrastructure as Code (Terraform), featuring a full-stack observability suite (Prometheus/Grafana) and automated Slack alerting.🎯 Project OverviewThis project demonstrates the transition from manual cloud configuration to a mature GitOps and IaC workflow. It provides a secure, scalable, and fully monitored environment for containerized microservices.Key FeaturesInfrastructure as Code: Modular Terraform configuration with a GCS Remote Backend.High Availability: 3-node regional cluster with managed node pools.Security: Implementation of Workload Identity and granular RBAC (Principle of Least Privilege).Observability: Full-stack monitoring using Helm, Prometheus, and Grafana.Validation: Proactive stress-testing to verify alerting thresholds.🏗️ Project StructurePlaintextcaprivax-gke-project/
├── terraform/                  # Infrastructure as Code
│   ├── main.tf                 # GKE Cluster & Node Pool
│   ├── variables.tf            # Input Variables
│   ├── outputs.tf              # Connection Outputs
├── kubernetes/                 # K8s Manifests
│   ├── app-deployment.yaml     # Application & LoadBalancer
│   ├── prometheus-rbac.yaml    # RBAC Fix for Monitoring
│   ├── stress-test.yaml        # Alert Testing Pod
├── screenshots/                # Evidence of Work
│   ├── grafana-dashboard.png
│   └── slack-alert.png
└── README.md
🛠️ Technical Execution1. Provisioning InfrastructureThe infrastructure is defined in Terraform, utilizing a remote state backend in Google Cloud Storage to allow for team collaboration and state locking.Bashcd terraform
terraform init
terraform apply -auto-approve
2. Cluster Security (Workload Identity)I implemented Workload Identity to eliminate the need for static Service Account JSON keys. This maps Kubernetes Service Accounts (KSA) directly to Google IAM roles.3. Observability & TroubleshootingThe monitoring stack was deployed via Helm. A critical challenge involved a 403 Forbidden error during metrics scraping, which I resolved by authoring a granular RBAC ClusterRole to grant Prometheus the necessary permissions without using cluster-admin.Accessing the Dashboard:Retrieve the admin password:Bashkubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
Port-forward the service:Bashkubectl port-forward svc/monitoring-grafana -n monitoring 3000:80
📊 Operational Metrics BaselineI established a performance baseline to ensure the cluster operates within healthy parameters.MetricNormalCriticalActionNode CPU10-60%> 90%Scale Node PoolPod Throttling< 1%> 20%Increase CPU LimitsMemory Usage20-70%> 90%Check for Memory Leaks⚠️ Technical Challenges Overcome🛡️ The RBAC FixProblem: Prometheus metrics were empty due to permission errors.Solution: Created a dedicated ServiceAccount and scoped ClusterRoleBinding to allow scraping while maintaining the Principle of Least Privilege.🐙 Git History ScrubbingProblem: Push rejected due to 100MB+ Terraform binaries in history.Solution: Optimized the .gitignore and performed a targeted repository isolation to strip bloated binary history, resulting in a lightweight, clean GitOps workflow.🧹 CleanupTo avoid unnecessary GCP costs, the infrastructure is managed by a full lifecycle.Bashterraform destroy -auto-approve
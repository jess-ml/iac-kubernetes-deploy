# 🚀 Déploiement Automatisé IaC – Kubernetes (K3d) + Nginx

> Projet personnel – Infrastructure as Code  
> Certification Expert Informatique SI – RNCP Niveau 7 | EPSI

---

## 📋 Description

Industrialisation du déploiement d'une application Nginx via une chaîne 
IaC complète : création d'image personnalisée avec **Packer**, déploiement 
sur un cluster **Kubernetes léger (K3d)** à l'aide d'**Ansible**, le tout 
orchestré dans un environnement **GitHub Codespaces**.

---

## 🔄 Workflow du projet
```
Packer → Image Nginx personnalisée
↓
K3d  → Cluster Kubernetes local (1 control-plane + 2 workers)
↓
Ansible → Déploiement de l'application sur le cluster
↓
GitHub Codespaces → Environnement de développement unifié
```
---

## 🛠️ Stack technique

| Outil | Rôle |
|-------|------|
| **Packer** | Création d'images Docker Nginx personnalisées |
| **K3d** | Cluster Kubernetes léger (K3s dans Docker) |
| **Ansible** | Automatisation du déploiement sur le cluster |
| **kubectl** | Gestion des ressources Kubernetes |
| **GitHub Codespaces** | Environnement de développement cloud |
| **Docker** | Conteneurisation |

---

## 📁 Structure du repo
```
iac-kubernetes-deploy/
├── README.md
├── packer/
│   └── nginx.pkr.hcl          # Template Packer pour l'image Nginx
├── ansible/
│   ├── playbook.yml            # Playbook de déploiement
│   └── inventory.ini           # Inventaire des hôtes
└── k8s/
├── nginx-deployment.yaml   # Déploiement Kubernetes
└── nginx-service.yaml      # Service Kubernetes
```

---

## 🚀 Lancer le projet

### Prérequis
- Docker installé
- K3d installé (`curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash`)
- Ansible installé (`pip install ansible`)
- Packer installé

### 1 — Créer l'image Nginx avec Packer
```bash
cd packer
packer init .
packer build nginx.pkr.hcl
```

### 2 — Créer le cluster K3d
```bash
k3d cluster create mon-cluster \
  --agents 2 \
  --port "8080:80@loadbalancer"
```

### 3 — Déployer avec Ansible
```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

### 4 — Vérifier le déploiement
```bash
kubectl get pods
kubectl get services
```

### 5 — Accéder à l'application

http://localhost:8080

---

## 👤 Réalisé par J.M

Projet personnel réalisé dans le cadre de l'apprentissage IaC  
**Expert Informatique et Système d'Information – RNCP Niveau 7**  
EPSI | Promotion 2024-2026

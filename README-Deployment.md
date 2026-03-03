# dave

Kubernetes deployment for dave using Helm and Docker.

## Quick Start

### Prerequisites

- Docker
- kubectl configured with your cluster
- Helm 3.x
- cert-manager installed in your cluster
- NGINX Ingress Controller installed

### Build and Deploy

```bash
# 1. Build and push Docker image
docker build -t molgenis/molgenis-dave-streamlit:latest .
docker push molgenis/molgenis-dave-streamlit:latest

# 2. Configure DNS
# Point dave.molgeniscloud.org to your ingress controller's external IP

# 3. Update email in letsencrypt-issuer.yaml (first time only)
# Edit letsencrypt-issuer.yaml and change your-email@example.com

# 4. Apply Let's Encrypt issuer (first time only)
kubectl apply -f letsencrypt-issuer.yaml

# 5. Deploy with Helm
helm install dave ./helm-chart

# 6. Check status
kubectl get pods
kubectl get ingress
kubectl get certificate
```

## Configuration

### values.yaml

Key configuration options:

- `image.repository`: Docker image repository
- `image.tag`: Docker image tag
- `ingress.hosts`: Domain configuration
- `ingress.tls`: TLS/SSL certificate configuration
- `resources`: CPU and memory limits

### Custom Values

```bash
# Deploy with custom image tag
helm install dave ./helm-chart --set image.tag=v1.0.0

# Use staging Let's Encrypt for testing
helm install dave ./helm-chart \
  --set ingress.annotations."cert-manager\.io/cluster-issuer"=letsencrypt-staging
```

## Updating

```bash
# Build new version
docker build -t molgenis/molgenis-dave-streamlit:v2 .
docker push molgenis/molgenis-dave-streamlit:v2

# Upgrade deployment
helm upgrade dave ./helm-chart --set image.tag=v2
```

## Accessing the Application

After deployment, your application will be available at:
- **https://dave.molgeniscloud.org**

SSL certificate is automatically provisioned by Let's Encrypt.

## Troubleshooting

### Certificate Issues

```bash
# Check certificate status
kubectl describe certificate dave-tls

# View cert-manager logs
kubectl logs -n cert-manager -l app=cert-manager

# Force certificate renewal
kubectl delete certificate dave-tls
```

### DNS Issues

```bash
# Verify DNS resolution
nslookup dave.molgeniscloud.org

# Get ingress external IP
kubectl get ingress dave
```

### Pod Issues

```bash
# Check pod status
kubectl get pods -l app.kubernetes.io/name=dave

# View pod logs
kubectl logs -l app.kubernetes.io/name=dave

# Describe pod for events
kubectl describe pod -l app.kubernetes.io/name=dave
```

## Cleanup

```bash
# Remove deployment
helm uninstall dave

# Remove certificate (optional)
kubectl delete certificate dave-tls
```

## Directory Structure

```
.
├── Dockerfile
├── .dockerignore
├── index.html
├── letsencrypt-issuer.yaml
├── README.md
└── helm-chart/
    ├── Chart.yaml
    ├── values.yaml
    └── templates/
        ├── _helpers.tpl
        ├── deployment.yaml
        ├── service.yaml
        └── ingress.yaml
```

## Support

For issues related to:
- **Kubernetes**: Check cluster logs and events
- **Helm**: Run `helm status dave`
- **cert-manager**: Check cert-manager logs
- **DNS**: Verify DNS propagation with `dig dave.molgeniscloud.org`

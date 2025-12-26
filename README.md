# kubectl Docker Image

[![GitHub release](https://img.shields.io/github/v/release/kubernetes/kubernetes?label=ghcr.io/licenseware/kubectl&logo=docker&logoColor=white)](https://github.com/kubernetes/kubernetes/releases)
[![Docker Hub](https://img.shields.io/docker/pulls/licenseware/kubectl?logo=docker&logoColor=white)](https://hub.docker.com/r/licenseware/kubectl)
[![Docker Image Size](https://img.shields.io/docker/image-size/licenseware/kubectl?logo=docker&logoColor=white)](https://hub.docker.com/r/licenseware/kubectl)
[![CI](https://github.com/licenseware/kubectl/actions/workflows/ci.yml/badge.svg)](https://github.com/licenseware/kubectl/actions/workflows/ci.yml)
[![Vulnerabilities](https://img.shields.io/badge/vulnerabilities-scanned-green?logo=security&logoColor=white)](https://github.com/licenseware/kubectl/security)
[![Alpine Version](https://img.shields.io/badge/alpine-3-blue?logo=alpine-linux&logoColor=white)](https://alpinelinux.org/)
[![License](https://img.shields.io/github/license/licenseware/kubectl?logo=opensourceinitiative&logoColor=white)](LICENSE)
[![Cosign](https://img.shields.io/badge/signed-cosign-blue?logo=sigstore&logoColor=white)](https://github.com/sigstore/cosign)

A minimal, secure, and automatically updated Docker image containing kubectl binary based on Alpine Linux.

## 🚀 Features

- **Minimal**: Based on Alpine Linux for smallest possible image size
- **Secure**: Runs as non-root user (`nobody`)
- **Auto-updated**: Automatically builds new images when kubectl releases are published
- **Signed**: Container images are signed with Cosign for supply chain security
- **Scanned**: Security vulnerabilities scanned with Kubescape
- **Multi-arch**: Supports multiple architectures (if configured)

## 📦 Usage

### Quick Start

```bash
docker run --rm -v ~/.kube:/home/nobody/.kube:ro ghcr.io/licenseware/kubectl:vX.Y.Z kubectl version
```

### With Kubernetes Config

```bash
docker run --rm \
  -v ~/.kube:/home/nobody/.kube:ro \
  -v $(pwd):/workspace \
  -w /workspace \
  ghcr.io/licenseware/kubectl:vX.Y.Z kubectl get pods
```

### Docker Compose

```yaml
version: "3.8"
services:
  kubectl:
    image: ghcr.io/licenseware/kubectl:vX.Y.Z
    volumes:
      - ~/.kube:/home/nobody/.kube:ro
      - ./manifests:/workspace
    working_dir: /workspace
    command: kubectl apply -f .
```

### Kubernetes Job

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: kubectl-job
spec:
  template:
    spec:
      containers:
        - name: kubectl
          image: ghcr.io/licenseware/kubectl:vX.Y.Z
          command: ["kubectl", "get", "nodes"]
      restartPolicy: Never
```

## 🏷️ Available Tags

- `vX.Y.Z` - Specific kubectl versions (e.g., `v1.28.0`, `v1.29.1`)

All images are automatically built and published when new kubectl versions are released.

## 🔒 Security

### Image Signing

All container images are signed using [Cosign](https://github.com/sigstore/cosign). Verify the signature:

```bash
cosign verify ghcr.io/licenseware/kubectl:vX.Y.Z \
  --certificate-identity-regexp="https://github.com/licenseware/kubectl/.*" \
  --certificate-oidc-issuer="https://token.actions.githubusercontent.com"
```

### Security Scanning

Images are automatically scanned for vulnerabilities using Kubescape as part of the CI pipeline.

### Non-root User

The container runs as the `nobody` user (UID 65534) for enhanced security.

## 🛠️ Building Locally

```bash
git clone https://github.com/licenseware/kubectl.git
cd kubectl

# Build with specific kubectl version
docker build --build-arg KUBECTL_VERSION=v1.28.0 -t kubectl:v1.28.0 .

# Build with latest version
docker build -t kubectl:v1.28.0 .
```

## 🔄 Automated Updates

This project uses GitHub Actions to:

- Check for new kubectl releases weekly
- Automatically build and push new Docker images
- Sign images with Cosign
- Scan for security vulnerabilities

## 📋 Requirements

- Docker or compatible container runtime
- Kubernetes configuration file (for cluster access)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Kubernetes](https://kubernetes.io/) for the kubectl binary
- [Alpine Linux](https://alpinelinux.org/) for the base image
- [GitHub Actions](https://github.com/features/actions) for CI/CD
- [Cosign](https://github.com/sigstore/cosign) for container signing

---

**Note**: This is an unofficial kubectl Docker image. For official Kubernetes images, visit the [Kubernetes registry](https://registry.k8s.io/).

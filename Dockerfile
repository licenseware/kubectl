FROM alpine:3.23@sha256:469c9ea410b9215eaee7976ba6c0639039b444be8e5d638f7abbada189971eb2

# renovate: github-releases=kubernetes/kubernetes
ENV KUBECTL_DEFAULT_VERSION v1.35.10
ARG KUBECTL_VERSION=${KUBECTL_DEFAULT_VERSION}
ARG TARGETARCH

RUN apk upgrade --no-cache && \
  apk add --no-cache curl ca-certificates bash && \
  curl -fsSLO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
  echo "$(curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl.sha256")  kubectl" | sha256sum -c - && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin/ && \
  apk del curl

USER nobody:nobody

FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

# renovate: github-releases=kubernetes/kubernetes
ENV KUBECTL_DEFAULT_VERSION v1.37.2
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

FROM alpine:3.19.1

# Install required packages
RUN apk update && apk --no-cache add \
  bash \
  curl \
  git \
  && rm -rf /var/cache/apk/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install kustomize
RUN curl -sL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.4.1/kustomize_v5.4.1_linux_amd64.tar.gz \
  | tar xz -C /usr/local/bin

# Install kustomize-diff
RUN curl -sL https://github.com/Namoshek/kustomize-diff/releases/download/v0.3.0/kustomize-diff-v0.3.0-linux-amd64.tar.gz \
  | tar xz \
  && chmod +x kustomize-diff \
  && mv kustomize-diff /usr/local/bin/

# Copy the script
COPY kustdiff /kustdiff
RUN chmod +x /kustdiff

ENTRYPOINT ["/kustdiff"]

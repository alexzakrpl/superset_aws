# Base image with Debian
FROM debian:bullseye-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    gnupg \
    software-properties-common \
    lsb-release \
    git \
    awscli \
    vim \
    bash \
    openssh-client \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install Terraform
ARG TERRAFORM_VERSION=1.7.5
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

# Install boto3 for AWS SDK in Python
RUN pip3 install boto3

# Create vscode user if it doesn't exist
RUN id vscode || useradd -ms /bin/bash vscode

# Set working directory
WORKDIR /workspace

# Set user
USER vscode

# Default shell
SHELL ["/bin/bash", "-c"]

# Set entrypoint
CMD ["bash"]

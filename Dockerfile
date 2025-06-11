FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    libffi-dev \
    git \
    wget \
    curl \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create user
RUN useradd -ms /bin/bash odoo

# Set working directory
WORKDIR /opt/odoo

# Copy project files
COPY . /opt/odoo

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Fix permissions
RUN chown -R odoo:odoo /opt/odoo

# Switch to non-root user
USER odoo

# Expose the Odoo port
EXPOSE 8080

# Railway sets PORT env var dynamically
ENV PORT=8080

# Run Odoo with correct config
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]

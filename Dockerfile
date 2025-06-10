FROM python:3.10

# Install dependencies
RUN apt-get update && apt-get install -y \
    git wget nodejs npm python3-dev libxml2-dev libxslt1-dev \
    zlib1g-dev libsasl2-dev libldap2-dev libjpeg-dev libpq-dev \
    build-essential libssl-dev libffi-dev && \
    pip install --upgrade pip

# Create odoo user
RUN useradd -ms /bin/bash odoo

# Set working directory
WORKDIR /opt/odoo

# Copy source code
COPY . /opt/odoo

# Install python dependencies
RUN pip install -r requirements.txt

# Fix permissions
RUN chown -R odoo:odoo /opt/odoo

# Switch to odoo user
USER odoo

# Expose port
EXPOSE 8069

# Start Odoo
CMD ["python3", "odoo-bin", "-c", "odoo.conf"]

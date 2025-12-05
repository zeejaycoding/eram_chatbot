FROM rasa/rasa:3.4.0-spacy-en

# Switch to root to install supervisor
USER root
RUN apt-get update && apt-get install -y --no-install-recommends supervisor \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only your model first
COPY models/*.tar.gz ./models/

# Copy the rest of the project
COPY . .

# Install Rasa SDK (no transformers)
RUN pip install --no-cache-dir rasa-sdk==3.4.0

# Add supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Switch back to non-root user
USER 1001

# Expose ports
EXPOSE 5005 5055

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

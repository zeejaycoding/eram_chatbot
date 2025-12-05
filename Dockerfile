FROM rasa/rasa:3.4.0-full

USER root
RUN apt-get update && apt-get install -y --no-install-recommends supervisor \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy model first
COPY models/*.tar.gz ./models/

# Copy project
COPY . .

# Install SDK + transformers + sentence-transformers
RUN pip install --no-cache-dir \
    rasa-sdk==3.4.0 \
    sentence-transformers \
    transformers \
    torch \
    onnxruntime==1.17.0

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER 1001

EXPOSE 5005 5055
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

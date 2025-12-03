FROM rasa/rasa:3.6.20-full

COPY . /app

USER root

RUN apt-get update && apt-get install -y supervisor && \
    pip install --no-cache-dir -r requirements.txt && \
    python -m spacy download en_core_web_sm

RUN rasa train

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5005 5055

USER 1001

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
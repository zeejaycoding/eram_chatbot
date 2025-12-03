FROM rasa/rasa:3.6.20

# Install system dependencies
RUN apt-get update && apt-get install -y gcc libffi-dev libssl-dev python3-dev

# Upgrade pip
RUN pip install --upgrade pip

# Copy your project
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install spaCy model
RUN python -m spacy download en_core_web_sm

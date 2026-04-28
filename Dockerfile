FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

# Fix ImageMagick policy for moviepy
RUN sed -i 's/<policy domain="path" rights="none" pattern="@\*"/<!--<policy domain="path" rights="none" pattern="@\*"\/-->/g' /etc/ImageMagick-6/policy.xml || true

CMD ["python", "server/app.py"]

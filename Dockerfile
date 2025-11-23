# Use slim Python 3.10 image
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libgl1 \
    libglib2.0-0 \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone the correct FastSD CPU repository
RUN git clone https://github.com/rupeshs/fastsdcpu.git .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose API port
EXPOSE 8001

# Start FastSD CPU in API mode
CMD ["python", "src/app.py", "--api"]

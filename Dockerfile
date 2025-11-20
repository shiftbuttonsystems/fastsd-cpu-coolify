FROM python:3.11-slim

WORKDIR /app

# System dependencies
RUN apt-get update && apt-get install -y git wget unzip build-essential && \
    rm -rf /var/lib/apt/lists/*

# Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN python -m venv venv
RUN . venv/bin/activate && pip install --no-cache-dir -r requirements.txt

# Copy FastSD CPU nodes
COPY custom_nodes/fast-sd-cpu custom_nodes/fast-sd-cpu

# Copy models
COPY models/ models/

# Expose port for ComfyUI
EXPOSE 8188

# Entrypoint
COPY start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]

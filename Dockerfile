# ----------------------------
# FastSD CPU + Flux Q8 for Coolify
# ----------------------------
FROM python:3.11-slim

WORKDIR /app

# ----------------------------
# Install system dependencies
# ----------------------------
RUN apt-get update && apt-get install -y \
    git wget unzip build-essential curl \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Install Python dependencies
# ----------------------------
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ----------------------------
# Clone ComfyUI
# ----------------------------
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# Create Python venv
RUN python -m venv venv
RUN . venv/bin/activate && pip install --no-cache-dir -r requirements.txt

# ----------------------------
# Add FastSD CPU nodes
# ----------------------------
RUN mkdir -p custom_nodes && cd custom_nodes && \
    git clone https://github.com/TheLastBen/fast-sd-cpu.git

# ----------------------------
# Download Flux Q8 GGUF model automatically
# ----------------------------
RUN mkdir -p models/checkpoints && cd models/checkpoints && \
    wget https://huggingface.co/city96/FLUX.1-schnell-gguf/resolve/main/flux1-schnell-q8.gguf

# ----------------------------
# Expose ComfyUI port
# ----------------------------
EXPOSE 8188

# ----------------------------
# Entrypoint
# ----------------------------
COPY start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]

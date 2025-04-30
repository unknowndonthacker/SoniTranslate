# Use a base image with CUDA support
# New image nvidia/cuda:12.8.1-cudnn-runtime-ubuntu22.04
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y ffmpeg

# Install Python and pip
RUN apt-get install -y python3-pip git

# Clone SoniTranslate repository
RUN git clone https://github.com/unknowndonthacker/SoniTranslate

# Change to SoniTranslate directory
WORKDIR /app/SoniTranslate

# Install requirements
RUN pip3 install -r requirements_base.txt
RUN pip3 install -r requirements_extra.txt
RUN pip3 install onnxruntime-gpu[cuda,cudnn]
# TTS
RUN pip3 install -q piper-tts==1.2.0
RUN pip3 install -q -r requirements_xtts.txt
RUN pip3 install -q TTS==0.21.1  --no-deps
#NEW
#RUN pip3 install coqui-tts

# Set environment variables
ENV YOUR_HF_TOKEN="XXX"
ENV OPENAI_API_KEY="XXX"

# Expose port
EXPOSE 7860
RUN sed -i '/app\.launch(/,/debug=/s/max_threads=1,/max_threads=1, server_name="0.0.0.0",/' /app/SoniTranslate/app_rvc.py

# Run command to start SoniTranslate
CMD ["python3", "app_rvc.py"]

#docker run -it --gpus all -p 80:7860 -v model-data:/app/SoniTranslate/mdx_models -v cache-data:/root/.cache -e YOUR_HF_TOKEN="you-token" --name sonitranslate soni_translate_image
docker run -it --gpus all -p 80:7860 -v model-data:/app/SoniTranslate/mdx_models -v cache-data:/root/.cache --name sonitranslate soni_translate_image

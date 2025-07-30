from PIL import Image
import os

# Defina os diretórios de entrada e saída
input_folder = "../tokensTeste"
output_folder = "../tokens"

# Crie o diretório de saída se não existir
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Converta cada arquivo PNG em WebP
for filename in os.listdir(input_folder):
    if filename.endswith('.png'):
        # Abra a imagem PNG
        img = Image.open(os.path.join(input_folder, filename))
        
        # Verifique se a imagem tem um canal alfa (transparência)
        if img.mode in ('RGBA', 'LA') or (img.mode == 'P' and 'transparency' in img.info):
            img = img.convert('RGBA')
        
        # Defina o caminho do arquivo de saída com a extensão .webp
        output_file = os.path.join(output_folder, filename.replace('.png', '.webp'))
        
        # Salve a imagem como WebP com qualidade de 72% e mantendo a transparência
        img.save(output_file, 'webp', quality=72, lossless=False, optimize=True, transparency=img.info.get('transparency'))

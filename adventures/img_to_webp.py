from PIL import Image
import os

def convert_images_to_webp(root_dir):
    # Percorre todos os diretórios e arquivos a partir do diretório raiz
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            # Verifica se o arquivo tem extensão .jpg ou .jpeg
            if file.lower().endswith(('.jpg', '.jpeg')):
                file_path = os.path.join(root, file)
                # Define o caminho do novo arquivo .webp
                new_file_path = os.path.splitext(file_path)[0] + '.webp'
                
                try:
                    # Abre a imagem e converte para .webp
                    with Image.open(file_path) as img:
                        img.convert('RGB').save(new_file_path, 'WEBP')
                    print(f'Convertido {file_path} para {new_file_path}')
                except Exception as e:
                    print(f'Erro ao converter {file_path}: {e}')

# Diretório raiz onde começar a busca
root_directory = r'C:\Users\Yanbd\AppData\Local\FoundryVTT\VersoesAltFoundry\Data\modules\modulo-yan-dmdave\adventures'
convert_images_to_webp(root_directory)

import re
import os

# Diretórios base
old_base_pattern = r'modules/dmdave-[^/]+/tokens/'
new_base_dir = 'modules/modulo-yan-dmdave/tokens/'

# Função para substituir o caminho da imagem
def replace_image_path(content):
    # Expressão regular para encontrar todos os caminhos de imagem com qualquer diretório base
    pattern = re.compile(rf'{old_base_pattern}([^"\']+\.(png|jpg|jpeg|gif))')
    
    def replace_match(match):
        old_path = match.group(0)
        file_name = match.group(1)
        file_ext = match.group(2)
        new_file_name = file_name.rsplit('.', 1)[0] + '.webp'
        new_path = new_base_dir + new_file_name
        return new_path
    
    # Substituir todos os caminhos encontrados
    return pattern.sub(replace_match, content)

# Caminho do arquivo
# Ajuste o caminho relativo de acordo com a nova localização do script
file_path = '../packs/actors.db'

# Ler o conteúdo do arquivo
with open(file_path, 'r', encoding='utf-8') as file:
    content = file.read()

# Substituir os caminhos de imagem
new_content = replace_image_path(content)

# Escrever o conteúdo de volta ao arquivo
with open(file_path, 'w', encoding='utf-8') as file:
    file.write(new_content)

print("Substituições concluídas com sucesso.")

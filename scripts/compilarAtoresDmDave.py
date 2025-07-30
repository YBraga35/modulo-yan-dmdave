import os
import glob
import json

# Diretório onde estão os arquivos .db
diretorio = '../packs'  # Ajuste do diretório, pois o script foi movido para '../scripts'

# Lista de arquivos .db que você quer combinar
arquivos_db = ['actors.db', 'items.db', 'journal.db', 'macros.db', 'playlists.db', 'scenes.db']

# Função para extrair o nome da aventura do arquivo actors.db
def extrair_nome_aventura(caminho_db):
    with open(caminho_db, 'r') as infile:
        data = infile.read()
        registros = json.loads(f"[{data.strip().replace('}{', '},{')}]")
        for registro in registros:
            if "src" in registro:
                src = registro["src"]
                if "modules/" in src:
                    # Extrai o nome da aventura entre "modules/" e a próxima "/"
                    nome_aventura = src.split("modules/")[1].split("/")[0]
                    return nome_aventura
    return "nome_da_aventura"  # Fallback, caso não seja encontrado

# Obter o nome da aventura a partir do arquivo actors.db
caminho_actors = os.path.join(diretorio, 'actors.db')
nome_aventura = extrair_nome_aventura(caminho_actors)

# Caminho do arquivo final onde todos os .db serão combinados
arquivo_final = f'../modules/{nome_aventura}.db'  # Ajuste do caminho para refletir a nova localização do script

# Abrir o arquivo final para escrita
with open(arquivo_final, 'w') as outfile:
    outfile.write('{')  # Início do conteúdo total

    # Ordenar os nomes dos arquivos .db alfabeticamente
    for nome_db in sorted(arquivos_db):
        # Caminho completo para o arquivo .db atual
        caminho_db = os.path.join(diretorio, nome_db)
        
        # Ler o conteúdo do arquivo .db atual
        with open(caminho_db, 'r') as infile:
            conteudo = infile.read().strip()  # Remover espaços e quebras de linha desnecessárias

            # Escrever o conteúdo no arquivo final, cercado por chaves
            outfile.write('{')
            outfile.write(conteudo)
            outfile.write('},\n')  # Fechar chaves e adicionar uma vírgula para separar os conteúdos

    outfile.write('}')  # Fechamento do conteúdo total

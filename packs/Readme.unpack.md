
### Fluxo de Trabalho

1. **Configurar o ambiente** (caso ainda não tenha feito):
   - Certifique-se de que sua configuração está correta com o comando:
     ```bash
     fvtt configure
     ```
   
2. **Definir o módulo em que está trabalhando**:
   - Você já fez isso corretamente com o comando:
     ```bash
     fvtt package workon "modulo-yan-dmdave" --type "Module"
     ```

3. **Descompactar um compêndio**:
   - Para descompactar um compêndio específico (caso seu módulo tenha um compêndio para editar), use:
     ```bash
     fvtt package unpack "nome-do-compendium" --type "Module"
     ```
     - Substitua `"nome-do-compendium"` pelo nome do compêndio que você deseja descompactar. 
     - Se você quiser que os arquivos sejam descompactados em um diretório específico, você pode usar a opção `--out`:
       ```bash
       fvtt package unpack "nome-do-compendium" --out "./output-directory"
       ```
   
4. **Fazer as edições necessárias**:
   - Agora que o compêndio foi descompactado, você pode editar os arquivos JSON ou YAML como desejar.

5. **Compactar novamente o compêndio**:
   - Depois de fazer suas edições, você pode compactar novamente os arquivos para o compêndio usando:
     ```bash
     fvtt package pack "nome-do-compendium" --type "Module"
     ```
     - Assim como no descompactar, você pode especificar o diretório de entrada usando `--in`:
       ```bash
       fvtt package pack "nome-do-compendium" --in "./input-directory"
       ```

### Exemplo Completo

Suponha que você queira descompactar um compêndio chamado "monsters" dentro do módulo "modulo-yan-dmdave", editar alguns arquivos e depois compactá-los novamente:

1. **Descompactar o compêndio**:
   ```bash
   fvtt package unpack "monsters" --out "./monsters-unpacked"
   ```

2. **Editar os arquivos no diretório `./monsters-unpacked`**:
   - Faça suas edições nos arquivos JSON ou YAML descompactados.

3. **Compactar novamente o compêndio**:
   ```bash
   fvtt package pack "monsters" --in "./monsters-unpacked"
   ```

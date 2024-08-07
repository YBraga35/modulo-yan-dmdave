$sourceDir = "../tokens"
$destinationDir = "../tokensDup"
$duplicateDir = Join-Path -Path $destinationDir -ChildPath "dup"

# Obtém todos os arquivos do diretório de origem
$files = Get-ChildItem -Path $sourceDir

# Cria um dicionário para armazenar o hash dos arquivos
$fileHashes = @{}

foreach ($file in $files) {
    $filePath = $file.FullName

    try {
        # Calcula o hash do arquivo
        $fileHash = (Get-FileHash -Path $filePath -Algorithm SHA256).Hash
        
        # Verifica se o hash é nulo ou vazio
        if ([string]::IsNullOrEmpty($fileHash)) {
            Write-Output "Hash nulo ou vazio para o arquivo: $filePath"
            continue
        }

        # Verifica se o hash já está no dicionário
        if ($fileHashes.ContainsKey($fileHash)) {
            # Se o hash já está no dicionário, move o arquivo para a pasta de duplicados
            $duplicatePath = Join-Path -Path $duplicateDir -ChildPath $file.Name
            
            # Verifica se o diretório de duplicados existe, e cria se não existir
            if (-not (Test-Path -Path $duplicateDir)) {
                Write-Output "Criando diretório de duplicados: $duplicateDir"
                New-Item -Path $duplicateDir -ItemType Directory
            }

            Write-Output "Movendo para duplicados: $filePath"
            Move-Item -Path $filePath -Destination $duplicatePath -Force
        } else {
            # Caso contrário, adiciona o hash ao dicionário e move o arquivo para o diretório de destino
            $fileHashes[$fileHash] = $filePath
            $destinationPath = Join-Path -Path $destinationDir -ChildPath $file.Name

            # Verifica se o diretório de destino existe, e cria se não existir
            if (-not (Test-Path -Path $destinationDir)) {
                Write-Output "Criando diretório de destino: $destinationDir"
                New-Item -Path $destinationDir -ItemType Directory
            }

            Write-Output "Movendo: $filePath para $destinationPath"
            Move-Item -Path $filePath -Destination $destinationPath -Force
        }
    } catch {
        Write-Output "Erro ao processar o arquivo: $filePath - $_"
    }
}

Pause

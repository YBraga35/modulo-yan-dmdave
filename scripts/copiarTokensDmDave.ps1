# Defina os diretórios de origem e destino
$sourceDir = "../.."
$destDir = "../tokens"

# Crie o diretório de destino se não existir
if (-not (Test-Path -Path $destDir)) {
    New-Item -Path $destDir -ItemType Directory
}

# Encontre todas as pastas que começam com "dmdave-" dentro do diretório de módulos
$folders = Get-ChildItem -Path $sourceDir -Directory | Where-Object { $_.Name -like "dmdave-*" }

foreach ($folder in $folders) {
    $tokenDir = Join-Path -Path $folder.FullName -ChildPath "tokens"
    
    # Verifique se a subpasta "tokens" existe
    if (Test-Path -Path $tokenDir) {
        $files = Get-ChildItem -Path $tokenDir -File

        foreach ($file in $files) {
            $destFile = Join-Path -Path $destDir -ChildPath $file.Name
            
            # Se o arquivo já existe no diretório de destino, renomeie o novo arquivo
            if (Test-Path -Path $destFile) {
                $baseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                $extension = [System.IO.Path]::GetExtension($file.Name)
                $counter = 1
                
                do {
                    $newFileName = "${baseName}${counter}${extension}"
                    $destFile = Join-Path -Path $destDir -ChildPath $newFileName
                    $counter++
                } while (Test-Path -Path $destFile)
            }
            
            # Copie o arquivo para o diretório de destino
            Copy-Item -Path $file.FullName -Destination $destFile
        }
    }
}

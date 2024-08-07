# Define o diretório que você deseja verificar
$sourceDir = "../tokens"

# Define o diretório onde o arquivo perm.txt será salvo
$outputDir = ".."
$permFile = Join-Path -Path $outputDir -ChildPath "perm.txt"

# Verifica se o diretório de origem existe
if (-not (Test-Path $sourceDir)) {
    Write-Host "O diretório de origem especificado não foi encontrado."
    exit
}

# Verifica se o diretório de saída existe
if (-not (Test-Path $outputDir)) {
    Write-Host "O diretório de saída especificado não foi encontrado."
    exit
}

# Remove o arquivo perm.txt se ele já existir e não estiver em uso
if (Test-Path $permFile) {
    try {
        Remove-Item $permFile -ErrorAction Stop
    } catch {
        Write-Host "Não foi possível remover o arquivo $permFile. Ele pode estar em uso."
        exit
    }
}

# Lista todos os arquivos e extrai as extensões
$files = Get-ChildItem -Path $sourceDir -File
$extensions = @()

foreach ($file in $files) {
    $ext = $file.Extension
    if ([string]::IsNullOrEmpty($ext)) {
        $ext = "NENHUMA"
    } else {
        $ext = $ext.TrimStart('.')
    }
    $extensions += $ext
}

# Salva as extensões em perm.txt
try {
    $extensions | Out-File -FilePath $permFile -ErrorAction Stop
} catch {
    Write-Host "Não foi possível criar o arquivo $permFile. Verifique se o diretório existe e tem permissões apropriadas."
    exit
}

# Pausa para visualizar o conteúdo de perm.txt
Write-Host "O arquivo perm.txt foi criado. Pressione qualquer tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Contagem de ocorrências de cada extensão
$count = @{}
foreach ($ext in $extensions) {
    if ($count.ContainsKey($ext)) {
        $count[$ext] += 1
    } else {
        $count[$ext] = 1
    }
}

# Exibe a contagem de arquivos por extensão
Write-Host "Contagem final de arquivos por extensão:"
foreach ($ext in $count.Keys) {
    Write-Host "Total $($ext): $($count[$ext])"
}

# Conta arquivos sem extensão
$noExtCount = ($extensions | Where-Object { $_ -eq "NENHUMA" }).Count
Write-Host "Total NENHUMA: $noExtCount"

# Exclui arquivos sem extensão
if ($noExtCount -gt 0) {
    Write-Host "Excluindo arquivos sem extensão..."
    foreach ($file in $files) {
        if ([string]::IsNullOrEmpty($file.Extension)) {
            try {
                Remove-Item $file.FullName -ErrorAction Stop
                Write-Host "Arquivo excluído: $($file.FullName)"
            } catch {
                Write-Host "Não foi possível excluir o arquivo $($file.FullName)."
            }
        }
    }
}

# Pausa final para visualizar o resultado
Write-Host "Pressione qualquer tecla para sair..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

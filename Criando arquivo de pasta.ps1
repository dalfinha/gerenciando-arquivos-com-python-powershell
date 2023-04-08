cls
$Pasta = Read-Host "Nome da pasta a ser analisada"

try {
    if (Test-Path -Path $Pasta) {
    $Itens = Get-ChildItem -Path $Pasta -Recurse 

    foreach ($iten in $Itens){
        $Arquivo =  $iten.Name 
        $Tamanho = $iten.Length
        $TempoSemAbrir = ((Get-Date) - $iten.LastWriteTime).Days
        $Arquivo+";"+$Tamanho+";"+$TempoSemAbrir |  Out-File -Append "C:\Arquivo.csv"
    }

    $linhas = Get-Content -Path "C:\Arquivo.csv"
    $delimitador = ";"
    $outputFile =  "C:\Arquivo_Novo.csv"

    $linhasQuebradas = foreach ($linha in $linhas) {
        $colunas = $linha.Split($delimitador)
        [pscustomobject]@{
           "Arquivo" = $colunas[0]
           "Tamanho (Bytes)" =  $colunas[1]
           "Tempo s/ uso" = $colunas[2]
        }
    }

    Write-Host "Informações sobre a pasta $Pasta foram coletadas com sucesso" -ForegroundColor Green
    $linhasQuebradas | Export-Csv -Path $outputFile -Delimiter ";" -NoTypeInformation
    Remove-Item -Path "C:\Arquivo.csv" -Force

    Write-Host "Iniciando análise de dados..." -ForegroundColor Green
    & C:/WindowsApps/python3.9.exe "\Analise e Criacao do Grafico.py"
    }

    else {
    Write-Host "Ops! A pasta $Pasta não existe ou não pode ser acessada pelo seu usuário" -ForegroundColor Yellow
    Write-Host "Verifique se as permissões estão corretas e tente novamente!" -ForegroundColor Yellow
    }
}

catch {
    Write-Host "Ops! A pasta $Pasta não existe ou não pode ser acessada pelo seu usuário" -ForegroundColor Yellow
    Write-Host "Verifique se as permissões estão corretas e tente novamente!" -ForegroundColor Yellow
}
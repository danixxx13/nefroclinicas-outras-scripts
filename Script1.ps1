# Defina o diretório onde as imagens estão armazenadas
$imagemPath = "C:\Repositorio\nefroclinicas-outras-imagens-main\WALLPAPER.jpg"

# Pegue todas as imagens da pasta (considerando .jpg e .png)
$imagens = Get-ChildItem -Path $imagemPath -Include *.jpg, *.png

# Verifica se existem imagens na pasta
if ($imagens.Count -eq 0) {
    Write-Host "Nenhuma imagem encontrada na pasta C:\Repositorio\nefroclinicas-outras-imagens-main\"
    exit
}

# Seleciona uma imagem aleatória
$imagemAleatoria = $imagens | Get-Random

# Define o caminho completo da imagem
$caminhoImagem = $imagemAleatoria.FullName

# Utiliza o COM object para alterar o papel de parede
$code = @"
using System;
using System.Runtime.InteropServices;
namespace Wallpaper {
    public static class Setter {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
}
"@

# Compilar o código C# no script
Add-Type -TypeDefinition $code -Language CSharp

# Chamada para a função SystemParametersInfo
[Wallpaper.Setter]::SystemParametersInfo(0x0014, 0, $caminhoImagem, 0x0001)

Write-Host "Papel de parede alterado para: $caminhoImagem"
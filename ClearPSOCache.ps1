$paths = @(
    (Join-Path $env:LOCALAPPDATA 'AMD\DxCache')
    (Join-Path $env:LOCALAPPDATA 'AMD\DxcCache')
    (Join-Path $env:LOCALAPPDATA 'AMD\OglCache')
    (Join-Path $env:LOCALAPPDATA 'AMD\VkCache')
    (Join-Path $env:LOCALAPPDATA 'NVIDIA\DXCache')
    (Join-Path $env:LOCALAPPDATA 'NVIDIA\GLCache')
    (Join-Path $env:USERPROFILE 'AppData\LocalLow\NVIDIA\PerDriverVersion\DXCache')
    (Join-Path $env:LOCALAPPDATA 'Intel\ShaderCache')
    (Join-Path $env:LOCALAPPDATA 'Intel\DXCache')
)

foreach ($path in $paths) {
    if (Test-Path -LiteralPath $path) {
        Get-ChildItem -LiteralPath $path -File -Recurse -Force -ErrorAction SilentlyContinue |
            ForEach-Object {
                $filePath = $_.FullName
                Write-Host -NoNewline "Removing $filePath "
                try {
                    Remove-Item -LiteralPath $filePath -Force -ErrorAction Stop
                    Write-Host "[OK]"
                } catch {
                    Write-Host "[FAIL]"
                }
            }
    }
}
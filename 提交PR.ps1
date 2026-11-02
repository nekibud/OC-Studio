param(
  [string]$Fork = 'https://github.com/nekibud/OC-Studio.git',
  [string]$Upstream = 'https://github.com/Pokanshuu/OC-Studio.git',
  [string]$Branch = 'feat/oc-studio-0.18.1-win10'
)
$ErrorActionPreference = 'Stop'
$work = Join-Path $env:TEMP ('oc-studio-pr-' + [guid]::NewGuid().ToString('N'))
Write-Host "Cloning fork to $work"
git clone $Fork $work
Set-Location $work
git remote add upstream $Upstream 2>$null
git fetch upstream
git checkout -b $Branch upstream/main
git am (Join-Path $PSScriptRoot 'changes.patch')
git push -u origin $Branch
Write-Host ''
Write-Host 'PR 创建地址：'
Write-Host 'https://github.com/Pokanshuu/OC-Studio/compare/main...nekibud:feat/oc-studio-0.18.1-win10?expand=1'

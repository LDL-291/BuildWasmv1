# Deploy Wasm WebGL build to GCP VM
# Run from: D:\GameRepository\PortfolioBuilds\BuildWasm\
# Usage: .\deploy.ps1

$VM_USER   = "spiralkrab"
$VM_HOST   = "34.131.55.80"
$SSH_KEY   = "C:\Users\Argho\deploy_key"
$REMOTE    = "/var/www/arghorithm/games/wasm"
$LOCAL     = $PSScriptRoot

Write-Host "Deploying Wasm → $VM_USER@${VM_HOST}:$REMOTE" -ForegroundColor Cyan

# Ensure remote dir exists
ssh -i $SSH_KEY -o StrictHostKeyChecking=no "${VM_USER}@${VM_HOST}" `
    "sudo mkdir -p $REMOTE && sudo chown -R ${VM_USER}:${VM_USER} $REMOTE"

# Upload all build files
scp -i $SSH_KEY -r "$LOCAL\*" "${VM_USER}@${VM_HOST}:${REMOTE}/"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Done. Live at: https://arghorithm.com/games/wasm/" -ForegroundColor Green
} else {
    Write-Host "Deploy failed." -ForegroundColor Red
    exit 1
}

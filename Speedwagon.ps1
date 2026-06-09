chcp 65001 | Out-Null
Clear-Host

Write-Host "Avvio dell'ambiente ARM-GDK..." -ForegroundColor Cyan

# 1. Avvia il controllo della porta e l'apertura del browser in BACKGROUND
$browserJob = Start-Job -ScriptBlock {
    while ($true) {
        try {
            $c = New-Object System.Net.Sockets.TcpClient
            $c.Connect('127.0.0.1', 5000)
            $c.Close()
            break
        } catch {
            Start-Sleep 1
        }
    }
    # Apre il browser su Windows appena la porta è pronta
    Start-Process "http://localhost:5000"
}

# 2. Lancia Docker Compose in PRIMO PIANO (Foreground, SENZA -d)
# Questo unisce i log di QEMU e Orchestrator nello stesso terminale.
# Essendo in primo piano, quando premerai CTRL+C il comando andrà direttamente a Docker.
try {
    docker compose up --build
} finally {
    # Pulizia di sicurezza del job del browser al termine dello script
    Stop-Job $browserJob -ErrorAction SilentlyContinue
    Remove-Job $browserJob -ErrorAction SilentlyContinue
}
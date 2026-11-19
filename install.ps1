# Installateur client - From The Fog S3 (Ninjaxx) 1.6 - Forge 1.19.2-43.5.1
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$repo = 'https://github.com/nini17800/from-the-fog-s3-modpack/raw/main'
$mc   = Join-Path $env:APPDATA '.minecraft'
$mods = Join-Path $mc 'mods'
$shad = Join-Path $mc 'shaderpacks'
$ua   = @{ 'User-Agent' = 'Mozilla/5.0' }

$files = @(
    @('940557','7608033','TheOneWhoWatches-V1.4.4-1.19.2.jar'),
    @('60089','3871353','MouseTweaks-forge-mc1.19-2.23.jar'),
    @('496520','5093445','Horror_elements_mod_1.5.6_1.19.2.jar'),
    @('923133','5775472','the_midnight_lurker_3.3.5.jar'),
    @('880630','6230931','fallingtrees-forge-mc1.19.2-0.13.2-SNAPSHOT.jar'),
    @('852533','4572858','From-The-Fog-1.19-v1.9.1-Forge-Fabric.jar'),
    @('457570','4462837','configured-2.1.1-1.19.2.jar'),
    @('871755','5336107','exposure-1.19.2-1.6.0-forge.jar'),
    @('1083666','5820413','Shut_Your_Eyes - 1.19.2 - V 2.0.5.jar'),
    @('1013669','5341287','Siren_Head_v1.2.7-1.19.2-Requires_Geckolib.jar'),
    @('467028','8234905','plasmovoice-forge-1.19.2-2.1.10.jar'),
    @('1300459','7735534','wabbanode-companion-forge-1.19.2-1.0.1.jar'),
    @('970277','7122500','FrankMimicker.jar'),
    @('618298','5870031','sophisticatedcore-1.19.2-0.6.4.730.jar'),
    @('257814','5491926','CreativeCore_FORGE_v2.11.28_mc1.19.2.jar'),
    @('388172','4407241','geckolib-forge-1.19-3.1.40.jar'),
    @('326652','5170313','cupboard-1.19.2-2.6.jar'),
    @('419699','5137942','architectury-6.6.92-forge.jar'),
    @('695021','4813397','endofherobrine-1.19.2-1.0.8.2.jar'),
    @('996585','5233958','assimilatorV1.jar'),
    @('983944','5885818','steve_dweller-1.19.2-1.7.0.jar'),
    @('610844','7251787','Bliss_v2.1.2_(Chocapic13_Shaders_edit).zip'),
    @('238222','5106178','jei-1.19.2-forge-11.6.0.1019.jar'),
    @('1074601','5621245','twistedsteve.jar'),
    @('574856','4763255','rubidium-mc1.19.2-0.6.2c.jar'),
    @('581495','6020961','oculus-mc1.19.2-1.6.9a.jar'),
    @('254284','5491930','AmbientSounds_FORGE_v5.3.9_mc1.19.2.jar'),
    @('1154099','8049661','CrashAssistant-forge-1.19-1.20.1-1.11.9.jar'),
    @('945562','5149895','Beware-1.19.2-2.3.4.jar'),
    @('1068023','5553983','The Newest Goatman.jar'),
    @('914926','4962513','TrueHerobrine_1.1+1.19.2.jar'),
    @('535489','5525251','sound-physics-remastered-forge-1.19.2-1.4.5.jar'),
    @('1001299','5862899','the_knocker-1.4.0-forge-1.19.2.jar'),
    @('459701','4171024','catalogue-1.7.0-1.19.2.jar'),
    @('546670','8113552','Essential_1-3-10-9_forge_1-19-2.jar'),
    @('1128697','6155580','000.jar -1.19.2-2.0.jar'),
    @('1058551','6680562','RakeArrival-forge-1.19.2-1.7.jar'),
    @('991997','5607159','MOKEYneedsGeckoLib.jar'),
    @('495693','4871016','farsight-1.19.2-3.6.jar'),
    @('971482','5363130','Apollyon v1.1.1 (Forge 1.19.2).jar'),
    @('1018705','5344007','SlenderTheHauntedForest-V1.0.2-1.19.2.jar'),
    @('422301','5194759','sophisticatedbackpacks-1.19.2-3.20.2.1035.jar'),
    @('276951','4977779','comforts-forge-6.0.7+1.19.2.jar'),
    @('975460','6245103','pandalib-forge-mc1.19.2-0.5.2-SNAPSHOT.jar'),
    @('1028108','6069349','tacz-1.19.2-1.1.4-hotfix-all.jar'),
    @('627557','8123287','ComplementaryReimagined_r5.8.1.zip'),
    @('250398','4050343','Controlling-forge-1.19.2-10.0+7.jar'),
    @('890565','5361337','The-Man-From-The-Fog-1.3-1.19.2.jar')
)

Write-Host ''
Write-Host '=== From The Fog S3 - installation des mods ===' -ForegroundColor Red
Write-Host "Dossier Minecraft : $mc"
New-Item -ItemType Directory -Force $mc, $shad | Out-Null

# Sauvegarde des anciens mods
if ((Test-Path $mods) -and (Get-ChildItem $mods -File -ErrorAction SilentlyContinue)) {
    $bak = Join-Path $mc ('mods_sauvegarde_' + (Get-Date -Format 'yyyyMMdd_HHmmss'))
    Move-Item $mods $bak
    Write-Host "Anciens mods deplaces dans : $bak" -ForegroundColor Yellow
}
New-Item -ItemType Directory -Force $mods | Out-Null

$i = 0; $fail = @()
foreach ($f in $files) {
    $i++
    $projId = $f[0]; $fileId = $f[1]; $name = $f[2]
    if ($name -like '*.zip') { $dest = Join-Path $shad $name } else { $dest = Join-Path $mods $name }
    Write-Host ("[{0,2}/{1}] {2}" -f $i, $files.Count, $name)
    $url = "https://www.curseforge.com/api/v1/mods/$projId/files/$fileId/download"
    $ok = $false
    for ($try = 1; ($try -le 3) -and (-not $ok); $try++) {
        try { Invoke-WebRequest -Uri $url -Headers $ua -OutFile $dest -UseBasicParsing; $ok = $true }
        catch { Start-Sleep -Seconds 2 }
    }
    if (-not $ok) { $fail += $name; Write-Host '      ECHEC' -ForegroundColor Red }
}

# Configs du modpack
Write-Host 'Installation des configs...'
$tmp = Join-Path $env:TEMP ('ftf_' + [guid]::NewGuid())
New-Item -ItemType Directory -Force $tmp | Out-Null
Invoke-WebRequest -Uri "$repo/From-The-Fog-S3-1.6.zip" -OutFile "$tmp\pack.zip" -UseBasicParsing
Expand-Archive "$tmp\pack.zip" -DestinationPath "$tmp\x" -Force
Copy-Item "$tmp\x\overrides\*" $mc -Recurse -Force
Remove-Item $tmp -Recurse -Force

# Forge
$forgeName = 'forge-1.19.2-43.5.1'
if (-not (Test-Path (Join-Path $mc 'versions\1.19.2-forge-43.5.1'))) {
    $jar = Join-Path ([Environment]::GetFolderPath('Desktop')) "$forgeName-installer.jar"
    Write-Host 'Telechargement de Forge 1.19.2-43.5.1...'
    Invoke-WebRequest -Uri "https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.5.1/$forgeName-installer.jar" -OutFile $jar -UseBasicParsing
    $java = $null
    $cmd = Get-Command java -ErrorAction SilentlyContinue
    if ($cmd) { $java = $cmd.Source } else {
        $j = Get-ChildItem "${env:ProgramFiles(x86)}\Minecraft Launcher\runtime", "$env:LOCALAPPDATA\Packages\Microsoft.4297127D64EC6_8wekyb3d8bbwe\LocalCache\Local\runtime" -Recurse -Filter javaw.exe -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($j) { $java = $j.FullName }
    }
    if ($java) {
        Write-Host '>>> Dans la fenetre Forge : laisse "Install client" coche et clique OK.' -ForegroundColor Cyan
        Start-Process -FilePath $java -ArgumentList "-jar `"$jar`"" -Wait
        Remove-Item $jar -ErrorAction SilentlyContinue
    } else {
        Write-Host "Java introuvable : double-clique sur $jar (sur ton Bureau) pour installer Forge." -ForegroundColor Yellow
    }
} else { Write-Host 'Forge 1.19.2-43.5.1 deja installe.' }

Write-Host ''
if ($fail.Count) {
    Write-Host ("{0} fichier(s) n'ont pas pu etre telecharges :" -f $fail.Count) -ForegroundColor Red
    $fail | ForEach-Object { Write-Host "  - $_" }
    Write-Host 'Relance l''installateur, ou telecharge-les via le README.'
} else {
    Write-Host 'Tout est installe !' -ForegroundColor Green
}
Write-Host 'Lance le launcher Minecraft, choisis le profil "forge" (1.19.2-forge-43.5.1),'
Write-Host 'mets au moins 6 Go de RAM (Installations > Modifier > Plus d''options > -Xmx6G) et rejoins le serveur.'

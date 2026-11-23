@echo off
chcp 65001 >nul
title Manuel Donanım Kimliği Değiştirici (Tüm Bileşenler)

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Bu scripti lutfen YONETICI OLARAK calistirin.
    echo.
    pause
    exit /b
)

echo ========================================================
echo    MANUEL DONANIM KIMLIGI DEGISTIRME VE AYARLAMA
echo ========================================================
echo.

cd /d "%~dp0"

echo [1/3] TPM 2.0 Endorsement Key ve NV Seed sifirlaniyor...
if exist "tpm-spoof.exe" (
    echo | tpm-spoof.exe
    echo [+] TPM 2.0 anahtarlari basariyla guncellendi.
) else (
    echo [!] tpm-spoof.exe bulunamadi!
)

echo.
echo [2/3] AMI SMBIOS Anakart / BIOS / UUID bilgileri guncelleniyor...
if exist "AMIDEWIN64.exe" (
    echo [*] UUID yenileniyor...
    AMIDEWIN64.exe /SU AUTO >nul 2>&1
    echo [*] Baseboard seri numarasi yenileniyor...
    AMIDEWIN64.exe /BS AUTO >nul 2>&1
    echo [*] Sistem seri numarasi yenileniyor...
    AMIDEWIN64.exe /SS AUTO >nul 2>&1
    echo [*] Kasa seri numarasi yenileniyor...
    AMIDEWIN64.exe /CS AUTO >nul 2>&1
    echo [+] Anakart SMBIOS seri numaralari guncellendi.
) else (
    echo [!] AMIDEWIN64.exe bulunamadi!
)

echo.
echo [3/3] Disk / Depolama Sürücüsü Bilgisi:
if exist "disk.sys" (
    echo [+] disk.sys hazir konumda.
    echo [*] Disk surucusu, spoofer acildiginda veya sc ile yuklendiginde
    echo     depolama seri numaralarini sanallastirir.
)

echo.
echo ========================================================
echo [+] TUM ISLEMLER TAMAMLANDI!
echo [*] Degisikliklerin devreye girmesi icin bilgisayari
echo     yeniden baslatmaniz onerilir.
echo ========================================================
echo.
pause

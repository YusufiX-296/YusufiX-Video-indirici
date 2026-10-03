@echo off
chcp 65001 >nul
title YusufiX YouTube İndirici v3.3

:: Renk ayarı kontrolü (Eğer daha önce renk seçilmediyse varsayılan açık mavi 0B yapar)
if not exist "%temp%\yusufix_color.ini" (
    echo 0B > "%temp%\yusufix_color.ini"
)
set /p mev_renk=<"%temp%\yusufix_color.ini"
color %mev_renk%

:: yt-dlp sistemde yüklü mü kontrol et
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo ========================================================
    echo                    YT-DLP KONTROLÜ
    echo ========================================================
    echo.
    echo [+] Bilgisayarınızda 'yt-dlp' bulunamadı!
    echo [+] Otomatik olarak yükleniyor, lütfen bekleyin...
    echo.
    winget install yt-dlp.yt-dlp --accept-source-agreements --accept-package-agreements
    echo.
    echo [+] Yükleme tamamlandı! Program başlatılıyor...
    timeout /t 3 >nul
)

:: Otomatik yt-dlp güncellemesi
echo [Bilgi] Yt-dlp guncelleniyor...
yt-dlp -U >nul 2>&1

:menu
cls
echo ========================================================
echo                 YUSUFIX YOUTUBE İNDİRİCİ
echo ========================================================
echo.
echo   [1] Video İndir (En Yüksek Kalite - MP4/MKV)
echo   [2] Sadece Ses İndir (MP3 Dönüştürücü)
echo   [3] Bölünmüş Video/Ses Seçeneği (Kısım Keserek İndir)
echo   [4] Küçük Resim (Thumbnail) İndir
echo   [5] Desteklenenler (Desteklenen Siteleri Listele)
echo   [6] Tema / Renk Ayarları
echo   [7] Çıkış
echo.
echo ========================================================
set "secim="
set /p "secim= Seçiminiz (1-7): "

if "%secim%"=="1" goto video
if "%secim%"=="2" goto ses
if "%secim%"=="3" goto bolunmus
if "%secim%"=="4" goto thumbnail
if "%secim%"=="5" goto desteklenenler
if "%secim%"=="6" goto ayarlar
if "%secim%"=="7" exit
goto menu

:video
cls
echo ========================================================
echo                     VİDEO İNDİRME HAZIRLIĞI
echo ========================================================
echo.
echo [+] İndirme motoru hazırlanıyor...
echo.
echo --------------------------------------------------
echo [████████████████████] 100%%
echo --------------------------------------------------
echo.
set /p link=" Linki yapistir ve Enter'a bas: "
echo.
echo [+] İndirme başlatıldı, lütfen bekleyin...
echo.
yt-dlp --newline -f "bv*+ba/b" "%link%"
echo.
echo ========================================================
echo [+] İşlem tamamlandı! Dosya klasörde seni bekliyor.
echo ========================================================
pause >nul
goto menu

:ses
cls
echo ========================================================
echo                      SES İNDİRME HAZIRLIĞI
echo ========================================================
echo.
echo [+] Ses dönüştürücü hazırlanıyor...
echo.
echo --------------------------------------------------
echo [████████████████████] 100%%
echo --------------------------------------------------
echo.
set /p link=" Linki yapistir ve Enter'a bas: "
echo.
echo [+] Ses indiriliyor ve MP3 formatına dönüştürülüyor...
echo.
yt-dlp --newline -x --audio-format mp3 "%link%"
echo.
echo ========================================================
echo [+] İşlem tamamlandı! MP3 hazır.
echo ========================================================
pause >nul
goto menu

:bolunmus
cls
echo ========================================================
echo                 BÖLÜNMÜŞ İNDİRME (KESEREK AL)
echo ========================================================
echo.
echo   [1] Video Olarak Kes ve İndir (En Yüksek Kalite)
echo   [2] Ses Olarak Kes ve İndir (MP3)
echo   [3] Ana Menüye Dön
echo.
set "bsecim="
set /p "bsecim= Seçiminiz (1-3): "

if "%bsecim%"=="3" goto menu
if "%bsecim%"=="" goto bolunmus

cls
echo ========================================================
set /p link=" YouTube Linkini Yapıştır ve Enter'a Bas: "
echo.
set /p basla=" Başlangıç Zamanı (Örn: 00:01:20 veya 45): "
set /p bitir=" Bitiş Zamanı (Örn: 00:02:10 veya 90): "
echo.
echo [+] Kesme ve indirme işlemi başlatıldı, lütfen bekleyin...
echo.

if "%bsecim%"=="1" (
    yt-dlp --newline -f "bv*+ba/b" --download-sections *%basla%-%bitir% "%link%"
) else if "%bsecim%"=="2" (
    yt-dlp --newline -x --audio-format mp3 --download-sections *%basla%-%bitir% "%link%"
)

echo.
echo ========================================================
echo [+] İşlem tamamlandı! Kesilen parça klasörde hazır.
echo ========================================================
pause >nul
goto menu

:thumbnail
cls
echo ========================================================
echo                  KÜÇÜK RESİM (THUMBNAIL) İNDİR
echo ========================================================
echo.
echo [+] Thumbnail modülü hazırlanıyor...
echo.
echo --------------------------------------------------
echo [████████████████████] 100%%
echo --------------------------------------------------
echo.
set /p link=" Linki yapistir ve Enter'a bas: "
echo.
echo [+] Kapak fotoğrafı indiriliyor...
echo.
yt-dlp --skip-download --write-thumbnail --convert-thumbnails jpg "%link%"
echo.
echo ========================================================
echo [+] İşlem tamamlandı! Kapak fotoğrafı klasörde.
echo ========================================================
pause >nul
goto menu

:desteklenenler
cls
echo ========================================================
echo                    DESTEKLENEN SITELER
echo ========================================================
echo.
echo [+] Desteklenen siteler listesi ekrana yazdırılıyor...
echo.
yt-dlp --list-extractors
echo.
echo ========================================================
echo [+] İşlem tamamlandı! Yukarıdaki siteleri inceleyebilirsin.
echo ========================================================
pause >nul
goto menu

:ayarlar
cls
echo ========================================================
echo                        RENK AYARLARI
echo ========================================================
echo.
echo   [1] Yeşil Tema (Hacker)
echo   [2] Açık Mavi Tema (Varsayılan)
echo   [3] Kırmızı Tema
echo   [4] Sarı Tema
echo   [5] Beyaz Tema
echo   [6] Ana Menüye Dön
echo.
echo ========================================================
set "ayscim="
set /p "ayscim= Renk seçiminizi yapın (1-6): "

if "%ayscim%"=="1" (
    echo 0A > "%temp%\yusufix_color.ini"
    goto yenidenbaslat
)
if "%ayscim%"=="2" (
    echo 0B > "%temp%\yusufix_color.ini"
    goto yenidenbaslat
)
if "%ayscim%"=="3" (
    echo 0C > "%temp%\yusufix_color.ini"
    goto yenidenbaslat
)
if "%ayscim%"=="4" (
    echo 0E > "%temp%\yusufix_color.ini"
    goto yenidenbaslat
)
if "%ayscim%"=="5" (
    echo 07 > "%temp%\yusufix_color.ini"
    goto yenidenbaslat
)
if "%ayscim%"=="6" goto menu
goto ayarlar

:yenidenbaslat
cls
echo Tema uygulandı, araç güncelleniyor...
timeout /t 1 >nul
start "" "%~f0"
exit


echo ==========================================
echo Flutter Feature Generator
echo ==========================================
echo.

set /p FEATURE=Enter feature name:

if "%FEATURE%"=="" (
    echo Feature name cannot be empty.
    pause
    exit /b
)

echo.
echo Creating feature: %FEATURE%
echo.

mkdir "lib\features\%FEATURE%\data\datasources"
mkdir "lib\features\%FEATURE%\data\models"
mkdir "lib\features\%FEATURE%\data\repositories"

mkdir "lib\features\%FEATURE%\domain\entities"
mkdir "lib\features\%FEATURE%\domain\repositories"
mkdir "lib\features\%FEATURE%\domain\usecases"

mkdir "lib\features\%FEATURE%\presentation\providers"
mkdir "lib\features\%FEATURE%\presentation\pages"
mkdir "lib\features\%FEATURE%\presentation\widgets"

echo.
echo ==========================================
echo Feature "%FEATURE%" created successfully!
echo ==========================================
echo.

pause

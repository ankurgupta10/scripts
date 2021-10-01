rem : delete old re-zip
del /f "c:\Users\Ankur.8.Gupta\Desktop\deploy\api-NIITOffshore.zip"

rem delete deploy folder
rd /s /q "deploy\api-NIITOffshore"

rem : extract the zip download to deploy folder
"c:\Program Files\7-Zip\7z.exe" x "c:\Users\Ankur.8.Gupta\Downloads\api-NIITOffshore.zip" -o"c:\Users\Ankur.8.Gupta\Desktop\deploy\"

rem : delete the zip download
del /f "c:\Users\Ankur.8.Gupta\Downloads\api-NIITOffshoreOLD.zip"
rename c:\Users\Ankur.8.Gupta\Downloads\api-NIITOffshore.zip api-NIITOffshoreOLD.zip

rem : re-zip the deploy folder
rem "c:\Program Files\7-Zip\7z.exe" a "c:\Users\Ankur.8.Gupta\Desktop\deploy\api-NIITOffshore.zip" "c:\Users\Ankur.8.Gupta\Desktop\deploy\api-NIITOffshore"
rem powershell Compress-Archive -Path "c:\Users\Ankur.8.Gupta\Desktop\deploy\api-NIITOffshore" -DestinationPath "c:\Users\Ankur.8.Gupta\Desktop\deploy\api-NIITOffshore.zip"
CScript zip.vbs "c:\Users\Ankur.8.Gupta\Desktop\deploy\api-NIITOffshore" "c:\Users\Ankur.8.Gupta\Desktop\deploy\api-NIITOffshore.zip"

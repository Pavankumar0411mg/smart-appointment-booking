@echo off
echo Building Appointment System...

:: Create build directory
if not exist "build" mkdir build
if not exist "build\WEB-INF" mkdir build\WEB-INF
if not exist "build\WEB-INF\classes" mkdir build\WEB-INF\classes
if not exist "build\WEB-INF\lib" mkdir build\WEB-INF\lib

:: Copy web resources
xcopy "src\main\webapp\*" "build\" /E /Y

:: Compile Java files (requires servlet-api.jar and mysql-connector.jar in classpath)
javac -cp "lib\*" -d "build\WEB-INF\classes" src\main\java\com\appointment\util\*.java src\main\java\com\appointment\servlet\*.java

:: Create WAR file
cd build
jar -cvf ..\appointment-system.war *
cd ..

echo Build complete! Deploy appointment-system.war to Tomcat webapps folder.
pause
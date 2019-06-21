#!/bin/bash

# input params
branchName=$1
buildType=$2
storePass=$3
keyAlias=$4
keyPass=$5

cat << "EOF"

             _   _   _____    _____     ____    _____   _____
     /\     | \ | | |  __ \  |  __ \   / __ \  |_   _| |  __ \
    /  \    |  \| | | |  | | | |__) | | |  | |   | |   | |  | |
   / /\ \   | . ` | | |  | | |  _  /  | |  | |   | |   | |  | |
  / ____ \  | |\  | | |__| | | | \ \  | |__| |  _| |_  | |__| |
 /_/    \_\ |_| \_| |_____/  |_|  \_\  \____/  |_____| |_____/



EOF

# helper method
setProperty() {
	sed -i.bak -e "s/\($1 *= *\).*/\1$2/" ${propertiesFile}
}

# -----------------------------------------------------------------
# ------------------------------ BUILD ----------------------------
# -----------------------------------------------------------------
propertiesFile='gradle.properties'
chmod +x ${propertiesFile}

# update key properties based on build type
if [ $buildType = 'debug' ]; then
    fastlane debug
#	(setProperty "KEYSTORE" "debug")
#	(setProperty "STORE_PASSWORD" "123456")
#	(setProperty "KEY_ALIAS" "debug")
#	(setProperty "KEY_PASSWORD" "123456")
elif [ $buildType = 'release' ]; then
#	(setProperty "KEYSTORE" "release")
#	(setProperty "STORE_PASSWORD" "$storePass")
#	(setProperty "KEY_ALIAS" "$keyAlias")
#	(setProperty "KEY_PASSWORD" "$keyPass")
	fastlane release KEYSTORE:keystore/release STORE_PASSWORD:${storePass} KEY_ALIAS:${keyAlias} KEY_PASSWORD:${keyPass}
fi
#
## clean project
#chmod +x gradlew
#./gradlew clean --stacktrace
## build
#if [ $buildType = 'debug' ]; then
#	./gradlew assembleDebug --stacktrace
#elif [ $buildType = 'release' ]; then
#	./gradlew assembleRelease --stacktrace
#fi
#
## -----------------------------------------------------------------
## -------------------------- POST BUILD ---------------------------
## -----------------------------------------------------------------
apkFileName="app-$buildType.apk"
rm -r artifacts/
mkdir artifacts

# copy apk to artifacts
if [ ! -e "app/build/outputs/apk/$buildType/$apkFileName" ]; then
    echo "ERROR: File not exists: (app/build/outputs/apk/$buildType/$apkFileName)"
    exit 1
fi
cp app/build/outputs/apk/$buildType/$apkFileName artifacts/

cat << "EOF"

   __   _           _         _
  / _| (_)         (_)       | |
 | |_   _   _ __    _   ___  | |__
 |  _| | | | '_ \  | | / __| | '_ \
 | |   | | | | | | | | \__ \ | | | |
 |_|   |_| |_| |_| |_| |___/ |_| |_|


EOF
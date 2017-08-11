#!/bin/sh

BUILD_PACKAGES="wget tar unzip"
RUNTIME_PACKAGE="lib32stdc++6 lib32z1"
apt-get --quiet update --yes
apt-get --quiet install --yes $BUILD_PACKAGES $RUNTIME_PACKAGE

wget -qO-  https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz | tar xz -C /opt

echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_TARGET_SDK}
echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools
echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS}
echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository
echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services
echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository

rm -rf android-sdk.tgz

mkdir "$ANDROID_HOME/licenses" || true
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"

FROM openjdk:8-jdk
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

ARG ANDROID_TARGET_SDK="29"
ARG ANDROID_BUILD_TOOLS="29.0.2"
ARG CMDLINE_TOOLS=https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip

RUN mkdir -p /opt/android/sdk
ENV ANDROID_HOME /opt/android/sdk

RUN apt-get --quiet update --yes && \
    apt-get --quiet install --yes lib32stdc++6 lib32z1 unzip wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/cmdline-tools.zip -t 5 "${CMDLINE_TOOLS}" && \
    unzip -q /tmp/cmdline-tools.zip -d ${ANDROID_HOME} && \
    rm /tmp/cmdline-tools.zip

ENV ANDROID_SDK_ROOT $ANDROID_HOME/
ENV ADB_INSTALL_TIMEOUT 120
ENV ANDROID_SDK_HOME ~/.android

ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

RUN mkdir ~/.android && echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg

RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses && yes | sdkmanager --sdk_root=${ANDROID_HOME} --update

RUN sdkmanager --sdk_root=${ANDROID_HOME} \
  "tools" \
  "platform-tools" \
  "emulator"

ENV GRADLE_VERSION 6.7
ENV GRADLE_HOME /opt/gradle
RUN wget --no-verbose -O /tmp/gradle.zip -t 5 "https://downloads.gradle-dn.com/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
    unzip -q /tmp/gradle.zip -d /tmp && \
    mv /tmp/gradle-${GRADLE_VERSION} ${GRADLE_HOME} && \
    rm /tmp/gradle.zip

ENV PATH=${GRADLE_HOME}/bin:${PATH}    
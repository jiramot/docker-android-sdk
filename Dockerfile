FROM openjdk:8-jdk-slim

ARG ANDROID_TARGET_SDK="25"
ARG ANDROID_BUILD_TOOLS="24.0.0"
ARG ANDROID_SDK_TOOLS="24.4.1"

ENV ANDROID_COMPILE_SDK ${ANDROID_COMPILE_SDK}
ENV ANDROID_BUILD_TOOLS ${ANDROID_BUILD_TOOLS}
ENV ANDROID_SDK_TOOLS ${ANDROID_SDK_TOOLS}

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/platform-tools/

RUN apt-get --quiet update --yes && \
    apt-get --quiet install --yes lib32stdc++6 lib32z1

# RUN wget -qO-  https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz | tar xz -C /opt && \
      # rm -rf android-sdk.tgz
ADD https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz /opt

RUN echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_TARGET_SDK}
RUN echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools
RUN echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS}
RUN echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository
RUN echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services
RUN echo y | /opt/android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository

RUN mkdir "$ANDROID_HOME/licenses" || true && \
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license" && \
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"

#export ANDROID_SDK_HOME=/Users/guaishou/Library/Android/sdk
#export ANDROID_NDK_HOME=/Users/guaishou/Library/Android/sdk/ndk/25.2.9519653

#Ubuntu
export ANDROID_SDK_HOME=/home/luoye/Android/Sdk/
export ANDROID_NDK_HOME=/home/luoye/Android/Sdk/ndk/25.2.9519653
./ffmpeg-android-maker.sh -abis=armeabi-v7a,arm64-v8a,x86,x86_64 --enable-libx264 --enable-libmp3lame

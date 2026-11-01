#export ANDROID_SDK_HOME=/Users/raoyun/Library/Android/sdk
#export ANDROID_NDK_HOME=/Users/raoyun/Library/Android/sdk/ndk/AndroidNDK13676358_r28c.app/Contents/NDK

#Ubuntu
export ANDROID_SDK_HOME=/media/raoyun/Data/Linux/Android/Sdk
export ANDROID_NDK_HOME=/media/raoyun/Data/Linux/Android/Sdk/ndk/r28c
./ffmpeg-android-maker.sh -abis=armeabi-v7a,arm64-v8a,x86,x86_64 --enable-libx264 --enable-libmp3lame

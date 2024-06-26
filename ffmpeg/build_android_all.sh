#!/usr/bin/env bash

chmod a+x build_android_*.sh

export COMMON_SET="--enable-static \
  --disable-symver \
  --disable-doc \
  --disable-htmlpages \
  --disable-manpages \
  --disable-podpages \
  --disable-txtpages \
  --disable-ffplay \
  --disable-ffmpeg \
  --disable-ffprobe \
  --disable-avdevice \
  --disable-bsfs \
  --disable-devices \
  --disable-protocols \
  --enable-protocol=file \
  --enable-protocol=concat \
  --disable-parsers \
  --disable-demuxers \
  --enable-demuxer=mov \
  --enable-demuxer=mp3 \
  --enable-demuxer=image2 \
  --enable-demuxer=gif \
  --enable-demuxer=wav \
  --disable-decoders \
  --enable-decoder=aac \
  --enable-decoder=png \
  --enable-decoder=h264 \
  --enable-decoder=mp3 \
  --enable-decoder=mjpeg \
  --enable-decoder=mpeg4 \
  --enable-decoder=gif \
  --enable-decoder=pcm_s16le \
  --enable-decoder=hevc \
  --disable-muxers \
  --enable-muxer=mov \
  --enable-muxer=mp4 \
  --enable-muxer=image2 \
  --enable-muxer=mp3 \
  --enable-muxer=ipod \
  --enable-muxer=gif \
  --disable-encoders \
  --enable-encoder=aac \
  --enable-encoder=libx264 \
  --enable-encoder=png \
  --enable-encoder=mjpeg \
  --enable-encoder=gif \
  --enable-swscale \
  --disable-filters \
  --enable-filter=crop \
  --enable-filter=scale \
  --enable-filter=afade \
  --enable-filter=atempo \
  --enable-filter=copy \
  --enable-filter=aformat \
  --enable-filter=overlay \
  --enable-filter=vflip \
  --enable-filter=hflip \
  --enable-filter=transpose \
  --enable-filter=volume \
  --enable-filter=rotate \
  --enable-filter=apad \
  --enable-filter=amerge \
  --enable-filter=aresample \
  --enable-filter=setpts \
  --enable-filter=fps \
  --enable-filter=palettegen \
  --enable-filter=paletteuse \
  --enable-filter=trim \
  --enable-filter=null \
  --enable-filter=overlay \
  --enable-filter=format \
  --enable-filter=atrim \
  --enable-filter=split \
  --enable-filter=amix \
  --enable-filter=anull \
  --enable-filter=adelay \
  --enable-gpl \
  --enable-zlib \
  --enable-libx264 \
  --enable-jni \
  --enable-mediacodec \
  --enable-decoder=h264_mediacodec \
  --enable-decoder=mpeg4_mediacodec \
  --enable-decoder=vp9_mediacodec \
  --enable-decoder=vp8_mediacodec \
  --enable-decoder=hevc_mediacodec \
  --enable-hwaccels \
  --enable-asm \
  --enable-version3 "

# Build arm v6 v7a
# ./build_android_armeabi.sh

# Build arm v7a
./build_android_armeabi_v7a.sh

# Build arm64 v8a
./build_android_arm64_v8a.sh

# Build x86
# ./build_android_x86.sh

# Build x86_64
# ./build_android_x86_64.sh

# Build mips
# ./build_android_mips.sh

# Build mips64   //may fail
# ./build_android_mips64.sh

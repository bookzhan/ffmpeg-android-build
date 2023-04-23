#!/usr/bin/env bash

case $ANDROID_ABI in
  x86)
    # Disabling assembler optimizations, because they have text relocations
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --disable-asm"
    ;;
  x86_64)
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --x86asmexe=${FAM_YASM}"
    ;;
esac

if [ "$FFMPEG_GPL_ENABLED" = true ] ; then
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --enable-gpl"
fi

# Preparing flags for enabling requested libraries
ADDITIONAL_COMPONENTS=
for LIBARY_NAME in ${FFMPEG_EXTERNAL_LIBRARIES[@]}
do
  ADDITIONAL_COMPONENTS+=" --enable-$LIBARY_NAME"
done

# Referencing dependencies without pkgconfig
DEP_CFLAGS="-I${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/include"
DEP_LD_FLAGS="-L${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/lib $FFMPEG_EXTRA_LD_FLAGS"

./configure \
  --prefix=${BUILD_DIR_FFMPEG}/${ANDROID_ABI} \
  --enable-cross-compile \
  --target-os=android \
  --arch=${TARGET_TRIPLE_MACHINE_ARCH} \
  --sysroot=${SYSROOT_PATH} \
  --cc=${FAM_CC} \
  --cxx=${FAM_CXX} \
  --ld=${FAM_LD} \
  --ar=${FAM_AR} \
  --as=${FAM_CC} \
  --nm=${FAM_NM} \
  --ranlib=${FAM_RANLIB} \
  --strip=${FAM_STRIP} \
  --extra-cflags="-O3 -fPIC -mcmodel=large $DEP_CFLAGS" \
  --extra-ldflags="$DEP_LD_FLAGS" \
  --disable-shared \
  --enable-static \
  --disable-vulkan \
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
  --disable-postproc \
  --enable-protocol=file \
  --enable-protocol=concat \
  --disable-parsers \
  --disable-demuxers \
  --enable-demuxer=mov \
  --enable-demuxer=mp3 \
  --enable-demuxer=image2 \
  --enable-demuxer=gif \
  --enable-demuxer=wav \
  --enable-demuxer=asf \
  --enable-demuxer=flv \
  --enable-demuxer=avi \
  --enable-demuxer=webm_dash_manifest \
  --enable-demuxer=matroska \
  --enable-demuxer=mpegts \
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
  --enable-decoder=msmpeg4v1 \
  --enable-decoder=msmpeg4v2 \
  --enable-decoder=msmpeg4v3 \
  --enable-decoder=wmav1 \
  --enable-decoder=wmav2 \
  --enable-decoder=flv \
  --enable-decoder=adpcm_swf \
  --enable-decoder=ac3 \
  --enable-decoder=vp8 \
  --enable-decoder=vorbis \
  --enable-decoder=mpeg2video \
  --enable-decoder=mp2 \
  --enable-decoder=indeo4 \
  --enable-decoder=amrnb \
  --disable-muxers \
  --enable-muxer=mov \
  --enable-muxer=mp4 \
  --enable-muxer=image2 \
  --enable-muxer=mp3 \
  --enable-muxer=ipod \
  --enable-muxer=gif \
  --disable-encoders \
  --enable-encoder=aac \
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
  --enable-zlib \
  --enable-jni \
  --enable-nonfree \
  --enable-mediacodec \
  --pkg-config=${PKG_CONFIG_EXECUTABLE} \
  ${EXTRA_BUILD_CONFIGURATION_FLAGS} \
  $ADDITIONAL_COMPONENTS || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

export STATIC_LIB_DIR=${BUILD_DIR_FFMPEG}/${ANDROID_ABI}/lib
echo STATIC_LIB_DIR=${STATIC_LIB_DIR}
echo INSTALL_DIR=${INSTALL_DIR}
echo FAM_CC=${FAM_CC}
echo SYSROOT_PATH=${SYSROOT_PATH}
${FAM_CC} --sysroot=${SYSROOT_PATH} \
  -shared -o ${STATIC_LIB_DIR}/libmerged.so \
  -Wl,--whole-archive \
  ${STATIC_LIB_DIR}/libavutil.a \
  ${STATIC_LIB_DIR}/libswscale.a \
  ${STATIC_LIB_DIR}/libswresample.a \
  ${STATIC_LIB_DIR}/libavcodec.a \
  ${STATIC_LIB_DIR}/libavformat.a \
  ${STATIC_LIB_DIR}/libavfilter.a \
  -Wl,--no-whole-archive -lm -lz #!/usr/bin/env bash

case $ANDROID_ABI in
  x86)
    # Disabling assembler optimizations, because they have text relocations
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --disable-asm"
    ;;
  x86_64)
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --x86asmexe=${FAM_YASM}"
    ;;
esac

if [ "$FFMPEG_GPL_ENABLED" = true ] ; then
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --enable-gpl"
fi

# Preparing flags for enabling requested libraries
ADDITIONAL_COMPONENTS=
for LIBARY_NAME in ${FFMPEG_EXTERNAL_LIBRARIES[@]}
do
  ADDITIONAL_COMPONENTS+=" --enable-$LIBARY_NAME"
done

# Referencing dependencies without pkgconfig
DEP_CFLAGS="-I${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/include"
DEP_LD_FLAGS="-L${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/lib $FFMPEG_EXTRA_LD_FLAGS"

./configure \
  --prefix=${BUILD_DIR_FFMPEG}/${ANDROID_ABI} \
  --enable-cross-compile \
  --target-os=android \
  --arch=${TARGET_TRIPLE_MACHINE_ARCH} \
  --sysroot=${SYSROOT_PATH} \
  --cc=${FAM_CC} \
  --cxx=${FAM_CXX} \
  --ld=${FAM_LD} \
  --ar=${FAM_AR} \
  --as=${FAM_CC} \
  --nm=${FAM_NM} \
  --ranlib=${FAM_RANLIB} \
  --strip=${FAM_STRIP} \
  --extra-cflags="-O3 -fPIC -Wl,-z,notext $DEP_CFLAGS" \
  --extra-ldflags="$DEP_LD_FLAGS" \
  --disable-shared \
  --enable-static \
  --disable-vulkan \
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
  --disable-postproc \
  --enable-protocol=file \
  --enable-protocol=concat \
  --disable-parsers \
  --disable-demuxers \
  --enable-demuxer=mov \
  --enable-demuxer=mp3 \
  --enable-demuxer=image2 \
  --enable-demuxer=gif \
  --enable-demuxer=wav \
  --enable-demuxer=asf \
  --enable-demuxer=flv \
  --enable-demuxer=avi \
  --enable-demuxer=webm_dash_manifest \
  --enable-demuxer=matroska \
  --enable-demuxer=mpegts \
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
  --enable-decoder=msmpeg4v1 \
  --enable-decoder=msmpeg4v2 \
  --enable-decoder=msmpeg4v3 \
  --enable-decoder=wmav1 \
  --enable-decoder=wmav2 \
  --enable-decoder=flv \
  --enable-decoder=adpcm_swf \
  --enable-decoder=ac3 \
  --enable-decoder=vp8 \
  --enable-decoder=vorbis \
  --enable-decoder=mpeg2video \
  --enable-decoder=mp2 \
  --enable-decoder=indeo4 \
  --enable-decoder=amrnb \
  --disable-muxers \
  --enable-muxer=mov \
  --enable-muxer=mp4 \
  --enable-muxer=image2 \
  --enable-muxer=mp3 \
  --enable-muxer=ipod \
  --enable-muxer=gif \
  --disable-encoders \
  --enable-encoder=aac \
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
  --enable-zlib \
  --enable-jni \
  --enable-nonfree \
  --enable-mediacodec \
  --pkg-config=${PKG_CONFIG_EXECUTABLE} \
  ${EXTRA_BUILD_CONFIGURATION_FLAGS} \
  $ADDITIONAL_COMPONENTS || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

export STATIC_LIB_DIR=${BUILD_DIR_FFMPEG}/${ANDROID_ABI}/lib
echo STATIC_LIB_DIR=${STATIC_LIB_DIR}
echo INSTALL_DIR=${INSTALL_DIR}
echo FAM_CC=${FAM_CC}
echo SYSROOT_PATH=${SYSROOT_PATH}
${FAM_CC} --sysroot=${SYSROOT_PATH} \
  -L${STATIC_LIB_DIR} \
  -shared -o ${STATIC_LIB_DIR}/libmerged.so \
  -Wl,--whole-archive \
  ${STATIC_LIB_DIR}/libavutil.a \
  ${STATIC_LIB_DIR}/libswscale.a \
  ${STATIC_LIB_DIR}/libswresample.a \
  ${STATIC_LIB_DIR}/libavcodec.a \
  ${STATIC_LIB_DIR}/libavformat.a \
  ${STATIC_LIB_DIR}/libavfilter.a \
  -Wl,--no-whole-archive -lm -lz

#!/usr/bin/env bash

set -e

# To cross compile to aarch64 use "arm" as a first argument
# Example:
#   ./compile.sh arm
ARCH_HOST="$1"
echo "Arch host = '$ARCH_HOST'"

rm -Rf secp256k1-tmp/
cp -r secp256k1/ secp256k1-tmp/

pushd secp256k1-tmp/

# Modify secp256k1 native code with addition of JNI support
# Files copied from removed JNI support in bitcoin-core/secp256k1 repo
# https://github.com/bitcoin-core/secp256k1/pull/682
cp ../jni/build-aux/m4/* build-aux/m4/
cp -r ../jni/java/ src/java/
cp ../jni/Makefile.am Makefile.am
cp ../jni/configure.ac configure.ac

# Compile secp256k1 native code
./autogen.sh

if [[ "$ARCH_HOST" ]]; then
  echo "Cross compiling for ARM CPU... $ARCH_HOST"
  # ./configure --enable-jni --enable-module-ecdh --host=aarch64-linux-gnu
  # ./configure --enable-jni --enable-module-ecdh --host=aarch64-linux-gnu --enable-experimental --with-asm=arm
  # ./configure --enable-jni --enable-module-ecdh --host=aarch64-linux-gnu --with-asm=no
  ./configure --enable-jni --enable-module-ecdh --host=$ARCH_HOST --with-asm=no
else
  ./configure --enable-jni --enable-module-ecdh
fi
# ./configure --enable-jni --enable-module-ecdh --enable-experimental --enable-module-schnorrsig
# ./configure --enable-jni --enable-module-ecdh
make CFLAGS="-std=c99"
make
if [[ ! "$ARCH_HOST" ]]; then
  make check
fi

#!/usr/bin/env bash
cd ./secp256k1 && ./autogen.sh && ./configure --enable-jni --enable-experimental --enable-module-ecdh

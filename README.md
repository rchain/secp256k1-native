[![Build Status](https://travis-ci.org/rchain/secp256k1-native.svg?branch=master)](https://travis-ci.org/rchain/secp256k1-native)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Secp256k1  Native Libraries
This repository creates standard builds of the secp256k1 native library. It packages the built libraries into operating system-specific JARs (with POMs). This allows secp256k1-java (or other interested Java projects) to depend on these JARs using the normal Maven dependency resolution process.

The following dependencies are required (plus Java and Maven):

* `autotools-dev`
* `autoconf`
* `build-essentials`
* GCC for building the Linux or OS X shared library
* [Mingw-w64](http://mingw-w64.org/) for building the Windows DLL (on Linux) (Arch Linux uses can `pacman -S mingw-w64-gcc`)
    
### Installation

This project is mainly intended to be built by Travis CI, as a Linux operating
system is required to build the Linux and Windows libraries, and an OS X
operating system is needed to build the OS X library. Nevertheless it is
possible to execute the Linux or OS X component of the build locally.

Once the platform dependencies are met:

```bash
git clone --recursive https://github.com/rchain/secp256k1-native.git
cd secp256k1-native
mvn clean install
```

An appropriate Maven profile will automatically be used for Linux or OS X.

### License
Secp256k1-native (and this repository for simplicity) is licensed under
[Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

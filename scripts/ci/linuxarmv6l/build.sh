#!/bin/bash
set -ev
OF_ROOT=$( cd "$(dirname "$0")/../../.." ; pwd -P )
PROJECTS=$OF_ROOT/libs/openFrameworksCompiled/project
# source $OF_ROOT/scripts/ci/ccache.sh

# Add compiler flag to reduce memory usage to enable builds to complete
# see https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56746#c7
# the "proper" way does not work currently:
export CXXFLAGS="${CXXFLAGS} -ftrack-macro-expansion=0"

echo "**** Building OF core ****"
cd $OF_ROOT
# this carries over to subsequent compilations of examples
sed -i "s/PLATFORM_OPTIMIZATION_CFLAGS_DEBUG = .*/PLATFORM_OPTIMIZATION_CFLAGS_DEBUG = -g0/" $PROJECTS/makefileCommon/config.linux.common.mk
cd $PROJECTS
export GCC_PREFIX=arm-linux-gnueabihf
export GST_VERSION=1.0
export RPI_ROOT=${OF_ROOT}/scripts/ci/$TARGET/raspbian
export TOOLCHAIN_ROOT=${OF_ROOT}/scripts/ci/$TARGET/rpi_toolchain
export PLATFORM_OS=Linux
export PLATFORM_ARCH=armv6l
export PKG_CONFIG_LIBDIR=${RPI_ROOT}/usr/lib/pkgconfig:${RPI_ROOT}/usr/lib/${GCC_PREFIX}/pkgconfig:${RPI_ROOT}/usr/share/pkgconfig
export CXX="${TOOLCHAIN_ROOT}/bin/${GCC_PREFIX}-g++"
export CC="${TOOLCHAIN_ROOT}/bin/${GCC_PREFIX}-gcc"
export AR=${TOOLCHAIN_ROOT}/bin/${GCC_PREFIX}-ar
export LD=${TOOLCHAIN_ROOT}/bin/${GCC_PREFIX}-ld
make Debug -j2

echo "**** Building emptyExample ****"
cd $OF_ROOT/scripts/templates/linuxarmv6l
make Debug -j2

echo "**** Building allAddonsExample ****"
cd $OF_ROOT
cp scripts/templates/linuxarmv6l/Makefile examples/templates/allAddonsExample/
cp scripts/templates/linuxarmv6l/config.make examples/templates/allAddonsExample/
cd examples/templates/allAddonsExample/
make Debug -j2

git checkout $PROJECTS/makefileCommon/config.linux.common.mk
git checkout $PROJECTS/linuxarmv6l/config.linuxarmv6l.default.mk

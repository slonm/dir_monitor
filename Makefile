CMAKE_MAKE=mkdir -p ../build/$@ \
	&& cd ../build/$@ \
	&& cmake ../../src -DBOOST_ROOT=/devroot/3rdparty/boost_1_64_0 -DBOOST_LIBRARYDIR=/devroot/3rdparty/build_3.1/$(LIB_3RDPARTY)/lib -DBUILD_TESTING=1 $(CMAKE_OPTS) \
	&& make VERBOSE=1

all: x86_64-linux x86_64-osx x86_64-windows x86_64-freebsd
	
x86_64-linux:CMAKE_OPTS=-DBOOST_TEST_STATIC_LINK=1
x86_64-linux:LIB_3RDPARTY=x86_64-linux-gnu
x86_64-linux:
	$(CMAKE_MAKE)
	
x86_64-osx:CMAKE_OPTS=-DBOOST_TEST_STATIC_LINK=1 -DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_CXX_COMPILER=/devroot/toolchain/osxcross/target/bin/x86_64-apple-darwin12-clang++ \
	-DCOREFOUNDATION_LIB=/devroot/toolchain/osxcross/target/SDK/MacOSX10.8.sdk/System/Library/Frameworks/CoreFoundation.framework \
	-DCORESERVICES_LIB=/devroot/toolchain/osxcross/target/SDK/MacOSX10.8.sdk/System/Library/Frameworks/CoreServices.framework \
	-DCMAKE_SYSTEM_NAME=Darwin
x86_64-osx:LIB_3RDPARTY=x86_64-apple-darwin12-libc++
x86_64-osx:
	$(CMAKE_MAKE)

x86_64-freebsd:CMAKE_OPTS=-DBOOST_TEST_STATIC_LINK=1 -DCMAKE_CXX_COMPILER=/devroot/toolchain/x86_64-freebsd11.0/bin/x86_64-pc-freebsd11.0-g++ \
	-DCMAKE_SYSTEM_NAME=FreeBSD
x86_64-freebsd:LIB_3RDPARTY=x86_64-freebsd11.0
x86_64-freebsd:
	$(CMAKE_MAKE)

x86_64-windows:CMAKE_OPTS=-DCMAKE_CXX_COMPILER=/devroot/toolchain/mingw-w64-x86_64-cpp11/bin/x86_64-w64-mingw32-g++ \
	-DCMAKE_SYSTEM_NAME=Windows
x86_64-windows:LIB_3RDPARTY=x86_64-windows-cpp11
x86_64-windows:
	$(CMAKE_MAKE)
	
clean:
	rm -rf ../build/*

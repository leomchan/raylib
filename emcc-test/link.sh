#!/bin/bash
set -e

script_dir=$(dirname "$BASH_SOURCE")
cc="${EMSDK}/upstream/emscripten/emcc"

pushd "${script_dir}/.." || exit 1

zig build -Dtarget=wasm32-emscripten

mkdir -p emcc-test/htmlout
cp -R examples/core/resources emcc-test/resources

popd || exit 1

"${cc}" ../examples/core/core_input_gamepad.c ../zig-out/lib/libraylib.a \
-I../zig-out/include \
-o htmlout/index.html \
-sUSE_GLFW=3 \
-sEXPORTED_RUNTIME_METHODS=ccall \
-sINITIAL_MEMORY=67108864 \
-sUSE_PTHREADS=1 \
-sASSERTIONS=1 \
-sASYNCIFY \
--preload-file resources \
--shell-file ../src/shell.html

#!/bin/bash

script_dir=$(dirname "$BASH_SOURCE")
cc="${EMSDK}/upstream/emscripten/emcc"

pushd "${script_dir}/.." || exit 1
mkdir -p emcc-test/htmlout

"${cc}" examples/core/core_input_gamepad.c zig-out/lib/libraylib.a \
-Izig-out/include \
-o emcc-test/htmlout/index.html \
-sUSE_GLFW=3 \
-sEXPORTED_RUNTIME_METHODS=ccall \
-sINITIAL_MEMORY=67108864 \
-sASSERTIONS=1 \
-sASYNCIFY \
--shell-file src/shell.html

popd || exit 1

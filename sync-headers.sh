# SPDX-FileCopyrightText: Contributors to the Power Grid Model project <powergridmodel@lfenergy.org>
#
# SPDX-License-Identifier: MPL-2.0

#!/bin/bash

find src/pgm_build_deps/nlohmann_json -mindepth 1 ! -name '.gitignore' -delete
find src/pgm_build_deps/boost -mindepth 1 ! -name '.gitignore' -delete
find src/pgm_build_deps/eigen -mindepth 1 ! -name '.gitignore' -delete
find src/pgm_build_deps/msgpack_cxx -mindepth 1 ! -name '.gitignore' -delete
find src/pgm_build_deps/doctest -mindepth 1 ! -name '.gitignore' -delete
find src/pgm_build_deps/cli11 -mindepth 1 ! -name '.gitignore' -delete
cp -r $HOMEBREW_PREFIX/Cellar/nlohmann-json/*/* src/pgm_build_deps/nlohmann_json/
cp -r $HOMEBREW_PREFIX/Cellar/boost/*/* src/pgm_build_deps/boost/
cp -r $HOMEBREW_PREFIX/Cellar/eigen/*/* src/pgm_build_deps/eigen/
cp -r $HOMEBREW_PREFIX/Cellar/msgpack-cxx/*/* src/pgm_build_deps/msgpack_cxx/
cp -r $HOMEBREW_PREFIX/Cellar/doctest/*/* src/pgm_build_deps/doctest/
cp -r $HOMEBREW_PREFIX/Cellar/cli11/*/* src/pgm_build_deps/cli11/
find src/ \( -type f ! -exec grep -Iq . {} \; -o -type l \) -delete
ls src/pgm_build_deps/nlohmann_json/
ls src/pgm_build_deps/boost/
ls src/pgm_build_deps/eigen/
ls src/pgm_build_deps/msgpack_cxx/
ls src/pgm_build_deps/doctest/
ls src/pgm_build_deps/cli11/

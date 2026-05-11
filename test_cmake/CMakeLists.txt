# SPDX-FileCopyrightText: Contributors to the Power Grid Model project <powergridmodel@lfenergy.org>
#
# SPDX-License-Identifier: MPL-2.0

cmake_minimum_required(VERSION 3.23)
project(test_cmake)

set(PGM_CXX_STANDARD 23)

if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.30.0")
    #  libboost-headers packaged by conda does not come with BoostConfig.cmake
    cmake_policy(SET CMP0167 OLD)
endif()

find_package(Boost REQUIRED)
find_package(Eigen3 CONFIG REQUIRED)
find_package(nlohmann_json CONFIG REQUIRED)
find_package(msgpack-cxx REQUIRED)
find_package(doctest CONFIG REQUIRED)
find_package(CLI11 CONFIG REQUIRED)


add_executable(test_cmake main.cpp)
target_link_libraries(test_cmake
    PRIVATE
        Eigen3::Eigen
        Boost::headers
        msgpack-cxx
        nlohmann_json::nlohmann_json
        doctest::doctest
        CLI11::CLI11
)

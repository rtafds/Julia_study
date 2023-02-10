cmake_minimum_required(VERSION 3.13)
project(test CXX)

# Libraryを探す関数
find_package(OpenSSL REQUIRED)

add_executable(a.out calc_hash.cpp)
target_link_libraries(a.out
  PRIVATE
    OpenSSL::SSL
  )
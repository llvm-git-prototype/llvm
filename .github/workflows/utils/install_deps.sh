#!/bin/bash
set -e
set -u

os_kind=$1
compiler=$2
compiler_version=$3

if [[ $os_kind == 'Linux' ]]; then
  if [[ $compiler = gcc ]]; then
    compiler_pkg="g++-${compiler_version}"
    compiler_cxx="g++"
  elif [[ $compiler = clang ]]; then
    compiler_pkg="${compiler}-${compiler_version}"
    compiler_cxx="clang++"
  fi
  sudo apt-get install -y ninja-build "${compiler_pkg}"
  echo "::set-env name=CC::${compiler}-${compiler_version}"
  echo "::set-env name=CXX::${compiler_cxx}-${compiler_version}"

elif [[ $os_kind == 'macOS' ]]; then
  brew install ninja
  sudo xcode-select -switch "/Applications/Xcode_${compiler_version}.app"
  echo "::set-env name=CC::clang"
  echo "::set-env name=CXX::clang++"
elif [[ $os_kind == 'Windows' ]]; then
  powershell.exe -command "& .github\workflows\utils\install_deps_windows.ps1"
fi

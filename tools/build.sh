#!/bin/bash
option=$1
build_option=$2
build_option_list=
if [ "${build_option}" == "" ]; then
  build_option=iMX6UL
fi
if [ "${build_option}" == "iMX6UL" ]; then
  gcc_name=Linaro-GCC-4.9-2014.09
fi
if [ "${build_option}" == "iMX6UL_GCC9" ]; then
  gcc_name=arm-gcc-9.2
fi
if [ "${build_option}" == "x86" ]; then
  gcc_name=x86
fi
if [ "${build_option}" == "x86_64" ]; then
  gcc_name=x86_64
fi
debug_build_dir=build/${build_option}_debug
release_build_dir=build/${build_option}_release


project_dir=$(pwd)
project_name=$(echo ${project_dir##*/})
tools_dir="${project_dir}/tools"
echo "project_dir:$project_dir"
echo "project_name:$project_name"
echo "tools_dir:$tools_dir"

mkdir -p ${project_dir}/${debug_build_dir}
mkdir -p ${project_dir}/${release_build_dir}

case ${option} in
"clean")
  cd ${project_dir}/${debug_build_dir}
  make clean
  cd ${project_dir}/${release_build_dir}
  make clean
  cd ${project_dir}
  rm -rf ${project_dir}/build
  ;;
"distclean")
  cd ${project_dir}/${debug_build_dir}
  make clean
  cd ${project_dir}/${release_build_dir}
  make clean
  cd ${project_dir}
  rm -rf ${project_dir}/build
  rm -rf ${project_dir}/bin
  echo "del build dir"
  ;;
"rebuild")
  cd ${project_dir}/${debug_build_dir}
  make clean
  make -j4
  cd ${project_dir}/${release_build_dir}
  make clean
  make -j4
  ;;
*)
  echo "cd ${project_dir}/${debug_build_dir}"
  cd ${project_dir}/${debug_build_dir}
  cmake -DCMAKE_C_COMPILER=${CC} -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_BUILD_TYPE=Debug -DARCH=${build_option} -DGCC_NAME=${gcc_name} -G "CodeBlocks - Unix Makefiles" ${project_dir}
  make -j4

  echo "cd ${project_dir}/${release_build_dir}"
  cd ${project_dir}/${release_build_dir}
  cmake -DCMAKE_C_COMPILER=${CC} -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_BUILD_TYPE=Release -DARCH=${build_option} -DGCC_NAME=${gcc_name} -G "CodeBlocks - Unix Makefiles" ${project_dir}
  make -j4

  ;;
esac

exit 0

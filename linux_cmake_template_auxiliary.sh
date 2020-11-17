#!/bin/bash
option=$1
case ${option} in
"build")
  if [ -z "${2}" ]; then
    echo "build iMX6UL"
    source tools-gcc4.var
    ./tools/build.sh build "iMX6UL"
  elif [ "${2}" == "x86_64" ] || [ "${2}" == "x86" ]; then
    echo "build ${2}"
    source tools.var
    ./tools/build.sh build $2
  elif [ "${3}" == "x86_64" ] || [ "${3}" == "x86" ]; then
    echo "build ${3}"
    source tools.var
    ./tools/build.sh $2 $3
  elif [ "${2}" == "iMX6UL_GCC9" ]; then
    echo "build ${2}"
    source tools-gcc9.2.var
    ./tools/build.sh build $2
  elif [ "${3}" == "iMX6UL_GCC9" ]; then
    echo "build ${3}"
    source tools-gcc9.2.var
    ./tools/build.sh $2 $3
  else
    echo "build iMX6UL"
    source tools-gcc4.var
    ./tools/build.sh $2 "iMX6UL"
  fi
  echo "done"
  ;;
"upload")
  ip=$2
  src_file=$3
  dst_file=$4

  if [ -z "$ip" ] || [ -z "$src_file" ] || [ -z "$dst_file" ]; then
    echo "argument error.debug ip src_file dst_file"
    exit 1
  fi
  echo "login target device and send file to device"
  ./tools/login_upload.sh $2 $3 $4
  echo "done"
  ;;
"debug")
  ip=$2
  src_file=$3
  dst_file=$4

  if [ -z "$ip" ] || [ -z "$src_file" ] || [ -z "$dst_file" ]; then
    echo "argument error.debug ip src_file dst_file"
    exit 1
  fi
  echo "login target device and send file to device"
  ./tools/login_debug.sh $2 $3 $4
  echo "done"
  ;;
"redebug")
  ip=$2
  src_file=$3
  dst_file=$4
  if [ -z "$ip" ] || [ -z "$src_file" ] || [ -z "$dst_file" ]; then
    echo "argument error.redebug ip src_file dst_file"
    exit 1
  fi
  echo "redebug target"
  ./tools/login_redebug.sh $2 $3 $4
  echo "done"
  ;;
"project")
  #项目管理相关
  op=$2
  key=$3
  ./tools/project_op.sh $op $key
  ;;
"install")
  dir=$(pwd)
  sed -i '/^source.*\/tools\/.*bash$/d' ~/.bashrc
  sed -i '/^PATH=.*$/d' ~/.bashrc
  echo "source ${dir}/tools/auxiliary_completion.bash" >>~/.bashrc
  #echo "PATH=${dir}/node_modules/.bin:${dir}:${PATH}" | sed 's/ /\\\ /g' | sed 's/(/\\(/g' | sed 's/)/\\)/g' >>~/.bashrc
  #需要超级用户安装依赖
  echo "install dependence."
  sudo apt install g++ gcc make git lib32stdc++6 lib32z1 expect cmake lib32z1 lib32stdc++6 -y
  is_in_wsl=$(uname -r | grep Microsoft)
  if [ -n "$is_in_wsl" ]; then
    echo "install wsl tools"
    # 暂时不需要兼容这个环境
  fi
  echo "git update"
  git submodule init
  git submodule update --init --recursive
  git submodule sync --recursive

  read -p "want to get git commit standard.[y]" option
  if [ -z "${option}" ]; then
    option=y
  fi
  if [ "${option}" == "y" ]; then
    sudo apt install npm -y
    npm install
  fi

  echo "install done"
  ;;
*)
  echo "unknown cmd"
  ;;
esac
unset CC
unset CXX

exit 0

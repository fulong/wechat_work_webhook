#!/bin/bash
project_dir=$1
project_dir_old=""

#如果没有这个文件就是意味着没有配置完成
project_name_old=linux_cmake_template
project_name_old_upper=LINUX_CMAKE_TEMPLATE

read -p "Input the name.Only letters, numbers, and lower lines are used. [test]  : " project_name
#空值时为默认值
if [ -z "$project_name" ];then
project_name=test
fi
#判断是否为合法名字
test_result=`echo $project_name |  grep '^[a-zA-Z_0-9]*$'`
if [ -z "$test_result" ];then
 echo "Contains illegal characters"
 exit 1
fi
read -p "Input git url for project.If it is empty,it will remove current git url  : " project_git_url

#配置git远程服务器
cd ${project_dir}
project_remote_url=`git remote -v`
if [ -z "${project_git_url}" ];then
   if [ -n "$project_remote_url" ];then
      git remote remove origin
   fi
else
   if [ -z "$project_remote_url" ];then
       git remote add origin ${project_git_url}
   else
       git remote set-url origin ${project_git_url}
   fi
fi

#更改main函数所在文件名字
cd ../src/main
mv ${project_name_old}_main.c ${project_name}_main.c

#更改README
echo "# ${project_name}" > README.md
#sed -i "s/${project_name_old}/${project_name}/g" README.md

#存在node目录的话为commit标准存在
if [ -d "node_modules" ];then
    url_frame_template=${project_git_url/\//\\\/}
    url_frame_template=${url_frame_template/git@git\.fulong\.me:/https:\\\/\\\/git\\\.fulong\\\.me\\\/}
    sed -i "s/\<${project_name_old}\>/${project_name}/g" package.json 
    if [ -n "$project_remote_url" ];then
        sed -i "s/https.*\.git/${url_frame_template}/g" package.json
	#把版本号设置为0.0.0
	 sed '0,/version/{//d}' package.json | sed '/description/i\"version":"0.0.0"\,' > tmp
	 mv tmp package.json
    else
	echo "please correct the git url in the package.json manually."
    fi
fi

rm -rf patch

git add .
git commit -m"自动配置完成"

exit 0

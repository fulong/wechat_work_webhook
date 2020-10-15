#!/bin/bash
project_dir=`pwd`
project_name=`echo ${project_dir##*/}`
tools_dir="${project_dir}/tools"
ip=$1
src_file=$2
dst_file=$3
echo "project_dir:$project_dir"
echo "project_name:$project_name"
echo "tools_dir:$tools_dir"
echo "ip=$ip" 
echo "src_file=$src_file"
echo "dst_file=$dst_file"
ssh-keygen -f "~/.ssh/known_hosts" -R "$ip"
#获取账号密码
if [ -f "${tools_dir}/scp_passwd_user" ];then
    user=`cat ${tools_dir}/scp_passwd_user | cut -d ' ' -f 1`
    passwd=`cat ${tools_dir}/scp_passwd_user | cut -d ' ' -f 2`
    gdbserver_port=`cat ${tools_dir}/scp_passwd_user | cut -d ' ' -f 3`
else
#自定义账号密码不存在,则用默认的
    user=root
    passwd=root
fi
${tools_dir}/ssh_login_kill_gdb.sh $ip $user $passwd $dst_file
${tools_dir}/scp_passwd.sh $ip $user $passwd $src_file $dst_file

exit 0

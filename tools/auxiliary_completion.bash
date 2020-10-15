#!/bin/bash
#让bash可以自动补全auxiliary工具参数,这脚本在install命令下会运行,也可以手动执行
_auxiliary()
{

    COMPREPLY=()
    local cur=${COMP_WORDS[COMP_CWORD]};
    local cmd=${COMP_WORDS[COMP_CWORD-1]};
    first_cmd="build install debug redebug project"
    case $cmd in
    './linux_cmake_template_auxiliary.sh')
	  COMPREPLY=( $(compgen -W '${first_cmd[@]}' -- $cur) ) ;;
    'build')
          local pro="distclean clean all rebuild"
          COMPREPLY=( $(compgen -W '${pro[@]}' -- $cur) ) ;;
  'project')
          local pro="release version changelog commit"
          COMPREPLY=( $(compgen -W '${pro[@]}' -- $cur) )
	  ;;
    '*')
          ;;
    esac
    return 0
}
complete -F _auxiliary ./linux_cmake_template_auxiliary.sh

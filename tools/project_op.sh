#!/bin/bash
#op 脚本操作命令
#key gitlab 用户token
op=$1
key=$2
case "$op" in
	"release" )
		if [ -n "$key" ];then
			TOKEN=${key} npm run release
		else
			echo "user token can not be empty."
		fi
		;;
	"release-new" )
		if [ -n "$key" ];then
			TOKEN=${key} npm run release-new
		else
			echo "user token can not be empty."
		fi
		;;
	"version" )
		npm run version
		;;
	#"changelog" )
	#	npm run changelog
	#	;;
	"commit" )
		npm run commit 
		;;
	* )
		;;
esac

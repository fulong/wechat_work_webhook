/**
* @file linux_cmake_template_main.c
* @brief this is a brief description
* @details this is the detail description.
* @author fulong
* @date 2020/10/15	
* @version 1.0
* @par Copyright (c):
* @par First build 2020/10/15
*/
#include "linux_cmake_template_main.h"
#include "stdio.h"
#include "string.h"
struct linux_cmake_template_struct linux_cmake_template;

int main(int argc, char *argv[])
{
    {
        //加载版本号
        memset(linux_cmake_template.version, 0, sizeof(linux_cmake_template.version));
        sprintf(linux_cmake_template.version, "%d.%d.%d", APP_VERSION, APP_SUBVERSION, APP_REVISION);
        LINUX_CMAKE_TEMPLATE_DEBUG("linux_cmake_template %s is running.build:%s,%s", linux_cmake_template.version, __DATE__, __TIME__);
    }
    return 0;
}
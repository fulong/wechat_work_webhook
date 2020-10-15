/**
* @file linux_cmake_template_main.h
* @brief this is a brief description
* @details this is the detail description.
* @author fulong
* @date 2020/10/15	
* @version 1.0
* @par Copyright (c):
*/
#ifndef __LINUX_CMAKE_TEMPLATE_MAIN_H__
#define __LINUX_CMAKE_TEMPLATE_MAIN_H__

#include "stdint.h"

#define APP_VERSION 0
#define APP_SUBVERSION 0
#define APP_REVISION 0

//#define USE_DEBUG_DZ 1

#ifdef USE_DEBUG_DZ
#define LINUX_CMAKE_TEMPLATE_DEBUG(...) if(USE_DEBUG_DZ)dzlog_debug(__VA_ARGS__)
#define LINUX_CMAKE_TEMPLATE_ERROR(...) if(USE_DEBUG_DZ)dzlog_error(__VA_ARGS__)
#define LINUX_CMAKE_TEMPLATE_INFO(...) if(USE_DEBUG_DZ)dzlog_info(__VA_ARGS__)
#else
#define LINUX_CMAKE_TEMPLATE_DEBUG(...) {printf(__VA_ARGS__);printf("\n");}
#define LINUX_CMAKE_TEMPLATE_ERROR(...)
#define LINUX_CMAKE_TEMPLATE_INFO(...)
#endif

struct linux_cmake_template_struct
{
    char version[20];
};

#endif //__LINUX_CMAKE_TEMPLATE_MAIN_H__

/**
* @file wechat_work_webhook_main.h
* @brief this is a brief description
* @details this is the detail description.
* @author fulong
* @date 2020/10/15	
* @version 1.0
* @par Copyright (c):
*/
#ifndef __WECHAT_WORK_WEBHOOK_MAIN_H__
#define __WECHAT_WORK_WEBHOOK_MAIN_H__

#include "stdint.h"

#define APP_VERSION 0
#define APP_SUBVERSION 0
#define APP_REVISION 0

//#define USE_DEBUG_DZ 1

#ifdef USE_DEBUG_DZ
#define WECHAT_WORK_WEBHOOK_DEBUG(...) if(USE_DEBUG_DZ)dzlog_debug(__VA_ARGS__)
#define WECHAT_WORK_WEBHOOK_ERROR(...) if(USE_DEBUG_DZ)dzlog_error(__VA_ARGS__)
#define WECHAT_WORK_WEBHOOK_INFO(...) if(USE_DEBUG_DZ)dzlog_info(__VA_ARGS__)
#else
#define WECHAT_WORK_WEBHOOK_DEBUG(...) {printf(__VA_ARGS__);printf("\n");}
#define WECHAT_WORK_WEBHOOK_ERROR(...)
#define WECHAT_WORK_WEBHOOK_INFO(...)
#endif

struct wechat_work_webhook_struct
{
    char version[20];
};

#endif //__WECHAT_WORK_WEBHOOK_MAIN_H__

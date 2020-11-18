/**
* @file wechat_work_webhook_main.c
* @brief this is a brief description
* @details this is the detail description.
* @author fulong
* @date 2020/10/15	
* @version 1.0
* @par Copyright (c):
* @par First build 2020/10/15
*/
#include "wechat_work_webhook_main.h"
#include "stdio.h"
#include "string.h"
struct wechat_work_webhook_struct wechat_work_webhook;

int main(int argc, char *argv[])
{
    {
        //加载版本号
        memset(wechat_work_webhook.version, 0, sizeof(wechat_work_webhook.version));
        sprintf(wechat_work_webhook.version, "%d.%d.%d", APP_VERSION, APP_SUBVERSION, APP_REVISION);
        WECHAT_WORK_WEBHOOK_DEBUG("wechat_work_webhook %s is running.build:%s,%s", wechat_work_webhook.version, __DATE__, __TIME__);
    }
    return 0;
}
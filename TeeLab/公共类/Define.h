//
//  Define.h
//  tp_self_help
//
//  Created by cloudpower on 13-7-22.
//  Copyright (c) 2013年 cloudpower. All rights reserved.
//
#define id_certificateNo    @"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}((19\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|(19\\d{2}(0[13578]|1[02])31)|(19\\d{2}02(0[1-9]|1\\d|2[0-8]))|(19([13579][26]|[2468][048]|0[48])0229))\\d{3}(\\d|X|x)?$"





#ifndef tp_self_help_Define_h
#define tp_self_help_Define_h

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

#define IOSDevice [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue]

#define IOS70_71    IOSDevice>=7.0&&IOSDevice<7.1

#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))
#define ORIGIN_X(view) view.frame.origin.x
#define ORIGIN_Y(view) view.frame.origin.y
#define SIZE_WITDH(view) view.frame.size.width
#define SIZE_HEIGHT(view) view.frame.size.height


#define iPhone4Retina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define FOR_SIT_IOS7_HEIGHT   (IOS70_71 ? 64:44)

#define NAV_BAR_HEIGHT      10
#define STATUS_BAR_HEIGHT   10

#define TAG_TEXT_FIELD_PHONE_NUM        1000

/********************  各api接口  key *********************************/
#define KEY_SEARCH_VIOLATE_REGULAR @"235ea51bcb4e4a5777984e4c0cf75fb8"

/********************  数据库字段  ****************************/


#pragma mark- 定义网络请求 成功／失败 返回字符串
/********************  网络请求  ****************************/
#define SUCC         @"网络连接请求成功"
#define FAILED          @"网络连接异常，请稍后再试。"
#define DIS_CRIBE       @"discribe"
#define UP_PHOTO_SUCC  @"影像上传成功！"

//服务器接口
#define LOGIN_TYPE_USERNAME         @"1"
#define LOGIN_TYPE_IDNUMBER         @"2"



//是否有更新
#define REFRESH_DESC_NO             @"无版本更新"          //无更新
#define REFRESH_DESC_YES            @"有版本更新"         //有更新
#define REFRESH_DOWNLOUD_URL        @"refresh_download_url"     //下载地址


/********************  userdefault中的信息key  ****************************/

#define KEY_USER_NAME            @"userName"
#define KEY_ID_NUMBER            @"idNumber"
#define KEY_PASS_WORD            @"passWord"
#define KEY_IS_AUTOLOGIN         @"isAutoLogin" 

#define SHIP_INFORMATIN         @"shippinginformation"   ////配送信息


#define KEY_WEATHER_CACHE           @"weather_cache"
#define KEY_OUR_APP_REFRESH_PATH    @"our_app_refresh_path"
#define KEY_PUSH_MSG_ARRAY          @"key_push_msg_array"
#define KEY_LONGITUDE               @"longitude"
#define KEY_LATITUDE                @"latitude" //dujw

#define APPID_store  @"ff80808140f66a980140f68f816b0027"     ///app id  暂时用 当从app store获得真正id号 再换过来


//phonegap callbackid
#define  HTTP_CALLBACK_ID      @"callbackId"



//插件状态
#define PLUGIN_STATUS_UNINSTALL             @"uninstall"//未安装
#define PLUGIN_STATUS_INSTALLED             @"installed"//已安装
#define PLUGIN_STATUS_NEED_UPDATE           @"need_update"//需要更新






/////////////////展业

#define IOS7 if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))\
{self.edgesForExtendedLayout=UIRectEdgeNone;\
self.navigationController.navigationBar.translucent = NO;}

//#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))

#define TAG_TEXT_FIELD_PHONE_NUM        1000

#define RECT(x,y,witdh,height) CGRectMake(x, y, witdh, height)
#define ORIGIN_X(view) view.frame.origin.x
#define ORIGIN_Y(view) view.frame.origin.y
#define SIZE_WITDH(view) view.frame.size.width
#define SIZE_HEIGHT(view) view.frame.size.height


#endif

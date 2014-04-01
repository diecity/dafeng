//
//  ApnsMnger.m
//  DTC_YGJT
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "ApnsMnger.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
//#import "IndexViewController.h"
//#import "LoginViewController.h"
//#import "InsiteInfoModel.h"
//#import "InsiteInfoViewController.h"
//#import "ProductCenterViewController.h"
//#import "ServiceCenterViewController.h"


@interface ApnsMnger (PrivateMethods)

- (void)sendDeviceToken:(NSString *)deviceToken;
- (NSString *)data2hexStr:(NSData *)data;

@end

@implementation ApnsMnger

#pragma mark life cycle

+ (ApnsMnger *)sharedManager {
    static ApnsMnger *obj = nil;
    if (obj == nil) {
        obj = [[ApnsMnger alloc] init];
    }
    
    return obj;
}

- (id)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (void)dealloc {
    
    [super dealloc];
}

#pragma mark UIApplicationDelegate相关处理
- (void)applicationDidFinishLaunching
{
    // 清除Badge（应用程序Icon上的数字标示）
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    // 从存储中取出之前保存的DeviceToken
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *deviceTokenStr = [ud stringForKey:kApnsDeviceToken];
    DLog(@"%@", deviceTokenStr);

    if ((![[UIApplication sharedApplication] enabledRemoteNotificationTypes])
        || deviceTokenStr == nil
        || [deviceTokenStr length] == 0
        ) {
        // 如果上次注册消息推送失败，则重新注册消息推送
        // 消息推送支持的类型
        UIRemoteNotificationType types = 
        (UIRemoteNotificationTypeBadge 
         |UIRemoteNotificationTypeSound 
         |UIRemoteNotificationTypeAlert);
        // 注册消息推送
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types]; 
    } else if (![deviceTokenStr isEqualToString:kApnsDeviceTokenSendOK]) {
        // 如果上次发送DeviceToken失败，则重新将DeviceToken发送到服务端
        [self sendDeviceToken:deviceTokenStr];
    }
}

// 获取DeviceToken成功
- (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    DLog(@"DeviceToken: {%@}",deviceToken); 
    NSString *deviceTokenStr = [self data2hexStr:deviceToken];
    // 持久化deviceToken
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:deviceTokenStr forKey:kApnsDeviceToken];
    // 将DeviceToken发送到服务端
    [self sendDeviceToken:deviceTokenStr];
   // [DTGlobal showAlert:nil message:@"获取DeviceToken成功"];
}

// 注册消息推送失败
- (void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error 
{
    DLog(@"Register Remote Notifications error:{%@}",[error localizedDescription]);
   // [DTGlobal showAlert:nil message:@"Register error!"];
}

// 处理收到的消息推送
- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo
{
    DLog(@"Receive remote notification : %@",userInfo);
  //  [DTGlobal showAlert:nil message:@"收到的消息推送!"];
    // 解析出消息内容
    NSString *msg = @"";
    @try {
        id objAlert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        if ([objAlert isKindOfClass:[NSString class]]) {
            msg = objAlert;
        } else if ([objAlert isKindOfClass:[NSDictionary class]]) {
            id objBody = [objAlert objectForKey:@"body"];
            if ([objBody isKindOfClass:[NSString class]]) {
                msg = objBody;
            }
        }
    }
    @catch(NSException *exception) {
    }
    
  //  BOOL running = [[NSUserDefaults standardUserDefaults] boolForKey:@"running"];
//	if (YES==running) {
            // 显示Alert
            UIAlertView *alert = 
            [[UIAlertView alloc] initWithTitle:@"站内信" 
                                       message:msg 
                                      delegate:self 
                             cancelButtonTitle:@"取消" 
                             otherButtonTitles:@"去看看",nil];
            [alert show];
            [alert release];
		
//	}else{
//        if ([GlobalVariableManage shareApplication].isLogin) {
//            InsiteInfoModel *Model = [[InsiteInfoModel alloc] init];
//            [Model setDelegate:self];
//            [Model setDidFailedSelector:@selector(submitRequestFailed:)];
//            [Model setDidFinishSelector:@selector(submitRequestFinished:)];
//            [Model getInfo];
//        }else{
//            UINavigationController *navigationController = [IndexViewController navigationController];
//            LoginViewController *vc = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
//            [navigationController pushViewController:vc animated:YES];
//        }
    
 //   }

}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex ==1) {
//         if ([GlobalVariableManage shareApplication].isLogin) {
//             InsiteInfoModel *Model = [[InsiteInfoModel alloc] init];
//             [Model setDelegate:self];
//             [Model setDidFailedSelector:@selector(submitRequestFailed:)];
//             [Model setDidFinishSelector:@selector(submitRequestFinished:)];
//             [Model getInfo];
//        }else{
//            UINavigationController *navigationController = [IndexViewController navigationController];
//            LoginViewController *vc = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
//            [navigationController pushViewController:vc animated:YES];
//        }
//
//    }
//    
//}

//提交查询请求失败
- (void)submitRequestFailed:(NSDictionary *)returnDic{
    NSString *showAlertText = [returnDic objectForKey:@"retText"];
    [DTGlobal showAlert:@"" message:showAlertText];
}

//提交查询请求返回数据成功
//- (void)submitRequestFinished:(NSArray *)returnArr{
//    UINavigationController *navigationController = [IndexViewController navigationController];
//    InsiteInfoViewController* insiteInfoVC = [[InsiteInfoViewController alloc] initWithNibName:@"InsiteInfoViewController" bundle:nil];
//    [insiteInfoVC initWithReturnArr:returnArr andHasProduct:NO];
//    insiteInfoVC.title = @"站内信";
//    
//    if ([GlobalVariableManage shareApplication].viewType == IndexView)   
//    {  
//       [navigationController pushViewController:insiteInfoVC animated:YES];
//    }else if([GlobalVariableManage shareApplication].viewType == ProductCenter){
//         UINavigationController *navProductCenter = [ProductCenterViewController navigationController];
//        [navProductCenter pushViewController:insiteInfoVC animated:YES];
//    }else{
//        UINavigationController *navServiceCenter = [ServiceCenterViewController navigationController];
//        [navServiceCenter pushViewController:insiteInfoVC animated:YES];
//    }  
//    [insiteInfoVC release];
//}
//

#pragma mark private methods
// 将deviceToken发送给服务器
- (void)sendDeviceToken:(NSString *)deviceToken
{
    NSLog(deviceToken);
    // 从配置文件中得到地址
    NSString *urlStr = [DTGlobal requestAddress:@"RegisterToken"];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 发送请求
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded; charset=UTF-8"];
    NSString *reqParams = [NSString stringWithFormat:@"tokenId=%@", deviceToken];
    [request appendPostData:[reqParams dataUsingEncoding:NSUTF8StringEncoding]];
    ////request.showMask = NO;
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    DLog(@"Apns-token http finished:%@", responseString);

    // 从response中取出retCode
    const NSInteger retCodeErr = -1;
    NSInteger retCode = retCodeErr;
    @try {
        SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
        NSDictionary *jsonObj = [parser objectWithString:responseString];
        NSNumber *objRetCode = [[[jsonObj objectForKey:@"ret"] objectForKey:@"header"] objectForKey:@"retCode"];
        retCode = objRetCode ? [objRetCode intValue] : retCodeErr;
    }
    @catch(NSException *exception) {
        retCode = retCodeErr;
    }
    
    if (retCode == 0/*success*/) {
        // 持久化deviceToken发送成功标志
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:kApnsDeviceTokenSendOK forKey:kApnsDeviceToken];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    DLog(@"Apns-token http error:%@", error);
}

- (NSString *)data2hexStr:(NSData *)data
{
    Byte *bytes = (Byte *)[data bytes];
    NSMutableString *hexStr = [NSMutableString stringWithFormat:@"%@", @""];
    for (int i = 0; i < [data length]; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%02x", bytes[i]]; ///16进制数
        [hexStr appendFormat:@"%@", newHexStr];
    }
    return hexStr;
}

@end

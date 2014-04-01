//
//  ApnsMnger.h
//  DTC_YGJT
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

// 消息推送处理

#define kApnsDeviceToken        @"kApnsDeviceToken"
#define kApnsDeviceTokenSendOK  @"kApnsDeviceTokenSendOK"

#import <Foundation/Foundation.h>

@interface ApnsMnger : NSObject<UIAlertViewDelegate>

+ (ApnsMnger *)sharedManager;

- (void)applicationDidFinishLaunching;
- (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo;

@end

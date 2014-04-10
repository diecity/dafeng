//
//  SettingViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-8.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIHelper.h"

#import "CommonVariable.h"
//#import "NetWork.h"
#import "UserInfo.h"
//#import "CDVViewController.h"
//#import "MorePluginViewController.h"
#import "Define.h"



@interface SettingViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate
>
{
    UITableView                     *_rootTableView;
    
    UIButton                        *_refreshB;
    UIButton                        *_cleanB;
    UISwitch                        *_pushMsgS;
    
    MBProgressHUD                   *_hud;
    
    NSString                        *version_appstore;   ///app score上的版本
    
}

@property (nonatomic, retain)   NSString                        *refreshUrl;
@end

//
//  SettingViewController.h
//  AppCenters
//
//  Created by cloudpower on 13-8-10.
//
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

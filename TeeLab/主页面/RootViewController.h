//
//  RootViewController.h
//  TeeLab
//
//  Created by teelab2 on 14-4-1.
//  Copyright (c) 2014年 teelab2. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"
@interface RootViewController : UIViewController<   UMSocialUIDelegate,UIActionSheetDelegate,
UMSocialShakeDelegate>

@end

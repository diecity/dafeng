//
//  LogInmainViewController.h
//  TeeLab
//
//  Created by teelab2 on 14-4-2.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"


@interface LogInmainViewController : UIViewController<UMSocialDataDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UMSocialUIDelegate>{
    UITapGestureRecognizer *tapGesture;
    UIScrollView  * _ad_scrollView;

}
@property (weak, nonatomic) IBOutlet UITextField *UseName;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (weak, nonatomic) IBOutlet UIView *LogIn_view;

@end

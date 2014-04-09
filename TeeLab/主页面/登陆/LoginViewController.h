//
//  LoginViewController.h
//  TeeLab
//
//  Created by teelab2 on 14-4-1.
//  Copyright (c) 2014年 teelab2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIScrollView  * _ad_scrollView;
    UITapGestureRecognizer *tapGesture;


}
@property (weak, nonatomic) IBOutlet UIView *GestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *NoLogin;
@end

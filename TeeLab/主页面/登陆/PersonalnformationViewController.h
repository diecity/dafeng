//
//  PersonalnformationViewController.h
//  TeeLab
//
//  Created by teelab2 on 14-4-2.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CheckButton;

#import "CPComboBox.h"
@interface PersonalnformationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *head_imagebut;
@property (strong, nonatomic) IBOutlet UIView *haedview;
@property (weak, nonatomic) IBOutlet UIScrollView *Headscroll;
@property (weak, nonatomic) IBOutlet UIView *root_View;

@property (weak, nonatomic) IBOutlet CPComboBox *Country_cp;
@property (weak, nonatomic) IBOutlet CPComboBox *City_cp;

//////个人信息
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UITextField *Age;
@property (weak, nonatomic) IBOutlet UITextField *telphone;
@property (weak, nonatomic) IBOutlet UITextField *Profession;

@end

//
//  RegisterViewController.h
//  TeeLab
//
//  Created by teelab2 on 14-4-1.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>{
    UITapGestureRecognizer *tapGesture;
}
@property (weak, nonatomic) IBOutlet UITextField *UseName;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (weak, nonatomic) IBOutlet UITextField *PassWord2;
@property (weak, nonatomic) IBOutlet UITextField *E_mail;
@property (weak, nonatomic) IBOutlet UITextField *telphoto;
@property (weak, nonatomic) IBOutlet UITextField *Adress;
@property (weak, nonatomic) IBOutlet UIView *LogIn_view;

@end

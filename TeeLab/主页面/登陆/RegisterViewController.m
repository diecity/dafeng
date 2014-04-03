//
//  RegisterViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-1.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIHelper.h"
#import "PersonalnformationViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"注册";
    
}



- (IBAction)Regisercommint:(UIButton *)sender {
    NSLog(@"提交注册");
    
    if ([_UseName.text length]==0) {
        [UIHelper alertWithTitle:@"请输入用户名！"];
        return;
    }else  if ([_UseName.text length]<3||[_UseName.text length]>30) {
        [UIHelper alertWithTitle:@"用户名只能为3到30位字符！"];
        return;
    }
    if ([_PassWord.text length]==0) {
        [UIHelper alertWithTitle:@"请输入密码！"];
        return;

    }if ([_PassWord.text length]<6) {
        [UIHelper alertWithTitle:@"密码不能少于6位！"];
        return;
        
    }
    if ([_E_mail.text length]==0) {
        [UIHelper alertWithTitle:@"请输入邮箱！"];
        return;
        
    }if ([_E_mail.text length]<6) {
        [UIHelper alertWithTitle:@"邮箱格式不正确"];
        return;
        
    }
    
    
    //////完善个人信息
    PersonalnformationViewController*Personal=[[PersonalnformationViewController alloc]init];
    [self.navigationController pushViewController:Personal animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

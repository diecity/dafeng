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
#import "LogInmainViewController.h"


#define EMAILE_ZH  @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"

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
- (void)onTap
{
    [self hideKeyBoard];
}

- (void)hideKeyBoard
{
    [_UseName resignFirstResponder];
    [_PassWord resignFirstResponder];
    [_PassWord2 resignFirstResponder];
    [_E_mail resignFirstResponder];
    [_telphoto resignFirstResponder];
    [_Adress resignFirstResponder];
    _LogIn_view.frame=CGRectMake(0, 64, 320, 350);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"注册";
    //添加手势
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tapGesture.delegate = self;
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGesture];
    _E_mail.delegate=self;
    _telphoto.delegate=self;
    _Adress.delegate=self;
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
    if ([_PassWord2.text length]==0) {
        [UIHelper alertWithTitle:@"请输入确认密码！"];
        return;
        
    }if ([_PassWord2.text length]<6) {
        [UIHelper alertWithTitle:@"确认密码不能少于6位！"];
        return;
        
    }
    if (![_PassWord.text isEqualToString:_PassWord2.text]) {
        [UIHelper alertWithTitle:@"输入密码不一致！"];        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EMAILE_ZH];
    if( _E_mail.text.length == 0 ){
        [UIHelper alertWithTitle:@"被保人邮箱不能为空！"];        return;
    }
    else if (![predicate evaluateWithObject:_E_mail.text]) {
        [UIHelper alertWithTitle:@"被保人邮箱格式不对！"];        return;
    }
    
    
    [UIHelper alertWithTitle:@"恭喜您,注册成功" andMSG:@"是否完善个人信息！" delegate:self andTag:101];
    
  
    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{       // became first responder
    
    
    if (textField.tag==71||textField.tag==72||textField.tag==73) {
        _LogIn_view.frame=CGRectMake(0, -50, 320, 350);

    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==101) {
        
        if (buttonIndex==1) {
            //////完善个人信息
            PersonalnformationViewController*Personal=[[PersonalnformationViewController alloc]init];
            [self.navigationController pushViewController:Personal animated:YES];
        }
        else {
            
            //////进入登陆界面
            LogInmainViewController*Personal=[[LogInmainViewController alloc]init];
            [self.navigationController pushViewController:Personal animated:YES];
            
//            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

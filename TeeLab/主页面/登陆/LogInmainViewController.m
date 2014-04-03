//
//  LogInmainViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-2.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "LogInmainViewController.h"
#import "UIHelper.h"

#import "RootViewController.h"
@interface LogInmainViewController ()

@end

@implementation LogInmainViewController

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
    _LogIn_view.frame=CGRectMake(0, 267, 320, 144);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"登陆";
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;      //设置回调对象

    
    //添加手势
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tapGesture.delegate = self;
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGesture];
    _PassWord.delegate=self;
    _UseName.delegate=self;
    
}
- (IBAction)LogIn:(id)sender {
    NSLog(@"登陆");
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
    
    [self hideKeyBoard];
    
    RootViewController *root=[[RootViewController alloc]init];
    [self.navigationController pushViewController:root animated:YES];
    
    
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    _LogIn_view.frame=CGRectMake(0, 120, 320, 144);
//
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField{       // became first responder
    
    _LogIn_view.frame=CGRectMake(0, 120, 320, 144);

    
}



- (IBAction)QQlogIn:(id)sender {
    NSLog(@"qq登陆");

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"UMShareToTencent==response is %@",response);
        
        if (response.responseCode==UMSResponseCodeSuccess) {
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"tencent"] objectForKey:@"openid"];
            
            NSLog(@"QQ===response is %@",str);
        }else  if (response.responseCode==UMSResponseCodeCancel){
//            [UIHelper alertWithTitle:@"取消授权！"];
        }else{
            [UIHelper alertWithTitle:@"授权失败！"];

        }
        

    });

    
    
    
}
- (IBAction)SinaLogIn:(id)sender {
    NSLog(@"新浪登陆");
    
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);

        NSDictionary *dicdate=(NSDictionary*)response.data;
        NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"usid"];
        
        NSLog(@"response is %@",str);


        
    });

}
//实现回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    
    if (response.viewControllerType == UMSViewControllerOauth) {
        NSLog(@"didFinishOauthAndGetAccount response is %@",response);
        
    }
}


- (IBAction)XiaoneiLogIn:(id)sender {
    NSLog(@"人人登陆");
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToRenren];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"renren"] objectForKey:@"usid"];
            
            NSLog(@"renren====response is %@",str);

            
    });
}
- (IBAction)declineLogIn:(id)sender {
    NSLog(@"微信登陆");
    
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。 摔香炉
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"usid"];
            NSLog(@"response is %@",str);

    });
    


}
- (IBAction)DouBanLogin:(id)sender {
    
    NSLog(@"豆瓣登陆");
    
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。 
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToDouban];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
        NSDictionary *dicdate=(NSDictionary*)response.data;
        NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"usid"];
        NSLog(@"response is %@",str);
        
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

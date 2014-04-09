//
//  RootViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-1.
//  Copyright (c) 2014年 teelab2. All rights reserved.
//

#import "RootViewController.h"
#import "UMSocialScreenShoter.h"
#import "AppDelegate.h"

#import "UMSocial.h"

#import "UMSocialLoginViewController.h"


#import "SettingViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    self.title=@"主页";
    
    
    
}
#pragma  mark 设置  

- (IBAction)SettingOfUser:(id)sender {
    
    SettingViewController *setvc=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:setvc animated:YES];
}

#pragma  mark 分享应用
- (IBAction)Share:(UIButton *)sender {
    
    
    
    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"直接分享给小伙伴" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    NSArray *share_arry=[[NSArray alloc]initWithObjects:@"腾讯微博",@"新浪微博",@"QQ空间",@"人人网",@"微信好友",@"微信朋友圈",@"豆瓣",@"email", nil];
    
    for (NSString *snsName in share_arry) {
        [editActionSheet addButtonWithTitle:snsName];
        
    }
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = 101;
    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
//    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
    [editActionSheet showInView:self.view];
    editActionSheet.delegate = self;
//    [self.view addSubview:editActionSheet];
}


/*
 在自定义分享样式中，根据点击不同的点击来处理不同的的动作
 
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex + 1 >= actionSheet.numberOfButtons ) {
        return;
    }
    
    //分享编辑页面的接口,snsName可以换成你想要的任意平台，例如UMShareToSina,UMShareToWechatTimeline
    NSString *snsName = @"";
    switch (buttonIndex) {
        case 0:
            snsName=@"tencent";
            break;
        case 1:
            snsName=@"sina";
            break;
        case 2:
            snsName=@"qzone";
            break;
        case 3:
            snsName=@"renren";
            break;
        case 4:
            snsName=@"wxsession";  //@"Session",
            break;
        case 5:
            snsName=@"wxtimeline";
            break;
        case 6:
            snsName=@"douban";
            break;
        case 7:
            snsName=@"email";
            break;
        default:
            break;
    }
//    NSArray *array=[[NSArray alloc]initWithObjects:@"tencent",@"sina",@"qzone",@"renren",@"wxtimeline",@"douban",@"facebook",@"sms", nil];
    
    
    NSString *shareText = @"加入我们，成就新时代的梦想，我们是TeeLab!";
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
    
   if (actionSheet.tag == 101){
        
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[snsName] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity * response){
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alertView show];
            } else if(response.responseCode != UMSResponseCodeCancel) {
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                    [alertView show];
                }
            }
        }];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

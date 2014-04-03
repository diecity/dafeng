//
//  LoginViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-1.
//  Copyright (c) 2014年 teelab2. All rights reserved.
//

#import "LoginViewController.h"
#import "UIHelper.h"
#import "RegisterViewController.h"
#import "LogInmainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//初始化广告图片
- (void)initADimageView
{
    [_ad_scrollView setContentSize:CGSizeMake(320, 0)];
//    _ad_scrollView.delegate = self;
    for (int i = 0; i < 1; i++)
    {
        UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 320 * i, 10, 300, 180)];
        NSString *imageName = nil;
        if (i == 0) {
            imageName = @"APP广告.jpg";
            
        }
        else
            //            imageName = [NSString stringWithFormat:@"民安自助ok切图_backgroud%d.png",i + 1];
            imageName = @"APP广告.jpg";
        
        [adImageView setImage:[UIImage imageNamed:imageName]];
        [_ad_scrollView insertSubview:adImageView atIndex:1];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=adImageView.frame;
        [btn addTarget:self action:@selector(buttonnextOfview:) forControlEvents:UIControlEventTouchUpInside];
        [_ad_scrollView addSubview:btn];
    }
    //1秒换图片
      [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeImageInTimer:) userInfo:nil repeats:YES];
    
}
-(void)buttonnextOfview:(UIButton*)sender{
    
    
}
#pragma mark -1秒换图片-
- (void)changeImageInTimer:(NSTimer *)timer
{
    
    static int page_ye=0;
    //    int page = _ad_pageControl.currentPage;
    page_ye++;
    page_ye = page_ye > 2 ? 0:page_ye;
//    _ad_pageControl.currentPage = page_ye;
    _ad_scrollView.contentOffset = CGPointMake(0 + 320 * page_ye, 0);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //nav
    self.title=@"登陆";
//    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_settting.png"] title:@"设置" target:self]];
    
    _ad_scrollView=[[UIScrollView alloc]init];
    _ad_scrollView.frame=CGRectMake(0, 0, 320, 200);
    [self initADimageView];   ///添加广告位
    [self.view addSubview:_ad_scrollView];
    
}

- (IBAction)Login:(UIButton *)sender {

    LogInmainViewController *loginmanin=[[LogInmainViewController alloc]init];
    [self.navigationController pushViewController:loginmanin animated:YES];
    NSLog(@"d登陆");
    
}
- (IBAction)Register:(UIButton *)sender {
    NSLog(@"注册");
    RegisterViewController *reg=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];

}
- (IBAction)NoLogin:(UIButton *)sender {
    NSLog(@"不登陆直接访问");


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  LoginViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-1.
//  Copyright (c) 2014年 teelab2. All rights reserved.
//

#import "LoginViewController.h"
#import "UIHelper.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //nav
    self.title=@"登陆";
//    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_settting.png"] title:@"设置" target:self]];
}

- (IBAction)Login:(UIButton *)sender {
    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_settting.png"] title:@"设置" target:self]];

    NSLog(@"d登陆");
}
- (IBAction)Register:(UIButton *)sender {
    NSLog(@"注册");

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

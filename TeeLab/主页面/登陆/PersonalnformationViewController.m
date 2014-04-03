//
//  PersonalnformationViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-2.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "PersonalnformationViewController.h"

#import "RootViewController.h"

@interface PersonalnformationViewController ()

@end

@implementation PersonalnformationViewController

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
    self.title=@"个人信息";
    
    
}
- (IBAction)RightNowlook:(id)sender {
    RootViewController *ROOT=[[RootViewController alloc]init];
    [self.navigationController pushViewController:ROOT animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

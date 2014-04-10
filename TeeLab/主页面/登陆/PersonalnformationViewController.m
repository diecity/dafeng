//
//  PersonalnformationViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-2.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "PersonalnformationViewController.h"

#import "RootViewController.h"
#import "CheckButton.h"
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
    [self MakeViewOfHead];
    
    _Country_cp.dataSource=[[NSArray alloc]initWithObjects:@"ssmfdsfdy有新的收藏",@"五年",@"八年",@"十年", nil];
    _Country_cp.codeArray=[[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3", nil];
    
    
    
}
- (IBAction)RightNowlook:(id)sender {
    RootViewController *ROOT=[[RootViewController alloc]init];
    [self.navigationController pushViewController:ROOT animated:YES];
    
    
}
- (void)onTap
{
    [self hideKeyBoard];
}

- (void)hideKeyBoard
{
    [_realName resignFirstResponder];
    [_telphone resignFirstResponder];
    [_Age resignFirstResponder];
//    [_E_mail resignFirstResponder];
//    [_telphoto resignFirstResponder];
//    [_Adress resignFirstResponder];
//    _LogIn_view.frame=CGRectMake(0, 64, 320, 350);
    
}
- (IBAction)HeadImage:(UIButton *)sender {
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";      ///////吸收
    animation.subtype = kCATransitionFromRight;     ///////从右开始
    
    self.haedview.frame=CGRectMake(0, 64, 320, 200);
    self.haedview.hidden=NO;

    [self.view addSubview:self.haedview];
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    
    
    
}
-(void)MakeViewOfHead{

    _Headscroll.frame=CGRectMake(0, 0, 320, 200);
    for (int i=0; i<20; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0+40*i, 0+40*i/6, 30,30);
        btn.tag=800+i;
        [btn setBackgroundImage:[UIImage imageNamed:@"UMS_sina_icon.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(SElectimage:) forControlEvents:UIControlEventTouchUpInside];
        [_Headscroll addSubview:btn];
    }
    

}

-(void)SElectimage:(UIButton*)sender{
    [_head_imagebut setBackgroundImage:[UIImage imageNamed:@"UMS_sina_icon.png"] forState:UIControlStateNormal];
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";      ///////吸收
    animation.subtype = kCATransitionFromRight;     ///////从右开始
    
    self.haedview.hidden=YES;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

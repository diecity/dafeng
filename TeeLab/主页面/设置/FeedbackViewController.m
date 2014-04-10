//
//  FeedbackViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-10.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UIHelper.h"
@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
    self.title=@"意见反馈";
    // Do any additional setup after loading the view from its nib.
//    _feedbackcuston.layer.masksToBounds = YES;
//    _feedbackcuston.layer.cornerRadius = 4.0;
//    _feedbackcuston.layer.borderWidth = 1.0;
//    _feedbackcuston.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}
- (IBAction)feedbackbutton:(UIButton *)sender {
    
    NSString *str=_feedbackcuston.text;
    [UIHelper alertWithTitle:@"你的反馈信息是" andMSG:str ];
//    [UIHelper alertWithTitle:@"反馈信息已发送，谢谢！"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

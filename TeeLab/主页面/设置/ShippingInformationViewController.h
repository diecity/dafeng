//
//  ShippingInformationViewController.h
//  TeeLab
//
//  Created by teelab2 on 14-4-8.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShippingInformationViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView             *_rootTableView;
    NSMutableArray                 *Arr_Information;


}
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *Youbian;
@property (weak, nonatomic) IBOutlet UIView *root_view;
@property (weak, nonatomic) IBOutlet UITextView *Address_textview;

@property (assign, nonatomic)  NSInteger * interger;
@property (weak, nonatomic)  NSString * AddOrEdit;
@property (assign, nonatomic)  int * deault;

@property (weak, nonatomic) IBOutlet UIButton *editing;
@property (weak, nonatomic) IBOutlet UIButton *selectbutton;

@end

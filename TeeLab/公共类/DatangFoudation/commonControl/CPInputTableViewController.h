//
//  InsuredInfoInputViewController.h
//  DTC_YGJT
//
//  Created by feng gang on 12-4-12.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTGlobal.h"
@interface CPInputTableViewController :  UITableViewController<UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate >{
    
}

@property (assign,nonatomic) id delegate; //修改用户 信息时,用户点击确定后需要用到
@property (assign) SEL didFinishedModify; //修改用户 信息时,用户点击确定后需要用到


@property (retain, nonatomic) NSArray *userInputListArray; //用户输入的界面数据
@property (nonatomic, retain) UITextField *preActiveField;

@property (nonatomic, retain) NSDictionary *dataSource; //用于生成界面
@property (nonatomic, retain) NSDictionary *allUsrInputDic; //保存最开始生成的所有输入框

//统计时,需要知道该类的作用
@property (retain, nonatomic) NSString *describe;

@property (retain, nonatomic) NSString *dataFileName; //用于生成界面的文件名称

//初始化数据
-(void)initTableViewDataSource;

//初始化用户输入框界面
- (void)initUserInputView;

//生成输入框
-(UITextField *)createTextField:(CGRect)frame placeHolder:(NSString*)placeHolder tag:(NSInteger)tag;

//取得item中的控件
- (UIControl *)itemControlWithTag:(NSInteger)tag;

@end

//
//  CPSingleSelectTextField.h
//  DTC_YGJT
//
//  Created by feng gang on 12-5-23.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSingleSelectTextField : UITextField <UITextFieldDelegate>

@property (nonatomic,retain) NSArray* selectArray;
@property (nonatomic,assign) NSInteger selectedRow;
@property (nonatomic,retain) NSString* selectedID;

@property (nonatomic,assign) id selectDelegate;
@property (nonatomic,assign) SEL didFinishedSelect;

- (UIView*)findFirstResponderInView:(UIView*)topView ;

-(void)showCitySelectedPickerView;
//用于初始化时,初始化选择项的初始数据和初始行数
-(NSInteger)indexOfStringInArray:(NSString *)_selectedID;
//初始化text用,如果初始化的text不在列表中,则不予以显示
-(void)setContentText:(NSString *)_selectedID;
@end

//
//  DTSinglePickerView.h
//  DTC_YGJT
//
//  Created by feng gang on 12-4-11.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPSinglePickerView : UIView <UIPickerViewDataSource ,UIPickerViewDelegate>


@property (nonatomic, retain) UIPickerView *singleSelectPickerView;
@property (nonatomic, retain) NSArray *pickerData;
@property (nonatomic, retain) UITextField *activeField;

@property (assign) SEL didFinishSelect;
@property (assign, nonatomic) id delegate;

- (void) addSubPickerView;
-(void)  btnCloseClick;
//初始化数组
- (void) initComponent:(NSInteger)row activedField:(UITextField *)_textField pickerArray:(NSArray *)_pickerArray delegate:(id)_dele didFinishSelect:(SEL)_didFinishSelect;

-(void)dismiss;
@end

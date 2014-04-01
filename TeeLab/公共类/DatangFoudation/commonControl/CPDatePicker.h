//
//  CPDatePicker.h
//  
//
//  Created by feng gang on 12-4-27.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////
// 日期选择控件
// （组合控件）
@interface CPDatePicker : UIControl {
    UITextField     *_textField;
    UIView          *_pickerBgView;
    UIDatePicker    *_datePicker;

    UIDatePickerMode    _datePickerMode;
    NSDate      *_date;
    NSString    *_format;
}

@property(nonatomic, retain) UITextField     *textField;

@property(nonatomic, assign) UIDatePickerMode    datePickerMode;
@property(nonatomic, retain) NSDate      *date;
@property(nonatomic, retain) NSString    *format;

@property(nonatomic, retain) NSDate      *minDate;
@property(nonatomic, retain) NSDate      *maxDate;

@property (assign) SEL didFinishSelect;
@property (assign, nonatomic) id delegate;

- (void)showPicker;
- (UIView*)findFirstResponderInView:(UIView*)topView ;

-(void)setMinDate:(NSDate *)_minDate maxDate:(NSDate *)_maxDate;

@end

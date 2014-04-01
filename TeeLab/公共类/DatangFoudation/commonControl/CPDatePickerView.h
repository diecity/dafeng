//
//  CPDatePickerView.h
//  DTC_YGJT
//
//  Created by feng gang on 12-4-16.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPDatePickerView : UIView <UIPickerViewDelegate>


@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UITextField *activeField;

@property (assign) SEL didFinishSelect;
@property (nonatomic, assign) id delegate;

- (void) addSubPickerView;
-(void)  btnCloseClick;
- (void) initComponent:(NSDate *)date activedField:(UITextField *)_textField delegate:(id)_dele didFinishSelect:(SEL)_didFinishSelect;
-(void)setMinAndMaxDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;
-(void)dismiss;
@end


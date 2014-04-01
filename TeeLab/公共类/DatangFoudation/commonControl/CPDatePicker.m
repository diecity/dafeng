//
//  CPDatePicker.m
//  
//
//  Created by feng gang on 12-4-27.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPDatePicker.h"

////////////////////////////////////////////////////////
// 日期选择控件
// （组合控件）

@interface CPDatePicker (PrivateMethods)

- (void)innerInitWithFrame:(CGRect)frame;

@end
#import "CPDatePickerView.h"
@implementation CPDatePicker



@synthesize textField = _textField;
@synthesize datePickerMode = _datePickerMode;
@synthesize date = _date;
@synthesize format = _format;
@synthesize delegate;
@synthesize didFinishSelect ,maxDate ,minDate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
        [self innerInitWithFrame:CGRectMake(0, 0, 140, 31)];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self innerInitWithFrame:frame];
    }
    return self;
}

- (void)innerInitWithFrame:(CGRect)frame
{
    self.frame = frame;
    self.date = [NSDate date];
    _datePickerMode = UIDatePickerModeDate;
    _format = @"yyyy-MM-dd";
    self.backgroundColor = [UIColor clearColor];

    // create text field:显示日期
    static const int interval = 10;
    CGRect subFrame = TTRectInset(self.bounds, UIEdgeInsetsMake(0, 0, 0, self.bounds.size.height + interval));
    UITextField* textField = [[[UITextField alloc] initWithFrame:subFrame] autorelease];
//    textField.backgroundColor = TTSTYLEVAR(backgroundColor);
//    textField.font = TTSTYLEVAR(formFieldFont);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.enabled = NO;
    self.textField = textField;
//    self.textField.placeholder = @"点击选择日期";
    [self addSubview:_textField];
    // 将当前日期显示到textField
//    [self updateTextField];
    
    // create right view:图标
    UIImage *img = [UIImage imageNamed:@"日历图标.png"];
    UIImageView *imgView = [[[UIImageView alloc] initWithImage:img] autorelease];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    subFrame = TTRectInset(self.bounds, UIEdgeInsetsMake(0, self.bounds.size.width - self.bounds.size.height, 0, 0));
    imgView.frame = subFrame;
    [self addSubview:imgView];
    
    // 添加点击响应（点击弹出datePicker）
    [self addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc
{
    [_textField release];
    [_pickerBgView release];
    [_datePicker release];
    [_date release];
    [_format release];
    [maxDate release];
    [minDate release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showPicker
{
    UIView *window = [UIApplication sharedApplication].delegate.window;
    //消除键盘
    UIView *firstResponder = [self findFirstResponderInView:window];
    [firstResponder resignFirstResponder];
    
    // find root view
    UIView *rootView = self;
    while (rootView.superview != nil) {
        rootView = rootView.superview;
    }
    
    CPDatePickerView *datepv = [[[CPDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    NSDateFormatter *nsdf = [[[NSDateFormatter alloc] init] autorelease];
    [nsdf setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = self.textField.text;
    
    //如果输入框为空,则显示当前日期
    if (dateString && ![dateString isEqualToString:@""]) {
        self.date = [nsdf dateFromString:dateString];
    }else{
        //如果设置了最小日期,则默认显示最小日期
        if (minDate) {
            self.date =minDate;
        }else{
            self.date =[NSDate date];
        }
    }
    //初始化一些参数
    [datepv initComponent:self.date activedField:self.textField delegate:self didFinishSelect:@selector(didFinishSelect:dictionary:)];
    [datepv setMinAndMaxDate:self.minDate maxDate:self.maxDate];
    [rootView addSubview:datepv];
}

// pickerView 选择完成后,回调
- (void)didFinishSelect:(UITextField *)textField dictionary:(NSDictionary *)dic 
{
    if (delegate && [delegate respondsToSelector:didFinishSelect]) {
        [delegate performSelector:didFinishSelect withObject:self];
    }
}

-(void)setMinDate:(NSDate *)_minDate maxDate:(NSDate *)_maxDate{
    if (_minDate != nil) {
        self.minDate = _minDate;
//        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
//        formatter.dateFormat = _format;
//        NSString *text = [formatter stringFromDate:minDate];
//        
//        self.textField.text = text; 
    } 
    if (_maxDate != nil) {
        self.maxDate = _maxDate; 
    }
}

//获得第一响应者,用于消除键盘
///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)findFirstResponderInView:(UIView*)topView {
    if ([topView isFirstResponder]) {
        return topView;
    }
    
    for (UIView* subView in topView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        
        UIView* firstResponderCheck = [self findFirstResponderInView:subView];
        if (nil != firstResponderCheck) {
            return firstResponderCheck;
        }
    }
    return nil;
}


@end

//
//  CPDatePickerView.m
//  DTC_YGJT
//
//  Created by feng gang on 12-4-16.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPDatePickerView.h"

@implementation CPDatePickerView

@synthesize datePicker  ,activeField ,delegate ,didFinishSelect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //[self addSubPickerView];
    }
    
    return self;
}

- (id)init
{
    self = [self initWithFrame:CGRectMake(0, 0, 320, 416)];
    
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self btnCloseClick];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void) addSubPickerView{
    //构建一个pickerview
    // find root view
    UIView *rootView = self;
    while (rootView.superview != nil) {
        rootView = rootView.superview;
    }
    
    self.datePicker = [[[UIDatePicker alloc] initWithFrame:rootView.bounds] autorelease];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    datePicker.frame = CGRectOffset(datePicker.frame, 0, rootView.frame.size.height - datePicker.frame.size.height);
    //添加灰色背景
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    //为子试图构造工具栏按钮
	UIBarButtonItem *item = [[[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleBordered target:self action:@selector(btnCloseClick)]autorelease];
	
    UIBarButtonItem *itemSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
	UIBarButtonItem *itemCancel = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnClicked)] autorelease];
    
	NSArray *buttons = [NSArray arrayWithObjects:itemCancel, itemSpace, item, nil];
    
	CGRect frame = [datePicker frame];
    CGFloat height = 44;
	//为子视图构造工具栏
	UIToolbar *subToolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y - height, frame.size.width, height)];
    
	subToolbar.barStyle = UIBarStyleBlackTranslucent;  
	[subToolbar sizeToFit];
	[subToolbar setItems:buttons animated:YES]; //把按钮加入工具栏 
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        subToolbar.alpha = 0;
        datePicker.alpha = 0;
        
        [self addSubview:subToolbar];//把工具栏加入子视图
        [self addSubview:datePicker]; //把pickerView加入子视图
        subToolbar.alpha = 1;
        datePicker.alpha = 1;
    } completion:^(BOOL finished)
     {
         
     }];
	[subToolbar release];
}

- (void) initComponent:(NSDate *)date activedField:(UITextField *)_textField delegate:(id)_dele didFinishSelect:(SEL)_didFinishSelect{
    
    self.activeField = _textField;
    self.delegate    = _dele;
    self.didFinishSelect = _didFinishSelect;
    
    [self addSubPickerView];
    if (date != nil) {
        [datePicker setDate:date];
    }
}

-(void)setMinAndMaxDate:(NSDate *)minDate maxDate:(NSDate *)maxDate{
    if (minDate != nil) {
        datePicker.minimumDate = minDate; 
    } 
    if (maxDate != nil) {
        datePicker.maximumDate = maxDate; 
    }
}

//完成按钮点击时触发
-(void)btnCloseClick{
    NSDateFormatter *nsdf = [[[NSDateFormatter alloc] init] autorelease];
    [nsdf setDateStyle:NSDateFormatterShortStyle];
    NSLocale *local = [[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] autorelease];
    [nsdf setLocale:local];//location设置为中国
	[nsdf setDateFormat:@"yyyy-MM-dd"];
    DLog(@"%@", [datePicker date]);
    activeField.text = [nsdf stringFromDate:[datePicker date]];
    
    [self dismiss];
    
    NSString *str = [NSString stringWithFormat:@"%i",1];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         str ,@"selectedRow",                                    nil];
    if (delegate && [delegate respondsToSelector:didFinishSelect]) {
        [delegate performSelector:didFinishSelect withObject:activeField withObject:dic];
    }
}


-(void)cancelBtnClicked{
    [self dismiss];
}

-(void)dismiss{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; 
    
    [self setAlpha:0];
    [UIView commitAnimations];
    
    [self performSelector:@selector(animationDidStop) withObject:nil afterDelay:0.3];
}

- (void) animationDidStop{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

-(void)dealloc{
    [datePicker release];
    [activeField release];
}

@end

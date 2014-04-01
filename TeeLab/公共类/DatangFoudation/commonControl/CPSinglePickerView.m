//
//  DTSinglePickerView.m
//  DTC_YGJT
//
//  Created by feng gang on 12-4-11.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPSinglePickerView.h"

@implementation CPSinglePickerView

@synthesize singleSelectPickerView ,pickerData ,activeField ,delegate ,didFinishSelect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //构建一个pickerview
        //self.singleSelectPickerView = [[[UIPickerView alloc] initWithFrame:frame]autorelease];
        
        //[self addSubPickerView];
    }
    
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
    
    self.singleSelectPickerView = [[[UIPickerView alloc] initWithFrame:self.bounds] autorelease];
	singleSelectPickerView.delegate = self;
	singleSelectPickerView.dataSource = self;
	singleSelectPickerView.showsSelectionIndicator = YES;
    
    singleSelectPickerView.frame = CGRectOffset(singleSelectPickerView.frame, 0, self.frame.size.height - singleSelectPickerView.frame.size.height);
    
	//为子试图构造工具栏按钮
	UIBarButtonItem *item = [[[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleBordered target:self action:@selector(btnCloseClick)]autorelease];
	
    UIBarButtonItem *itemSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
	UIBarButtonItem *itemCancel = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnClicked)] autorelease];
    
	NSArray *buttons = [NSArray arrayWithObjects:itemCancel, itemSpace, item, nil];
    
    //添加灰色背景
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
	CGRect frame = [singleSelectPickerView frame];
    CGFloat height = 44;
	//为子视图构造工具栏
	UIToolbar *subToolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y - height, frame.size.width, height)];
	subToolbar.barStyle = UIBarStyleBlackTranslucent;  
	[subToolbar sizeToFit];
	[subToolbar setItems:buttons animated:YES]; //把按钮加入工具栏 
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        subToolbar.alpha = 0;
        singleSelectPickerView.alpha = 0;
        
        [self addSubview:subToolbar];//把工具栏加入子视图
        [self addSubview:singleSelectPickerView]; //把pickerView加入子视图
        subToolbar.alpha = 1;
        singleSelectPickerView.alpha = 1;
    } completion:^(BOOL finished)
     {
         
     }];
	[subToolbar release];
}

- (void) initComponent:(NSInteger)row activedField:(UITextField *)_textField pickerArray:(NSArray *)_pickerArray delegate:(id)_dele didFinishSelect:(SEL)_didFinishSelect{
    self.activeField = _textField;
    self.pickerData  = _pickerArray;
    self.delegate    = _dele;
    self.didFinishSelect = _didFinishSelect;
    [self addSubPickerView];
    [singleSelectPickerView selectRow:row inComponent:0 animated:NO];
}

//完成按钮点击时触发
-(void)btnCloseClick{
    NSUInteger selectedRow = [singleSelectPickerView selectedRowInComponent:0];
    activeField.text = [[pickerData objectAtIndex:selectedRow] objectForKey:@"text"];
    
    NSString *str = [NSString stringWithFormat:@"%i",selectedRow];
    [self dismiss];
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

//返回列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

//返回行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [pickerData count];
}

//返回每行显示内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[pickerData objectAtIndex:row] objectForKey:@"text"];
}

//滚动时的操作
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //activeField.text = [[pickerData objectAtIndex:0] objectAtIndex:row];
}

-(void)dealloc{
    [singleSelectPickerView release];
    [pickerData release];
    [activeField    release];
    [super dealloc];
}

@end

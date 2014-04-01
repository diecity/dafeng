//
//  CPSingleSelectTextField.m
//  DTC_YGJT
//
//  Created by feng gang on 12-5-23.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPSingleSelectTextField.h"
#import "CPSinglePickerView.h"

@implementation CPSingleSelectTextField

@synthesize selectedRow, selectArray, selectedID, selectDelegate, didFinishedSelect;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        //文字居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        self.borderStyle = UITextBorderStyleRoundedRect;
//        self.backgroundColor = [UIColor whiteColor];
//        UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectRightIcon"]] autorelease];
//        self.rightView = imageView;
//        self.rightViewMode = UITextFieldViewModeAlways;
      //  self.background = [UIImage imageNamed:@"selectBg"];
        self.selectedRow = -1;
    }
    return self;
}

//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat left = 5.0;
    CGFloat right = 40.0;
    return CGRectMake( bounds.origin.x + left, bounds.origin.y, bounds.size.width - left - right, bounds.size.height);
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGFloat left = 5.0;
    CGFloat right = 40.0;
    return CGRectMake( bounds.origin.x + left, bounds.origin.y, bounds.size.width - left - right, bounds.size.height);
}

//初始化text用,如果初始化的text不在列表中,则不予以显示
-(void)setContentText:(NSString *)_selectedID{
    //取得选择的行
    NSInteger index = [self indexOfStringInArray:_selectedID];
    if (index != -1) {
        self.selectedRow = index;
        self.selectedID = _selectedID;
        self.text = [[selectArray objectAtIndex:selectedRow] objectForKey:@"text"];
    }
}

//用于初始化时,初始化选择项的初始数据和初始行数
-(NSInteger)indexOfStringInArray:(NSString *)_selectedID{
    for (int i = 0;i< [selectArray count];i++) {
        NSDictionary *dic = [selectArray objectAtIndex:i];
        if ([[dic objectForKey:@"id"] isEqualToString:_selectedID]) {
            return i;
        }
    }
    return -1;
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    UIView *window = [UIApplication sharedApplication].delegate.window;
    //消除键盘
    UIView *firstResponder = [self findFirstResponderInView:window];
    [firstResponder resignFirstResponder];
    
    [self showCitySelectedPickerView];
    return NO;
}

//显示pickerview
-(void)showCitySelectedPickerView{
    
    CPSinglePickerView *pv = [[[CPSinglePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)]autorelease];
    //如果之前没有选择行数的话
    NSInteger cityRow = selectedRow == -1 ? 0 : selectedRow ;
    
    [pv initComponent:cityRow activedField:self pickerArray:selectArray delegate:self didFinishSelect:@selector(didFinishSelect:dictionary:)];
    
    UIView *uiView = [UIApplication sharedApplication].delegate.window;
    [uiView addSubview:pv];
}

//pickerView 选择完成后的回调
-(void)didFinishSelect:(CPSingleSelectTextField *)textField dictionary:(NSDictionary *)dic{
    self.selectedRow = [[dic objectForKey:@"selectedRow"] intValue];
    self.selectedID = [[selectArray objectAtIndex:selectedRow] objectForKey:@"id"];
    if ([selectDelegate respondsToSelector:didFinishedSelect]) {
        NSDictionary *dic = [[[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithInt:self.tag] ,@"tag",
                             self.text ,@"selectedText",
                             selectedID ,@"selectedID",
                             nil] autorelease];
        [selectDelegate performSelector:didFinishedSelect withObject:dic];
    }
}

-(void)dealloc{
    [selectArray 	release];
    [selectedID   release];
    [super dealloc];
}

@end

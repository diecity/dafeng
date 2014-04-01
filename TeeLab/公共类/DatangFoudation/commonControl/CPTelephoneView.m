//
//  CPTelephoneView.m
//  DTC_TK
//
//  Created by feng gang on 12-6-21.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPTelephoneView.h"

@implementation CPTelephoneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat firstWidth = 60;
        CGFloat labelWidth = 20;
        
        // Initialization code
        CGRect frame1 = CGRectMake(0, 0, firstWidth, frame.size.height);
        firstInput = [[self createTextField:frame1 placeHolder:@"010" tag:0] retain];
        frame1 = CGRectMake(firstWidth, 0, labelWidth, frame.size.height);
        [firstInput setDelegate:self];
        [self addSubview:firstInput];
        
        UILabel *label = [[UILabel alloc] initWithFrame:frame1];
        label.text = @"-";
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        [label release];
        
        frame1 = CGRectMake(labelWidth + firstWidth, 0, frame.size.width - labelWidth - firstWidth, frame.size.height);
        secondInput = [[self createTextField:frame1 placeHolder:@"88888888" tag:0] retain];
        [secondInput setDelegate:self];
        [self addSubview:secondInput];
        
    }
    return self;
}

- (NSString *)controlText{
    NSString *text1 = [firstInput text];
    NSString *text2 = [secondInput text];
    if (text1 && ![text1 isEqualToString:@""]) {
        
    }else{
        text1 = @"";
    }
    
    if (text2 && ![text2 isEqualToString:@""]) {
        
    }else{
        text2 = @"";
    }
    
    return [NSString stringWithFormat:@"%@%@",text1,text2];
}

- (NSString *)controlText:(NSString *)key{
    NSArray *array = [key componentsSeparatedByString:@"&"];
    
    NSString *text1 = [firstInput text];
    NSString *text2 = [secondInput text];
    
    if (text1 && ![text1 isEqualToString:@""]) {
        
    }else{
        text1 = @"";
    }
    
    if (text2 && ![text2 isEqualToString:@""]) {
        
    }else{
        text2 = @"";
    }
    
    return [NSString stringWithFormat:@"%@=%@&%@=%@",
                [array objectAtIndex:0],
                text1,
                [array objectAtIndex:1],
                text2];
}

//将生成输入框的代码提取出来
-(UITextField *)createTextField:(CGRect)frame placeHolder:(NSString*)placeHolder tag:(NSInteger)tag{
    //生成输入框
    UITextField *textField = [[[UITextField alloc]initWithFrame:frame] autorelease];
    textField.borderStyle = UITextBorderStyleNone;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.placeholder = placeHolder;
    textField.tag = tag;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.background = [UIImage imageNamed:@"textfieldBg"];
    //文字右边距
    CGFloat width = 5;
    
    frame.origin.x = textField.frame.origin.x + (textField.frame.size.width - 2*width);
    frame.size.width = width;
    UIView *rightView = [[UIView alloc] initWithFrame:frame];
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightView = rightView;
    [rightView release];
    
    //设置文字左边距
    frame.origin.x = textField.frame.origin.x;
    UIView *leftView = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftView;
    [leftView release];
    
    //当编辑时,出现x删除按钮
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(firstInput);
    TT_RELEASE_SAFELY(secondInput);
    [super dealloc];
}


#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

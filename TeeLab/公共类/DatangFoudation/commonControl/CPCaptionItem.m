//
//  CPCaptionItem.m
//  DTC_YGJT
//
//  Created by feng gang on 12-5-23.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPCaptionItem.h"
#import "CPSingleSelectTextField.h"
#import "CPDatePicker.h"
#import "CPSegmentedControl.h"
#import "CPTelephoneView.h"

@implementation CPCaptionItem

@synthesize captionText, control, tag, controlName, alertText;

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithCaption:(NSString*)caption control:(UIControl*)control {
    CPCaptionItem* item = [[[self alloc] init] autorelease];
    item.captionText = caption;
    item.control = control;
    return item;
}

-(NSString *)controlText{
    //返回控件的值,统一在这里面进行处理,再在外面循环判断该值返回的是否为空.
    if([control isKindOfClass:[CPSingleSelectTextField class]]){
        //如果是单选控件
        CPSingleSelectTextField *tf = (CPSingleSelectTextField *)self.control;
        NSString *string = tf.text;
        if (![string isEqualToString:@""] && string) { //如果text的值不为空,则直接返回拼接后的值
            NSString *str = [[[NSString alloc] initWithFormat:@"%@=%@&",self.controlName,tf.selectedID] autorelease];
            return str;
        }
    }else if ([control isKindOfClass:[UITextField class]]) {
        //普通输入框
        UITextField *tf = (UITextField *)self.control;
        NSString *string = tf.text;
        if (![string isEqualToString:@""] && string) { //如果text的值不为空,则直接返回拼接后的值
            NSString *str = [[[NSString alloc] initWithFormat:@"%@=%@&",self.controlName,tf.text] autorelease];
            return str;
        }
    }else if ([control isKindOfClass:[CPDatePicker class]]) {
        //如果是日期选择框
        CPDatePicker *cp = (CPDatePicker *)self.control;
        NSString *string = cp.textField.text;
        
        if (![string isEqualToString:@""] && string) { //如果text的值不为空,则直接返回拼接后的值
            NSString *str = [[[NSString alloc] initWithFormat:@"%@=%@&",self.controlName,cp.textField.text] autorelease];
            return str;
        }
    }else if ([control isKindOfClass:[CPSegmentedControl class]]) {
        //如果是segment选择框
        CPSegmentedControl *cp = (CPSegmentedControl *)self.control;
        NSString *string = cp.selectedID;
        
        if (![string isEqualToString:@""] && string) { //如果text的值不为空,则直接返回拼接后的值
            NSString *str = [[[NSString alloc] initWithFormat:@"%@=%@&",self.controlName,string] autorelease];
            return str;
        }
    }else if ([control isKindOfClass:[CPTelephoneView class]]) {
        //如果是电话 号
        CPTelephoneView *cp = (CPTelephoneView *)self.control;
        NSString *string = [cp controlText];
        
        if (![string isEqualToString:@""] && string) { //如果text的值不为空,则直接返回拼接后的值
            NSString *str = [[[NSString alloc] initWithFormat:@"%@&",[cp controlText:self.controlName]] autorelease];
            return str;
        }
    }
    return @"";
}

-(NSString *)itemControlValue{
    //返回控件的值,统一在这里面进行处理,再在外面循环判断该值返回的是否为空.
    if([control isKindOfClass:[CPSingleSelectTextField class]]){
        //如果是单选控件
        CPSingleSelectTextField *tf = (CPSingleSelectTextField *)self.control;
        NSString *string = tf.text;
        return string;
    }else if ([control isKindOfClass:[UITextField class]]) {
        //普通输入框
        UITextField *tf = (UITextField *)self.control;
        NSString *string = tf.text;
        return string;
    }else if ([control isKindOfClass:[CPDatePicker class]]) {
        //如果是日期选择框
        CPDatePicker *cp = (CPDatePicker *)self.control;
        NSString *string = cp.textField.text;
        return string;
    }else if ([control isKindOfClass:[CPSegmentedControl class]]) {
        //如果是segment选择框
        CPSegmentedControl *cp = (CPSegmentedControl *)self.control;
        NSString *string = cp.selectedID;
        return string;
    }else if ([control isKindOfClass:[CPTelephoneView class]]) {
        //如果是电话号
        CPTelephoneView *cp = (CPTelephoneView *)self.control;
        NSString *string = [cp controlText];
        
        return string;
    }
    return @"";
}

- (void)initControlText:(NSString *)text{
    
    if ([text isEqualToString:@""] || !text) {
        return;
    }
    //返回控件的值,统一在这里面进行处理,再在外面循环判断该值返回的是否为空.
    if([control isKindOfClass:[CPSingleSelectTextField class]]){
        //如果是单选控件
        CPSingleSelectTextField *tf = (CPSingleSelectTextField *)self.control;
        [tf setContentText:text];
    }else if ([control isKindOfClass:[UITextField class]]) {
        //普通输入框
        UITextField *tf = (UITextField *)self.control;
        tf.text = text;
    }else if ([control isKindOfClass:[CPDatePicker class]]) {
        //如果是日期选择框
        CPDatePicker *cp = (CPDatePicker *)self.control;
        //初始化日期的值
        cp.textField.text = text;
    }else if ([control isKindOfClass:[CPSegmentedControl class]]) {
        //如果是segment选择框
        CPSegmentedControl *cp = (CPSegmentedControl *)self.control;
        
        //通过传递过来的id来确定初始化的值
        [cp setSegmentSelectedIndexWithID:text];
    }
}

-(void)dealloc{
    TT_RELEASE_SAFELY(captionText);
    TT_RELEASE_SAFELY(control);
    TT_RELEASE_SAFELY(controlName);
    TT_RELEASE_SAFELY(alertText);
    [super dealloc];
}
@end

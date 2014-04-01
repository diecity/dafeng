//
//  CPTelephoneView.h
//  DTC_TK
//
//  Created by feng gang on 12-6-21.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPTelephoneView : UIControl <UITextFieldDelegate>{
    UITextField *firstInput;
    UITextField *secondInput;
}

//只取两个输入框的值,然后合并
- (NSString *)controlText;

//将两个输入框的key值发过来,生成key&value形式的字段
- (NSString *)controlText:(NSString *)key;

-(UITextField *)createTextField:(CGRect)frame placeHolder:(NSString*)placeHolder tag:(NSInteger)tag;

@end

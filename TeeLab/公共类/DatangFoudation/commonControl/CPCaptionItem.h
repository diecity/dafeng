//
//  CPCaptionItem.h
//  DTC_YGJT
//
//  Created by feng gang on 12-5-23.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPCaptionItem : NSObject

@property (nonatomic,retain) NSString *captionText;
@property (nonatomic,retain) UIControl *control;
@property (nonatomic,assign) NSInteger tag;

@property (nonatomic,retain) NSString *controlName; //控件的name属性,post数据时候的key
@property (nonatomic,retain) NSString *alertText;

+ (id)itemWithCaption:(NSString*)caption control:(UIControl*)control;

//得到uicontrol输入框的值(包括key&value)
- (NSString *)controlText;

//初始化control的值
- (void)initControlText:(NSString *)text;
////得到uicontrol输入框的值(只包括value)
-(NSString *)itemControlValue;


@end

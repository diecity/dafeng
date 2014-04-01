//
//  CPSegmentedControl.h
//  DTC_YGJT
//
//  Created by feng gang on 12-5-24.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSegmentedControl : UISegmentedControl

@property (retain, nonatomic) NSArray *segmentItems;
@property (retain, nonatomic) NSString *selectedID;

-(id)initWithCPItems:(NSArray *)items;
//根据text初始化
-(void)setSegmentSelectedIndexWithText:(NSString *)text;
//通过id初始化
-(void)setSegmentSelectedIndexWithID:(NSString *)segID;

@end

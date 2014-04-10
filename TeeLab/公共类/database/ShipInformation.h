//
//  ShipInformation.h
//  TeeLab
//
//  Created by teelab2 on 14-4-9.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipInformation : NSObject

@property (nonatomic, retain)    NSString               *userName;//用户名
@property (nonatomic, retain)    NSString               *postcode;//邮编
@property (nonatomic, retain)    NSString               *deault;//是否为默认配送地址 0 否  、1 是
@property (nonatomic, retain)    NSString               *phoneNum;//电话号码
@property (nonatomic, retain)    NSString               *postAddr;//通讯地址
@property (nonatomic, retain)    NSString               *mark;//标记

@end

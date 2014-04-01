//
//  DTGlobalVariableManager.h
//  DTC_TK
//
//  Created by feng gang on 12-6-15.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTGlobalVariableManager : NSObject

@property (retain, nonatomic) NSString *loginSessionID;
@property (retain, nonatomic) NSOperationQueue *operationQueue;

+ (DTGlobalVariableManager *)shareApplication;

@end

//
//  DTGlobalVariableManager.m
//  DTC_TK
//
//  Created by feng gang on 12-6-15.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "DTGlobalVariableManager.h"

@implementation DTGlobalVariableManager

@synthesize loginSessionID,operationQueue;

+ (DTGlobalVariableManager *)shareApplication{
    static DTGlobalVariableManager *dvm = nil;
    if (!dvm) {
        dvm = [[DTGlobalVariableManager alloc] init];
        dvm.loginSessionID = @"";
    }
    return dvm;
}

- (void)dealloc{
    [loginSessionID release];
    [operationQueue release];
    [super dealloc];
}

+ (void)dealloc{
    [super dealloc];
}

@end

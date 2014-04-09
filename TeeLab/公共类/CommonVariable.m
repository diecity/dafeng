//
//  CommonVariable.m
//  tp_self_help
//
//  Created by cloudpower on 13-7-22.
//  Copyright (c) 2013年 cloudpower. All rights reserved.
//

#import "CommonVariable.h"
static CommonVariable *commVari = nil;
@implementation CommonVariable


- (id)init{
    if (self = [super init]) {
        _isLogin = NO;
        _userInfoo = nil;
        _userInfoStr = nil;
        
        
        _simulateCheckPhotos = [[NSMutableArray alloc] initWithCapacity:0];
        
        _caseTel = @"";
    
        //设置默认地址和地址类型
        _addrType = 1;
        NSString *baiduID = [[[NSBundle mainBundle] infoDictionary ] objectForKey:(NSString*)kCFBundleIdentifierKey ];
//        if ([baiduID isEqualToString:@"com.dtcloud.taiPingPush"])
//        {
//          //  [[[NSBundle mainBundle] infoDictionary ] setValue:@"E路太平测试" forKey:(BSS)kCFBundleExecutableKey];
//            _serverAddr     = @"http://221.4.104.222:5505/MobileBus/bus/json/";
//            
//        }
//        else
//        {
//            _serverAddr = @"http://customer.tpi.cntaiping.com:8006/MobileBus/bus/json/";
//        }
        
         _serverAddr     = @"http://221.4.104.222:5505/MobileBus/bus/json/";
        
        //_serverAddr     = @"http://221.4.104.222:5505/MobileBus/bus/json/";
       /*
        _curLocalAddr       = @"http://10.8.44.185:8080/MobileBus/bus/json/";
        _curDefaultAddr     = @"http://10.0.96.203:6083/MobileBus/bus/json/";
        _curDianXinAddr     = @"http://121.35.249.120:5505/MobileBus/bus/json/";
        _curLianTongAddr    = @"http://221.4.104.222:5505/MobileBus/bus/json/";*/
    }
    return self;
}


/**************************************************************
 ** 功能:     获取单例
 ** 参数:     无
 ** 返回:     commonvariable对象
 **************************************************************/
+ (id)shareCommonVariable{
    if (!commVari) {
        commVari = [[CommonVariable alloc] init];
    }
    return commVari;
}
@end

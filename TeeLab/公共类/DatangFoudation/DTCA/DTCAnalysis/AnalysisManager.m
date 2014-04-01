/******************************************************
 * 模块名称:   AnalysisManager.m
 * 模块功能:   统计分析 接口逻辑实现模块
 * 创建日期:   2012-09-27
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/


#import "AnalysisConfig.h"
#import "AnalysisManager.h"
#import "AnalysisDataModels.h"
//#import "AnalysisDataModelsHelper.h"

#import "ASIHTTPRequest.h"
#import "NSDataAdditions.h"

#import "SBJson.h"
#import "CommonFunc.h"
// 联网方式
#import "Reachability.h"  



@implementation AnalysisManager

@synthesize appKey                 = _appKey;
@synthesize appName                = _appName;
@synthesize appVersion             = _appVersion;
@synthesize appPackgeName          = _appPackgeName;
@synthesize appChannelId           = _appChannelId;
@synthesize appChannelName         = _appChannelName;

@synthesize curDataModel           = _curDataModel;
@synthesize curLaunch              = _curLaunch;

@synthesize curEnterViewTimer      = _curEnterViewTimer;
@synthesize curEnterViewName       = _curEnterViewName;
@synthesize sessionId              = _sessionId;
@synthesize upLoadType             = _upLoadType;
@synthesize urlSubString           = _urlSubString;
@synthesize curSubDataModel        = _curSubDataModel;

@synthesize uploadAnalysis         = _uploadAnalysis;
#pragma mark life cycle

/******************************************************
 ** 功能:     生成sharedManager实例
 ** 参数:     无
 ** 返回:     sharedManager实例
 ** 备注:     如已经生成将不会生成，       
 ******************************************************/
+ (AnalysisManager *)sharedManager {
    static AnalysisManager *obj = nil;
       if (obj == nil) {
        obj = [[AnalysisManager alloc] init];
    }
    
    return obj;
}

- (id)init {
    if (self = [super init]) {
        NSLog(@"AnalysisManager->init");
        _curDataModel = [[AnalysisDataModel alloc] init];
        _upLoadType = AnalysisUpLoadType_Lanuch;           // 默认启动发送
        //_upLoadType =  AnalysisUpLoadType_Immediately;
        _pageOrder = 0;
        
        _location= [[Location alloc]init];                 // 位置信息实例
        
        _uploadAnalysis = [[AnalysisUpLoad alloc] init];   
        [_uploadAnalysis setRequestUpLoadTypeCallback:^(bool isSave, NSInteger ploy) {
            _upLoadType = ploy;
             NSLog(@"AnalysisManager->ploy = %d", ploy);
            if(isSave == YES) {
                [AnalysisManager setUpLoadType:ploy];
            }
        }];
        // 子服务器
        _urlSubString  = [[NSMutableArray alloc]init];
        
        _analysisUpLoadSub = [[AnalysisUpLoadSub alloc] init];
        _curSubDataModel =  [[AnalysisDataModel alloc] init];
        
    }
    return self;
}

- (void)dealloc {
    [_appPackgeName release];
    [_appChannelId release];
    [_appVersion release];
    [_appKey release];
    [_appName release];
    [_appChannelName release];
    
    [_uploadAnalysis release];
    [_curDataModel release];
    [_curLaunch release];
    [_curEnterViewTimer release];
    [_curEnterViewName release];
    [_sessionId release];
    
    [_location release];
     // 子服务器
    [_analysisUpLoadSub release];
    [_curSubDataModel release];
    [_urlSubString release];
    [super dealloc];
}
/******************************************************
 ** 功能:     判断是否是实时上传数据  添加并上传
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)immediatelyUpLoad {
    if(self.upLoadType == AnalysisUpLoadType_Immediately) {
        if([_uploadAnalysis addUpLoaData:self.curDataModel] == YES) { 
            self.curDataModel = [self genDataAnalysis];       // 舍去当前的
            self.curDataModel.launch = self.curLaunch;        // 用之前的Launch
        }
    }
}
#pragma mark 响应操作

/******************************************************
 ** 功能:     启动应用
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)appLaunched {

    NSLog(@"AnalysisManager->appLaunched");
    AnalysisDataModel_Array *cpaDataAnalysis = nil;
    // 把保存数据取出来
    NSString *data = [AnalysisManager getAnalysisData];
    
    if (data != nil) {
        NSLog(@"AnalysisManager->appLaunched:have data ");
        SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
        id jsonObj = [parser objectWithString:data];
        if (jsonObj != nil) {
            cpaDataAnalysis = [AnalysisDataModel_Array fromJsonObject:jsonObj];
            if (cpaDataAnalysis != nil) {
                NSLog(@"AnalysisManager->appLaunched:need upload ");
            _uploadAnalysis.analysisDataModel_UnLaod = cpaDataAnalysis;
                [_uploadAnalysis startUpLoadAnalysis];  // 启动上传
            }
        }
    } 
 
    self.upLoadType = [AnalysisManager getUpLoadType];
    self.sessionId = [self generateSessionId ];
    _pageOrder = 0;                                      //启动清零
    // 生产一个
    self.curDataModel = [self genDataAnalysis];

    self.curLaunch = self.curDataModel.launch;       // 临时保存 稍后会加位置信息
    // 启动定位
    [_location  startLocation: ^() {
        // 取出定位信息
        self.curLaunch.longitude = _location.strLng;
        self.curLaunch.latitude = _location.strLat;
        self.curLaunch.launchRegion = _location.city;
        self.curLaunch.country = _location.country;
        //------这里写一下经纬度---缓存起来 ，dujw
        //  NSLog(@"%@",self.strLat);
        
           [[CommonFunc shareCommonFunc] setCurLongitude:_location.strLng];
         [[CommonFunc shareCommonFunc] setCurLatitude:_location.strLat];
         [[CommonFunc shareCommonFunc] setCurCity:_location.city];
        [_location stopLocation];
        
    }];

    // 启动策略申请
    [_uploadAnalysis startRequestUpLoadType: self.appKey];
    // 判断是否上传数据  添加并上传
    [ self immediatelyUpLoad];
    // 启动子服务器去下载
    if([self.urlSubString count] > 0) {
        [_analysisUpLoadSub appLaunched];
        self.curSubDataModel =  [self genDataAnalysis];
    }

}

/******************************************************
 ** 功能:     退出应用
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)appTerminated {

    // 加上时长
    NSLog(@"AnalysisManager->appTerminated");
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *launchTime = [formatter dateFromString:_curLaunch.launchTime];
    
    NSDate *timeOnExitLaunch = [NSDate date];
    NSTimeInterval duration = [timeOnExitLaunch timeIntervalSinceDate:launchTime];
    _curLaunch.launchLength = [NSString stringWithFormat:@"%d", (int)duration];

    [_uploadAnalysis.analysisDataModel_UnLaod.analysisDataModel addObject: _curDataModel];  // 

    // 将本次的统计数据放入用户存储中
    id jsonObj = [_uploadAnalysis.analysisDataModel_UnLaod toJsonObject];

    SBJsonWriter *writer = [[[SBJsonWriter alloc] init] autorelease];
    NSString *data = [writer stringWithObject:jsonObj];
    [AnalysisManager saveAnalysisData:data];

    // 子服务器处理
    if([self.urlSubString count] > 0) {
        _curSubDataModel.launch =  self.curLaunch;
        [_analysisUpLoadSub appTerminated:_curSubDataModel subUrl:_urlSubString]; // 保存所有数据
    }

}

/******************************************************
 ** 功能:     后台转入前台
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)applicationWillEnterForeground
{
     NSLog(@"AnalysisManager->applicationWillEnterForeground");
    [self appLaunched];
    [self enterView: _curEnterViewName];    //后台转前台不会调用进入VIEW
}

/******************************************************
 ** 功能:     进入后台运行
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)applicationDidEnterBackground
{
    NSLog(@"AnalysisManager->applicationDidEnterBackground");
    // 转入后台不会调用退出view手动调一下啊
    if (_curEnterViewName != nil) {
        [self exitView];
    }
    [self appTerminated];
    
}


/******************************************************
 ** 功能:     进入页面
 ** 参数:     name  ----  页面名称
 ** 返回:     无
 ******************************************************/
- (void)enterView:(NSString *)name {
    self.curEnterViewTimer = [NSDate date];
    self.curEnterViewName = name;
    NSLog(@"AnalysisManager->enterView = %@",name);
    if (self.upLoadType  == AnalysisUpLoadType_Immediately) {   // 实时发送数据 进入也要记录
        _pageOrder++;
        AnalysisDataModel_Visit *visit = [ self genVisit];
        [_curDataModel.visit addObject: visit];
    } else {
        _pageOrder++;
    }
    
    
    // 判断是否上传数据  添加并上传
    [ self immediatelyUpLoad]; 

}

/******************************************************
 ** 功能:     退出页面
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void) exitView {
    NSLog(@"AnalysisManager->exitView ");
    if (_curEnterViewTimer == nil || _curEnterViewName == nil) goto out; 
    if(_curDataModel == nil)  goto out; 

    AnalysisDataModel_Visit *visit = [ self genVisit];
   
    if(_curDataModel == nil)  goto out; 
    
    [_curDataModel.visit addObject: visit];
    if([self.urlSubString count] > 0) {
        [_curSubDataModel.visit addObject: visit];  // 保存子服务
    }
    out:
    
    // 判断是否上传数据  添加并上传
   [ self immediatelyUpLoad];
}

/******************************************************
 ** 功能:     统计事件
 ** 参数:     eventId  --- 事件ID
 **           name    ---- 事件名称
 ** 返回:     无
 ******************************************************/
- (void)event:(NSString *)eventId eventName:(NSString*)name {
    
    if(eventId == nil) {
        NSLog(@"AnalysisManager->event = nil");
        return;
    }
    if(_curDataModel == nil) {
         NSLog(@"AnalysisManager->event:_curDataModel = nil");
         return;
        
    }
    NSLog(@"AnalysisManager->event = %@, eventName = %@",eventId, name );
    AnalysisDataModel_Event *event = [[[AnalysisDataModel_Event alloc] init] autorelease];
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    event.triggerTime = [formatter stringFromDate: [NSDate date]];
    event.eventId = eventId;
    event.eventName =  name;
    [_curDataModel.event addObject: event];
    if([self.urlSubString count] > 0) {
        [_curSubDataModel.event addObject: event];  // 保存子服务数据
    }
    
    [self immediatelyUpLoad];
    
}

/******************************************************
 ** 功能:     统计事件
 ** 参数:     summary       ---   错误摘要
 **          description    ---   错误详情
 ** 返回:     无
 ******************************************************/
- (void)error:(NSString *)summary description:(NSString *)description {
    
    if(_curDataModel == nil) return;
    
    AnalysisDataModel_Error *error = [[[AnalysisDataModel_Error alloc] init] autorelease];
    error.errorSummary = summary;
    error.errorDescription = description;
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    error.errorTime = [formatter stringFromDate: [NSDate date]];
    [_curDataModel.error addObject: error];    
    if([self.urlSubString count] > 0) {
        [_curSubDataModel.error addObject: error];   // 保存子服务数据 
    }
    // 判断是否上传数据  添加并上传
    [self immediatelyUpLoad]; 
}

#pragma mark Analysisi数据生成

/******************************************************
 ** 功能:     生成 application
 ** 参数:     无
 ** 返回:     application
 ******************************************************/
- (AnalysisDataModel *)genDataAnalysis {
    AnalysisDataModel *data = [[[AnalysisDataModel alloc] init] autorelease];
    // 生成APP 
    AnalysisDataModel_Application *analysis_application = [self genDataAnalysis_Application];
    data.application = analysis_application;
    
    // 生成终端信息
    AnalysisDataModel_Terminal *analysis_terminal = [self genDataAnalysis_Terminal];
    data.terminal = analysis_terminal;
    
    // 生成本次的launch数据
    AnalysisDataModel_Launch *analysis_launch = [self genDataAnalysis_Launch];
    data.launch = analysis_launch;

    
    return data;
}

/******************************************************
 ** 功能:     生成 application
 ** 参数:     无
 ** 返回:     application
 ******************************************************/
- (AnalysisDataModel_Application *)genDataAnalysis_Application {
    AnalysisDataModel_Application *data = [[[AnalysisDataModel_Application alloc] init] autorelease];
    data.appKey = self.appKey;
    data.appName = self.appName;
    data.appVersion = self.appVersion;
    data.appPackgeName = self.appPackgeName;
    data.channelld = self.appChannelId;
    data.channelName =  self.appChannelName;
    return data;
}

/******************************************************
 ** 功能:     生成 终端标识
 ** 参数:     无
 ** 返回:     终端标识
 ******************************************************/
- (AnalysisDataModel_Terminal *)genDataAnalysis_Terminal {
    AnalysisDataModel_Terminal *data = [[[AnalysisDataModel_Terminal alloc] init] autorelease];
    data.terminalld =  [AnalysisManager getTerminalld ];
    data.deviceld =    [AnalysisManager getDeviceId ];
    data.platform = @"1";//[UIDevice currentDevice].systemName;
    data.platformVersion = [UIDevice currentDevice].systemVersion;
    data.deviceldModel = [UIDevice currentDevice].model;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    data.terminalResolution = [NSString stringWithFormat:@"%d*%d", (int)screenSize.width, (int)screenSize.height];
    data.terminalCPU = @"";    
    return data;
}

/******************************************************
 ** 功能:     生成 launch
 ** 参数:     无
 ** 返回:     launch
 ******************************************************/
- (AnalysisDataModel_Launch *)genDataAnalysis_Launch {
    AnalysisDataModel_Launch *data = [[[AnalysisDataModel_Launch alloc] init] autorelease];
    
    // 会话ID
    data.sessionID =    self.sessionId;
    // 启动时间
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    data.launchTime   = [formatter stringFromDate: [NSDate date]];
    data.launchLength = @"0";   // 默认0
    
    //位置信息
    data.longitude =  @"";
    data.latitude  =  @"";
    data.launchRegion = @"";
    

    NSTimeZone *timeZone =  [NSTimeZone localTimeZone];
    data.timeZone     = timeZone.name;
    
    data.country      = @"";
    //data.
    data.language =      [AnalysisManager getLanguage];
    data.accessMethod =  [AnalysisManager networkState];
    // 获取运营商
    data.operators =  [AnalysisManager getOperators];
    
    // SDK
    data.sdkType = @"IOS";                  
    data.sdkVersion = AnalysisConfig_SdkVersion;                     
    data.OS = [UIDevice currentDevice].systemName;
    data.OsVersion = [UIDevice currentDevice].systemVersion;
    return data;
}


/******************************************************
 ** 功能:     生成 页面数据
 ** 参数:     无
 ** 返回:     页面数据
 ******************************************************/
- (AnalysisDataModel_Visit *)genVisit {
    AnalysisDataModel_Visit *visit = [[[AnalysisDataModel_Visit alloc] init] autorelease];
    
    NSDate *timeOnExitView = [NSDate date];
    NSTimeInterval duration = [timeOnExitView timeIntervalSinceDate:_curEnterViewTimer];
    
    visit.remainLength = [NSString stringWithFormat:@"%d", (int)duration];
    visit.page = _curEnterViewName;
    visit.pageOrder = [NSString stringWithFormat:@"%d", _pageOrder];
    return visit;

}

/******************************************************
 ** 功能:     生产会话标识
 ** 参数:     无
 ** 返回:     会话标识
 ******************************************************/
- (NSString *)generateSessionId {
    //时间+KEY+终端标识 Z
    NSDate *now = [NSDate date];

    NSTimeInterval interval = [now timeIntervalSince1970];
    NSString *intervalStr = [NSString stringWithFormat:@"%f", interval];
    NSMutableData *data = [intervalStr dataUsingEncoding:NSUTF8StringEncoding];
    // 加key

    NSString *appkey = self.appKey;
    [data appendData: [appkey dataUsingEncoding:NSUTF8StringEncoding]];
    
    //加终端标识
    NSString *terminalled = [AnalysisManager getTerminalld];
    [data appendData: [terminalled dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *md5 = data.md5Hash;
 
    return md5;
}

#pragma mark 工具方法

/******************************************************
 ** 功能:     得到当前网络状态
 ** 参数:     无
 ** 返回:     网络状态
 ******************************************************/
+ (NSString*)networkState {
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NSString  *state = @"";
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            return @"";
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            state =  @"3G/GPRS网络";
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            state =  @"WiFI";
            break;
    }
    return state;
}

/******************************************************
 ** 功能:     得到当前使用语言
 ** 参数:     无
 ** 返回:     语言类型
 ******************************************************/
+ (NSString *)getLanguage {

    NSLocale *locale = [NSLocale currentLocale];
    NSString *language =  [locale displayNameForKey:NSLocaleIdentifier value:[locale localeIdentifier]];
    return language;
}
/******************************************************
 ** 功能:     得到运营商
 ** 参数:     无
 ** 返回:     运营商
 ******************************************************/
+ (NSString *)getOperators {
    // 4.0以上
    //CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] autorelease];
    //CTCarrier *carrier =  info.subscriberCellularProvider;
    //return [carrier carrierName];
    
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = info.subscriberCellularProvider;
//    NSLog(@"carrier:%@", [carrier description]);
    return @"";
}
/******************************************************
 ** 功能:     得到机器码
 ** 参数:     无
 ** 返回:     机器码
 ******************************************************/
+ (NSString *)getDeviceId {
    NSString *deviceId = [[UIDevice currentDevice] uniqueIdentifier];
    
    return deviceId;
}

/******************************************************
 ** 功能:     得到终端标识
 ** 参数:     无
 ** 返回:     终端标识
 ******************************************************/
+ (NSString *)getTerminalld {
    NSString *deviceId = [AnalysisManager getDeviceId];
    NSData *data = [deviceId dataUsingEncoding:NSUTF8StringEncoding];
    NSString *md5 = data.md5Hash;
    
    return md5;
}


#pragma mark 数据库操作

/******************************************************
 ** 功能:     得到文件缓存 统计分析数据
 ** 参数:     无
 ** 返回:     分析数据
 ******************************************************/
+ (NSString *)getAnalysisData {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSString *documentsDirectory= [NSHomeDirectory() 
                                   stringByAppendingPathComponent:@"Documents"];
    
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    NSString *path = [documentsDirectory stringByAppendingPathComponent:AnalysisConfig_FileName];

    NSDictionary *attr =[fileManager fileAttributesAtPath: path traverseLink: NO] ; //文件属性
    long size = [[attr objectForKey:NSFileSize] longValue];
    NSLog(@"getAnalysisSubServerData->file size is：%i bytes ",size);
    
    if (size > AnalysisConfig_FileSizeMax) {
        return nil;        //  数据过大异常 舍去
    }
    NSError *error;
    NSString *str =  [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    return str;
}

/******************************************************
 ** 功能:     保存 统计分析数据
 ** 参数:     分析数据
 ** 返回:     无
 ******************************************************/
+ (void)saveAnalysisData:(NSString *)data {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSString *documentsDirectory= [NSHomeDirectory() 
                                   stringByAppendingPathComponent:@"Documents"];
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    NSString *path = [documentsDirectory stringByAppendingPathComponent:AnalysisConfig_FileName];
    [fileManager removeItemAtPath:path error:nil];
   // unsigned long long size = [fileManager fileSize];
      NSError *error;
    //[data writeToFile:path atomically:YES];
    [data writeToFile:(NSString *)path atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

/******************************************************
 ** 功能:     得到上传类型
 ** 参数:     无
 ** 返回:     上传类型
 ******************************************************/
+ (NSInteger)getUpLoadType {
  
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud integerForKey:AnalysisConfig_UpLoadType];
}

/******************************************************
 ** 功能:     设置上传类型
 ** 参数:     上传类型
 ** 返回:     无
 ******************************************************/
+ (void)setUpLoadType:(NSInteger)upLoadType {
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:upLoadType forKey:AnalysisConfig_UpLoadType];
    [ud synchronize];
}

@end

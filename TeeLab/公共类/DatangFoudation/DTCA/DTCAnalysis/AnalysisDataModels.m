/******************************************************
 * 模块名称:   AnalysisDataMode.m
 * 模块功能:   统计分析数据结构
 * 创建日期:   2012-09-25
 * 创建作者:   付大志
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/
#import "AnalysisDataModels.h"

// 子服务器 数据模块
@implementation AnalysisDataModel_SubServer
@synthesize analysisDataModel_Array = _analysisDataModel_Array;
@synthesize subServerUrl            = _subServerUrl;
- (id)init {
    if (self = [super init]) {
        _analysisDataModel_Array = [[AnalysisDataModel_Array alloc] init];
        _subServerUrl = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc {
    [_analysisDataModel_Array release];
    [_subServerUrl release];
    [super dealloc];
}

/******************************************************
 ** 功能:     将 子服务器数据 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         [_analysisDataModel_Array toJsonObject], @"analysisDataModel_Array"
                         , _subServerUrl, @"subServerUrl"
                         , nil];
    return obj;
    
}

/******************************************************
 ** 功能:     将Json数据结构  转成  子服务器数据
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     统计分析记录全部数据
 ******************************************************/
+ (AnalysisDataModel_SubServer *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_SubServer *result = [[[AnalysisDataModel_SubServer alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    AnalysisDataModel_Array *analysisDataModel_Array = [AnalysisDataModel_Array fromJsonObject:[json objectForKey:@"analysisDataModel_Array"]];
    
    NSMutableArray *subServerUrl =  [json objectForKey:@"subServerUrl"];
    result.subServerUrl = subServerUrl;
    result.analysisDataModel_Array =analysisDataModel_Array;
    return result;
}


@end

// 统计分析记录全部数据
@implementation AnalysisDataModel_Array

@synthesize  analysisDataModel = _analysisDataModel;


- (id)init {
    if (self = [super init]) {
        _analysisDataModel = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)dealloc {
    [_analysisDataModel release];
    [super dealloc];
}
/******************************************************
 ** 功能:     将 统计分析记录全部数据 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    
    NSUInteger count;
    count = [_analysisDataModel count];

    NSMutableArray *analysisDataModelJsonObj = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_Array *obj = [_analysisDataModel objectAtIndex:i];
        [analysisDataModelJsonObj addObject:[obj toJsonObject]];
    }

    return analysisDataModelJsonObj;
    
}

/******************************************************
 ** 功能:     将Json数据结构  转成  统计分析记录全部数据
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     统计分析记录全部数据
 ******************************************************/
+ (AnalysisDataModel_Array *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_Array *result = [[[AnalysisDataModel_Array alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    // NSArray *jsonAnalysisDataModel = [json objectForKey:@"Context"];
    NSArray *jsonAnalysisDataModel = jsonObj;
    NSUInteger count = [jsonAnalysisDataModel count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel *obj = [jsonAnalysisDataModel objectAtIndex:i];
        [result.analysisDataModel addObject:[AnalysisDataModel fromJsonObject:obj]];
    }
    
    return result;
}


@end

// 统计分析当个记录表结果
@implementation AnalysisDataModel

@synthesize  application = _application;
@synthesize  terminal    = _terminal;
@synthesize  launch      = _launch;
@synthesize  event       = _event;
@synthesize  visit        = _visit;
@synthesize  error       = _error;

- (id)init {
    if (self = [super init]) {
        _event = [[NSMutableArray alloc] init];
        _visit = [[NSMutableArray alloc] init];
        _error = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)dealloc {
    [_application release];
    [_terminal    release];
    [_launch      release];
    [_event       release];
    [_visit        release];
    [_error       release];
    [super dealloc];
}

/******************************************************
 ** 功能:     将 统计分析当个记录表结果 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    NSUInteger count;
    
    // 应用相关数据
    NSMutableArray *applicatinJsonObj = nil;
    if(_application != nil) {
        applicatinJsonObj= [NSMutableArray arrayWithCapacity:1];
        [applicatinJsonObj addObject:[_application toJsonObject]];
    }
    
    // 终端信息
    NSMutableArray *terminalJsonObj = nil;
    if(_terminal != nil) {
        terminalJsonObj = [NSMutableArray arrayWithCapacity:1];
        [terminalJsonObj addObject:[_terminal toJsonObject]];
    }
    
    // 启动信息
    NSMutableArray *launchJsonObj = nil;
    if(_launch != nil) {
        launchJsonObj = [NSMutableArray arrayWithCapacity:1];
        [launchJsonObj addObject:[_launch toJsonObject]];
    }
    
    // 事件
    count = [_event count];
    NSMutableArray *eventJsonObj = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_Event *obj = [_event objectAtIndex:i];
        [eventJsonObj addObject:[obj toJsonObject]];
    }
    // 窗体
    count = [_visit count];
    NSMutableArray *pageJsonObj = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_Visit *obj = [_visit objectAtIndex:i];
        [pageJsonObj addObject:[obj toJsonObject]];
    }
    // 错误
    count = [_error count];
    NSMutableArray *errorJsonObj = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_Error *obj = [_error objectAtIndex:i];
        [errorJsonObj addObject:[obj toJsonObject]];
    }
    
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         applicatinJsonObj, @"application"
                         , terminalJsonObj, @"terminal"
                         , launchJsonObj, @"launch"
                         , eventJsonObj, @"event"
                         , pageJsonObj, @"visit"
                         , errorJsonObj, @"error"
                         , nil];
    return obj;
}

/******************************************************
 ** 功能:     将Json数据结构  转成  统计分析当个记录表结果
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     统计分析当个记录表结果
 ******************************************************/
+ (AnalysisDataModel *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel *result = [[[AnalysisDataModel alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    NSDictionary *temp;
    // 应用相关数据
    NSArray *jsonApplicatin = [json objectForKey:@"application"];
    temp = [jsonApplicatin objectAtIndex:0];
    result.application = [AnalysisDataModel_Application fromJsonObject:temp];
    
    // 终端信息
    NSArray *jsonTerminal = [json objectForKey:@"terminal"];
    temp = [jsonTerminal objectAtIndex:0];
    result.terminal = [AnalysisDataModel_Terminal fromJsonObject:temp];
    
    // 启动信息
    NSArray *jsonLaunch = [json objectForKey:@"launch"];
    temp = [jsonLaunch objectAtIndex:0];
    result.launch = [AnalysisDataModel_Launch fromJsonObject:temp];
    
    // 事件
    NSArray *jsonEvent = [json objectForKey:@"event"];
    NSUInteger count = [jsonEvent count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_Event *obj = [jsonEvent objectAtIndex:i];
        [result.event addObject:[AnalysisDataModel_Event fromJsonObject:obj]];
    }
    // 窗体
    NSArray *jsonVisit = [json objectForKey:@"visit"];
    count = [jsonVisit count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_Visit *obj = [jsonVisit objectAtIndex:i];
        [result.visit addObject:[AnalysisDataModel_Visit fromJsonObject:obj]];
    }
    // 错误
    NSArray *jsonError = [json objectForKey:@"error"];
    count = [jsonError count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_Error *obj = [jsonError objectAtIndex:i];
        [result.error addObject:[AnalysisDataModel_Error fromJsonObject:obj]];
    }
    
    return result;
}



@end

// 应用相关数据模型
@implementation AnalysisDataModel_Application

@synthesize  appKey  = _appKey;
@synthesize  appName = _appName;
@synthesize  appVersion = _appVersion;
@synthesize  appPackgeName = _appPackgeName;
@synthesize  channelld = _channelld;
@synthesize  channelName = _channelName;

- (id)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (void)dealloc {
    [_appKey release];
    [_appName release];
    [_appVersion release];
    [_appPackgeName release];
    [_channelld release];
    [_channelName release];
    [super dealloc];
}


/******************************************************
 ** 功能:     将 应用相关数据模型 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    // 异常处理
    if(_appKey == nil) _appKey = @"";
    if(_appName == nil) _appName = @"";
    if(_appVersion == nil) _appVersion = @"";
    if(_appPackgeName == nil) _appPackgeName = @"";
    if(_channelld == nil) _channelld = @"";
    if(_channelName == nil) _channelName = @"";
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         _appKey, @"AppKey"
                         , _appName, @"AppName"
                         , _appVersion, @"AppVersion"
                         , _appPackgeName, @"AppPackageName"
                         , _channelld, @"ChannelId"
                         , _channelName, @"ChannelName"
                         , nil];
    return obj;
}

/******************************************************
 ** 功能:     将Json数据结构  转成  应用相关数据模型
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     应用相关数据模型
 ******************************************************/
+ (AnalysisDataModel_Application *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_Application *result = [[[AnalysisDataModel_Application alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    
    result.appKey = [json objectForKey:@"AppKey"];
    result.appName = [json objectForKey:@"AppName"];
    result.appVersion = [json objectForKey:@"AppVersion"];
    result.appPackgeName = [json objectForKey:@"AppPackgeName"];
    result.channelld = [json objectForKey:@"ChannelId"];
    result.channelName = [json objectForKey:@"ChannelName"];
    
    return result;
}


@end


//  终端信息对象
@implementation AnalysisDataModel_Terminal

@synthesize  terminalld= _terminalld;
@synthesize  deviceld = _deviceld;
@synthesize  platform = _platform;
@synthesize  platformVersion = _platformVersion;
@synthesize  deviceldModel = _deviceldModel;
@synthesize  terminalResolution = _terminalResolution;
@synthesize  terminalCPU = _terminalCPU;
- (id)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (void)dealloc {
    [_terminalld release];
    [_deviceld release];
    [_platform release];
    [_platformVersion release];
    [_deviceldModel release];
    [_terminalResolution release];
    [_terminalCPU release];
    [super dealloc];
}

/******************************************************
 ** 功能:     将 终端信息对象 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    
    // 异常处理
    if(_terminalld == nil) _terminalld = @"";
    if(_deviceld == nil) _deviceld = @"";
    if(_platform == nil) _platform = @"";
    if(_platformVersion == nil) _platformVersion = @"";
    if(_deviceldModel == nil) _deviceldModel = @"";
    if(_terminalResolution == nil) _terminalResolution = @"";
    if(_terminalCPU == nil) _terminalCPU = @"";
    
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         _terminalld, @"TerminalId"
                         , _deviceld, @"DeviceId"
                         , _platform, @"Platform"
                         , _platformVersion, @"PlatformVersion"
                         , _deviceldModel, @"DeviceModel"
                         , _terminalResolution, @"TerminalResolution"
                         , _terminalCPU, @"TerminalCPU"
                         , nil];
    return obj;
}

/******************************************************
 ** 功能:     将Json数据结构  转成  终端信息对象
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     终端信息对象
 ******************************************************/
+ (AnalysisDataModel_Terminal *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_Terminal *result = [[[AnalysisDataModel_Terminal alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    
    result.terminalld = [json objectForKey:@"TerminalId"];
    result.deviceld = [json objectForKey:@"DeviceId"];
    result.platform = [json objectForKey:@"Platform"];
    result.platformVersion = [json objectForKey:@"PlatformVersion"];
    result.deviceldModel = [json objectForKey:@"DeviceModel"];
    result.terminalResolution = [json objectForKey:@"TerminalResolution"];
    result.terminalCPU = [json objectForKey:@"TerminalCPU"];
    
    return result;
}

@end


//  应用启动对象
@implementation AnalysisDataModel_Launch

@synthesize  sessionID = _sessionID;
@synthesize  launchTime = _launchTime;
@synthesize  launchLength = _launchLength;
@synthesize  longitude = _longitude;
@synthesize  latitude = _latitude;
@synthesize  launchRegion = _launchRegion;
@synthesize  timeZone  = _timeZone;
@synthesize  language = _language;
@synthesize  country = _country;
@synthesize  accessMethod = _accessMethod;
@synthesize  operators = _operators;
@synthesize  sdkType = _sdkType;
@synthesize  sdkVersion = _sdkVersion;
@synthesize  OS = _OS;
@synthesize  OsVersion = _OsVersion;


- (id)init {
    if (self = [super init]) {
}

return self;
}

- (void)dealloc {
    [_sessionID release];
    [_launchTime release];
    [_launchLength release];
    [_longitude release];
    [_latitude release];
    [_launchRegion release];
    [_language release];
    [_country release];
    [_accessMethod release];
    [_operators release];
    [_sdkType release];
    [_sdkVersion release];
    [_OS release];
    [_OsVersion release];
    
    [super dealloc];
}

/******************************************************
 ** 功能:     将 应用启动对象 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    
    // 异常处理
    if(_sessionID == nil) _sessionID = @"";
    if(_launchTime == nil) _launchTime = @"";
    if(_launchLength == nil) _launchLength = @"";
    if(_longitude == nil) _longitude = @"";
    if(_latitude == nil) _latitude = @"";
    if(_launchRegion == nil) _launchRegion = @"";
    if(_timeZone == nil) _timeZone = @"";
    if(_language == nil) _language = @"";
    if(_country == nil) _country = @"";
    if(_accessMethod == nil) _accessMethod = @"";
    if(_operators == nil) _operators = @"";
    if(_sdkType == nil) _sdkType = @"";
    if(_sdkVersion == nil) _sdkVersion = @"";
    if(_OS == nil) _OS = @"";
    if(_OsVersion == nil) _OsVersion = @"";
    
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         _sessionID, @"SessionId"
                         , _launchTime, @"LaunchTime"
                         , _launchLength, @"LaunchLength"
                         , _longitude, @"Longitude"
                         , _latitude, @"Latitude"
                         , _launchRegion, @"LaunchRegion"
                         , _timeZone, @"TimeZone"
                         , _language, @"Language"
                         , _country, @"Country"
                         , _accessMethod, @"AccessMethod"
                         , _operators, @"Operators"
                         , _sdkType, @"SdkType"
                         , _sdkVersion, @"SdkVersion"
                         , _OS, @"Os"
                         , _OsVersion, @"OsVersion"
                         , nil];
    return obj;
}

/******************************************************
 ** 功能:     将Json数据结构  转成  应用启动对象
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     应用启动对象
 ******************************************************/
+ (AnalysisDataModel_Launch *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_Launch *result = [[[AnalysisDataModel_Launch alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    
    result.sessionID = [json objectForKey:@"SessionId"];
    result.launchTime = [json objectForKey:@"LaunchTime"];
    result.launchLength = [json objectForKey:@"LaunchLength"];
    result.longitude = [json objectForKey:@"Longitude"];
    result.latitude = [json objectForKey:@"Latitude"];
    result.launchRegion = [json objectForKey:@"LaunchRegion"];
    result.timeZone   =  [json objectForKey:@"TimeZone"];
    result.language = [json objectForKey:@"Language"];
    result.country = [json objectForKey:@"Country"];
    result.accessMethod = [json objectForKey:@"AccessMethod"];
    result.operators = [json objectForKey:@"Operators"];
    result.sdkType = [json objectForKey:@"SdkType"];
    result.sdkVersion = [json objectForKey:@"SdkVersion"];
    result.OS = [json objectForKey:@"Os"];
    result.OsVersion = [json objectForKey:@"OsVersion"];
    return result;
}


@end


//  自定义事件对象
@implementation AnalysisDataModel_Event

@synthesize  eventId     = _eventId;
@synthesize  eventName   = _eventName;
@synthesize  triggerTime = _triggerTime;

- (id)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (void)dealloc {
    [_eventId release];
    [_eventName release];
    [_triggerTime release];
    
    [super dealloc];
}

/******************************************************
 ** 功能:     将 事件对象 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    
    // 异常处理
    if(_eventId == nil) _eventId = @"";
    if(_triggerTime == nil) _triggerTime = @"";
    if(_eventName == nil)  _eventName = @"";
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         _eventId, @"EventId"
                         ,_eventName, @"EventName"
                         , _triggerTime, @"TriggerTime"
                         , nil];
    return obj;
}

/******************************************************
 ** 功能:     将Json数据结构  转成 事件对象
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     事件对象
 ******************************************************/
+ (AnalysisDataModel_Event *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_Event *result = [[[AnalysisDataModel_Event alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    
    result.eventId = [json objectForKey:@"EventId"];
    result.eventName = [json objectForKey:@"EventName"];
    result.triggerTime = [json objectForKey:@"TriggerTime"];
    
    return result;
}

@end

//  页面访问对象
@implementation AnalysisDataModel_Visit

@synthesize  pageOrder = _pageOrder;
@synthesize  remainLength = _remainLength;
@synthesize  page =  _page;
- (id)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (void)dealloc {
    [_pageOrder release];
    [_remainLength release];
    [_page release];
    [super dealloc];
}

/******************************************************
 ** 功能:     将页面对象 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    
    // 异常处理
    if(_page == nil) _page = @"";
    if(_pageOrder == nil) _pageOrder = @"";
    if(_remainLength == nil) _remainLength = @"";
    
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         _page,  @"Page"
                         ,_pageOrder, @"PageOrder"
                         , _remainLength, @"RemainLength"
                         , nil];
    return obj;
}

/******************************************************
 ** 功能:     将Json数据结构 转成 页面对象
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     页面对象
 ******************************************************/
+ (AnalysisDataModel_Visit *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_Visit *result = [[[AnalysisDataModel_Visit alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    
    result.page = [json objectForKey:@"Page"];
    result.pageOrder = [json objectForKey:@"PageOrder"];
    result.remainLength = [json objectForKey:@"RemainLength"];
    
    return result;
}



@end


//  错误报告对象
@implementation AnalysisDataModel_Error

@synthesize  errorSummary = _errorSummary;
@synthesize  errorDescription = _errorDescription;
@synthesize  errorTime = _errorTime;
- (id)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (void)dealloc {
    [_errorSummary release];
    [_errorDescription release];
    [_errorTime release];
    [super dealloc];
}

/******************************************************
 ** 功能:     将 错误报告对象 转成 Json数据结构
 ** 参数:     无
 ** 返回:     Json数据结构
 ******************************************************/
- (id)toJsonObject {
    
    // 异常处理
    if(_errorSummary == nil) _errorSummary = @"";
    if(_errorDescription == nil) _errorDescription = @"";
    if(_errorTime == nil) _errorTime = @"";
    
    NSDictionary *obj = [NSDictionary dictionaryWithObjectsAndKeys:
                         _errorSummary, @"ErrorSummary"
                         , _errorDescription, @"ErrorDescription"
                         , _errorTime, @"ErrorTime"
                         , nil];
    return obj;
}

/******************************************************
 ** 功能:     将Json数据结构转错误报告对象
 ** 参数:     jsonObj ---- Json数据结构
 ** 返回:     错误报告对象
 ******************************************************/
+ (AnalysisDataModel_Error *)fromJsonObject:(id)jsonObj {
    AnalysisDataModel_Error *result = [[[AnalysisDataModel_Error alloc] init] autorelease];
    NSDictionary *json = jsonObj;
    
    result.errorSummary = [json objectForKey:@"ErrorSummary"];
    result.errorDescription = [json objectForKey:@"ErrorDescription"];
    result.errorTime = [json objectForKey:@"ErrorTime"];
    return result;
}


@end
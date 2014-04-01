/******************************************************
 * 模块名称:   AnalysisDataMode.h
 * 模块功能:   统计分析数据结构
 * 创建日期:   2012-09-25
 * 创建作者:   付大志
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>

@class AnalysisDataModel_Application;
@class AnalysisDataModel_Terminal;
@class AnalysisDataModel_Launch;
@class AnalysisDataModel_Event;
@class AnalysisDataModel_Visit;
@class AnalysisDataModel_Error;
@class AnalysisDataModel_Array;


// 子服务器 数据模块
@interface AnalysisDataModel_SubServer : NSObject {
    AnalysisDataModel_Array *_analysisDataModel_Array;   // 一个完整的上传数据
    NSMutableArray          *_subServerUrl;              // 子服务器地址 NSString

}
@property(nonatomic, retain) AnalysisDataModel_Array  *analysisDataModel_Array;
@property(nonatomic, retain) NSMutableArray           *subServerUrl;

- (id)toJsonObject;
+ (AnalysisDataModel_SubServer *)fromJsonObject:(id)jsonObj;
@end

// 统计分析记录全部数据
@interface AnalysisDataModel_Array : NSObject {
    NSMutableArray                *_analysisDataModel;

}
@property(nonatomic, retain) NSMutableArray                *analysisDataModel;

- (id)toJsonObject;
+ (AnalysisDataModel_Array *)fromJsonObject:(id)jsonObj;
@end

// 统计分析单个记录数据模型
@interface AnalysisDataModel : NSObject {
    AnalysisDataModel_Application *_application;
    AnalysisDataModel_Terminal    *_terminal;
    AnalysisDataModel_Launch      *_launch;
    NSMutableArray                *_event;
    NSMutableArray                *_visit;
    NSMutableArray                *_error;
}

@property(nonatomic, retain) AnalysisDataModel_Application *application;
@property(nonatomic, retain) AnalysisDataModel_Terminal    *terminal;
@property(nonatomic, retain) AnalysisDataModel_Launch      *launch;
@property(nonatomic, retain) NSMutableArray                *event;
@property(nonatomic, retain) NSMutableArray                *visit;
@property(nonatomic, retain) NSMutableArray                *error;

- (id)toJsonObject;
+ (AnalysisDataModel *)fromJsonObject:(id)jsonObj;
@end


// 应用相关数据模型
@interface AnalysisDataModel_Application : NSObject {
    NSString         *_appKey;                         // 应用标识，服务器分配
    NSString         *_appName;                        // 应用名称                       
    NSString         *_appVersion;                     // 应用版本
    NSString         *_appPackgeName;                  // 应用包名
    NSString         *_channelld;                      // 渠道标识
    NSString         *_channelName;                    // 通道名称
}
@property(nonatomic, retain) NSString *appKey;
@property(nonatomic, retain) NSString *appName;
@property(nonatomic, retain) NSString *appVersion;
@property(nonatomic, retain) NSString *appPackgeName;
@property(nonatomic, retain) NSString *channelld;
@property(nonatomic, retain) NSString *channelName;

- (id)toJsonObject;
+ (AnalysisDataModel_Application *)fromJsonObject:(id)jsonObj;
@end

//  终端信息对象
@interface AnalysisDataModel_Terminal : NSObject {
    NSString         *_terminalld;                    // 终端标识
    NSString         *_deviceld;                       // 机器码
    NSString         *_platform;                       // 系统平台
    NSString         *_platformVersion;                // 平台版本
    NSString         *_deviceldModel;                  // 设备型号
    NSString         *_terminalResolution;             // 屏幕分辨率
    NSString         *_terminalCPU;                    // 终端CPU信息
}
@property(nonatomic, retain) NSString *terminalld;
@property(nonatomic, retain) NSString *deviceld;
@property(nonatomic, retain) NSString *platform;
@property(nonatomic, retain) NSString *platformVersion;
@property(nonatomic, retain) NSString *deviceldModel;
@property(nonatomic, retain) NSString *terminalResolution;
@property(nonatomic, retain) NSString *terminalCPU;

- (id)toJsonObject;
+ (AnalysisDataModel_Terminal *)fromJsonObject:(id)jsonObj;
@end

//  应用启动对象
@interface AnalysisDataModel_Launch : NSObject {
    NSString         *_sessionID;                      // 会话标识
    NSString         *_launchTime;                     // 启动时间
    NSString         *_launchLength;                   // 使用时长
    NSString         *_longitude;                      // 经度
    NSString         *_latitude;                       // 纬度
    NSString         *_launchRegion;                   // 所在地区
    NSString         *_timeZone;                       // 所在时区
    
    NSString         *_language;                       // 语言
    NSString         *_country;                        // 国家
    NSString         *_accessMethod;                   // 接入方式
    NSString         *_operators;                      // 运营商
    NSString         *_sdkType;                        // SDK类型
    NSString         *_sdkVersion;                     // SDK版本
    NSString         *_OS;                             // 操作系统
    NSString         *_OsVersion;                      // 操作系统版本
    
}


@property(nonatomic, retain) NSString *sessionID;
@property(nonatomic, retain) NSString *launchTime;
@property(nonatomic, retain) NSString *launchLength;
@property(nonatomic, retain) NSString *longitude;
@property(nonatomic, retain) NSString *latitude;
@property(nonatomic, retain) NSString *launchRegion;
@property(nonatomic, retain) NSString *timeZone;
@property(nonatomic, retain) NSString *language;
@property(nonatomic, retain) NSString *country;
@property(nonatomic, retain) NSString *accessMethod;
@property(nonatomic, retain) NSString *operators;
@property(nonatomic, retain) NSString *sdkType;
@property(nonatomic, retain) NSString *sdkVersion;
@property(nonatomic, retain) NSString *OS;
@property(nonatomic, retain) NSString *OsVersion;

- (id)toJsonObject;
+ (AnalysisDataModel_Launch *)fromJsonObject:(id)jsonObj;

@end

//  自定义事件对象
@interface AnalysisDataModel_Event : NSObject {
    NSString         *_eventId;                       // 事件标识
    NSString         *_eventName;                     // 事件名称
    NSString         *_triggerTime;                   // 触发时间
}
@property(nonatomic, retain) NSString *eventId;
@property(nonatomic, retain) NSString *eventName; 
@property(nonatomic, retain) NSString *triggerTime;

- (id)toJsonObject;
+ (AnalysisDataModel_Event *)fromJsonObject:(id)jsonObj;
@end

//  页面访问对象
@interface AnalysisDataModel_Visit : NSObject {
    NSString         *_page;                          // 页面名称
    NSString         *_pageOrder;                     // 访问顺序
    NSString         *_remainLength;                  // 运行时间
}
@property(nonatomic, retain) NSString *page;
@property(nonatomic, retain) NSString *pageOrder;
@property(nonatomic, retain) NSString *remainLength;

- (id)toJsonObject;
+ (AnalysisDataModel_Visit *)fromJsonObject:(id)jsonObj;
@end

//  错误报告对象
@interface AnalysisDataModel_Error : NSObject {
    NSString         *_errorSummary;                  // 错误摘要
    NSString         *_errorDescription;              // 错误详情
    NSString         *_errorTime;                     // 发生错误时间
}
@property(nonatomic, retain) NSString *errorSummary;
@property(nonatomic, retain) NSString *errorDescription;
@property(nonatomic, retain) NSString *errorTime;

- (id)toJsonObject;
+ (AnalysisDataModel_Visit *)fromJsonObject:(id)jsonObj;
@end


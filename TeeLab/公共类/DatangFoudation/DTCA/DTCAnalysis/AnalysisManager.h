/******************************************************
 * 模块名称:   AnalysisManager.h
 * 模块功能:   统计分析 接口逻辑实现模块
 * 创建日期:   2012-09-27
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/
#import <Foundation/Foundation.h>
#import "AnalysisDataModels.h"
#import "AnalysisUpLoad.h"
#import "AnalysisLocation.h"

@class  AnalysisUpLoadSub;
typedef enum {
    AnalysisUpLoadType_Lanuch = 0,    // 启动发送
    AnalysisUpLoadType_Immediately,   // 实时发送
} AnalysisUpLoadType_E;

@interface AnalysisManager : NSObject {
    // 用户配置参数
    NSString                 *_appKey;                   // 应用标识
    NSString                 *_appName;                  // 应用名称
    NSString                 *_appVersion;               // 应用版本
    NSString                 *_appPackgeName;            // 用版本
    NSString                 *_appChannelId;             // 渠道标识 
    NSString                 *_appChannelName;           // 渠道名称
    

    AnalysisUpLoad           *_uploadAnalysis;           // 上传数据管理
    AnalysisDataModel        *_curDataModel;             // 当前分析数据 需要发送数据时将自己添加Array 在调用发送接口
    AnalysisDataModel_Launch *_curLaunch;                // 当前Launch 启动后长期存在 

    
    NSDate                   *_curEnterViewTimer;        // 进入当前view时间  
    NSString                 *_curEnterViewName;         // 当前view 名称
    
    NSUInteger               _pageOrder;                 // 当前页面顺序
    NSString                 *_sessionId;                // launch只生成1次 
    NSUInteger               _upLoadType;                // 上传类型
    
    Location                 *_location;                 // 定位信息
    //   子服务器信息
    AnalysisUpLoadSub        *_analysisUpLoadSub;        // 子服务器
    AnalysisDataModel        *_curSubDataModel;          // 子服务器的当前model
    NSMutableArray           *_urlSubString;              // 子服务器URL字符串
}

@property (nonatomic,retain) NSString        *appKey;
@property (nonatomic,retain) NSString        *appName;
@property (nonatomic,retain) NSString        *appVersion;
@property (nonatomic,retain) NSString        *appPackgeName;
@property (nonatomic,retain) NSString        *appChannelId;
@property (nonatomic,retain) NSString        *appChannelName;



@property (nonatomic,retain) AnalysisDataModel        *curDataModel;
@property (nonatomic,retain) AnalysisDataModel_Launch *curLaunch;

// 当前view参数
@property (nonatomic,retain) NSDate      *curEnterViewTimer;
@property (nonatomic,retain) NSString    *curEnterViewName;



@property (nonatomic,retain) NSString  *sessionId;

@property (nonatomic,retain) AnalysisUpLoad  *uploadAnalysis;           // 上传数据管理
@property (nonatomic,assign) NSUInteger  upLoadType;     

// 子服务器
@property (nonatomic, retain) NSMutableArray     *urlSubString;        // 子服务器URL字符串
@property (nonatomic,retain) AnalysisDataModel   *curSubDataModel;

/******************************************************
 ** 功能:     生成sharedManager实例
 ** 参数:     无
 ** 返回:     sharedManager实例
 ** 备注:     如已经生成将不会生成，       
 ******************************************************/
+ (AnalysisManager *)sharedManager;

/******************************************************
 ** 功能:     启动应用
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)appLaunched;

/******************************************************
 ** 功能:     退出应用
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)appTerminated;

/******************************************************
 ** 功能:     后台转入前台
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)applicationWillEnterForeground;

/******************************************************
 ** 功能:     进入后台运行
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)applicationDidEnterBackground;

/******************************************************
 ** 功能:     进入页面
 ** 参数:     name  ----  页面名称
 ** 返回:     无
 ******************************************************/
- (void)enterView:(NSString *)name;

/******************************************************
 ** 功能:     退出页面
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void) exitView;

/******************************************************
 ** 功能:     统计事件
 ** 参数:     eventId  --- 事件ID
 **           name    ---- 事件名称
 ** 返回:     无
 ******************************************************/
- (void)event:(NSString *)eventId eventName:(NSString*)name;

/******************************************************
 ** 功能:     统计事件
 ** 参数:     summary       ---   错误摘要
 **          description    ---   错误详情
 ** 返回:     无
 ******************************************************/
- (void)error:(NSString *)summary description:(NSString *)description;

#pragma mark 数据库操作

/******************************************************
 ** 功能:     得到文件缓存 统计分析数据
 ** 参数:     无
 ** 返回:     分析数据
 ******************************************************/
+ (NSString *)getAnalysisData;

/******************************************************
 ** 功能:     保存 统计分析数据
 ** 参数:     分析数据
 ** 返回:     无
 ******************************************************/
+ (void)saveAnalysisData:(NSString *)data;

/******************************************************
 ** 功能:     得到上传类型
 ** 参数:     无
 ** 返回:     上传类型
 ******************************************************/
+ (NSInteger)getUpLoadType;

/******************************************************
 ** 功能:     设置上传类型
 ** 参数:     上传类型
 ** 返回:     无
 ******************************************************/
+ (void)setUpLoadType:(NSInteger)upLoadType;
@end

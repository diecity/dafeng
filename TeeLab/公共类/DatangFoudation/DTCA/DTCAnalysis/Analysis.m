/******************************************************
 * 模块名称:   AnalysisManager.m
 * 模块功能:   统计分析 对外接口 类
 * 创建日期:   2012-09-27
 * 创建作者:   付大志
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/
#import "AnalysisManager.h"
#import "Analysis.h"

@implementation Analysis

#pragma mark 设置配置参数

/******************************************************
 ** 功能:     设置应用标识
 ** 参数:     应用标识
 ** 返回:     无
 ******************************************************/
+ (void)setAppKey:(NSString *)appKey {
    AnalysisManager *analysisManager =  [AnalysisManager sharedManager];

    analysisManager.appKey= appKey;
    
}

/******************************************************
 ** 功能:     设置应用名称
 ** 参数:     应用名称
 ** 返回:     无
 ******************************************************/
+ (void)setAppName:(NSString *)appName {
    AnalysisManager *analysisManager =  [AnalysisManager sharedManager];
    
    analysisManager.appName= appName;  
}

/******************************************************
 ** 功能:     设置应用版本
 ** 参数:     应用版本
 ** 返回:     无
 ******************************************************/
+ (void)setAppVersion:(NSString *)appVersion {
    [AnalysisManager sharedManager].appVersion= appVersion;
}

/******************************************************
 ** 功能:     设置应用包名
 ** 参数:     应用包名
 ** 返回:     无
 ******************************************************/
+ (void)setAppPackgeName:(NSString *)appPackgeName {
    [AnalysisManager sharedManager].appPackgeName= appPackgeName;
}

/******************************************************
 ** 功能:     设置应用渠道标识
 ** 参数:     应用渠道标识
 ** 返回:     无
 ******************************************************/
+ (void)setAppChannelId:(NSString *)appChannelId {
    [AnalysisManager sharedManager].appChannelId = appChannelId;
}

/******************************************************
 ** 功能:     设置应用渠道标识名称
 ** 参数:     应用渠道标识名称
 ** 返回:     无
 ******************************************************/
+ (void)setAppChannelName:(NSString *)appChannelName {
    [AnalysisManager sharedManager].appChannelName = appChannelName;
}


/******************************************************
 ** 功能:     设置服务器url
 ** 参数:     urlStr   ----  url字符串
 ** 返回:     无
 ******************************************************/
+ (void)setServerUrl:(NSString *)urlStr {
    [AnalysisManager sharedManager].uploadAnalysis.serverUrl =  urlStr;
}


/******************************************************
 ** 功能:     设置策略服务器url
 ** 参数:     urlStr   ----  url字符串
 ** 返回:     无
 ******************************************************/
+ (void)setPolyServerUrl:(NSString *)urlStr {
    [AnalysisManager sharedManager].uploadAnalysis.ployUrl =  urlStr;
}

/******************************************************
 ** 功能:     添加子服务器
 ** 参数:     urlString ---- 自服务器URL字符串
 ** 返回:     无
 **   注:     可以添加多个
 ******************************************************/
+ (void)addSubServerUrl:(NSString *)urlString {
    [[AnalysisManager sharedManager].urlSubString addObject:urlString];
}

#pragma mark 应用状态

/******************************************************
 * 功能:     应用启动
 * 参数:     无
 * 返回:     无
 ******************************************************/
+ (void)appLaunched {
    [[AnalysisManager sharedManager] appLaunched];
}

/******************************************************
 ** 功能:     应用退出
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
+ (void)appTerminated {
    [[AnalysisManager sharedManager] appTerminated];
    
}

/******************************************************
 ** 功能:     后台转入前台
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
+ (void)applicationWillEnterForeground {
    [[AnalysisManager sharedManager] applicationWillEnterForeground];
}

/******************************************************
 ** 功能:     进入后台运行
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
+ (void)applicationDidEnterBackground {
        [[AnalysisManager sharedManager] applicationDidEnterBackground];
}
#pragma mark 响应操作
//*****************************************************
// 注意记录页面信息 可以采用继承AnalysisBaseViewController
// 方式实现，就不要手动调用下面两个函数了，
//*****************************************************

/******************************************************
 ** 功能:     进入新页面
 ** 参数:     name  ---- 页面名称
 ** 返回:     无
 ******************************************************/
+ (void)enterViewController:(NSString *)name {
    [[AnalysisManager sharedManager] enterView:name];
}

/******************************************************
 ** 功能:     退出页面
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
+ (void)exitViewController {
    [[AnalysisManager sharedManager] exitView];
}


/******************************************************
 ** 功能:     统计事件
 ** 参数:     eventId  --- 事件ID
 **           name    ---- 事件名称
 ** 返回:     无
 ******************************************************/
+ (void)event:(NSString *)eventId eventName:(NSString*)name {
    
   [[AnalysisManager sharedManager] event:eventId eventName:name];

}

/******************************************************
 ** 功能:     统计错误
 ** 参数:     summary       ---   错误摘要
 **          description    ---   错误详情
 ** 返回:     无
 ******************************************************/
+ (void)error:(NSString *)summary description:(NSString *)description {
    [[AnalysisManager sharedManager] error:summary description:description];
    
}

@end

/******************************************************
 * 模块名称:   AnalysisDataModeHelp.h
 * 模块功能:   统计分析数据模块扩展方法模块
 * 创建日期:   2012-09-26
 * 创建作者:   付大志
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>
#import "AnalysisDataModels.h"

// 子服务器数据结构
@interface AnalysisDataModel_SubServer (AnalysisDataModel_SubServerCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_SubServer *)fromJsonObject:(id)jsonObj;
@end

// 统计分析记录全部数据
@interface AnalysisDataModel_Array (AnalysisDataModel_ArrayCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_Array *)fromJsonObject:(id)jsonObj;
@end

// 统计分析当个记录表结果
@interface AnalysisDataModel (AnalysisDataModelCategory)
- (id)toJsonObject;
+ (AnalysisDataModel *)fromJsonObject:(id)jsonObj;
@end

//  应用相关数据模型  扩展方法
@interface AnalysisDataModel_Application (AnalysisDataModel_ApplicationCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_Application *)fromJsonObject:(id)jsonObj;
@end


//  终端信息对象 扩展方法
@interface AnalysisDataModel_Terminal (AnalysisDataModel_TerminalCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_Terminal *)fromJsonObject:(id)jsonObj;
@end

//  应用启动对象 扩展方法
@interface AnalysisDataModel_Launch (AnalysisDataModel_LaunchCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_Launch *)fromJsonObject:(id)jsonObj;
@end

//  应用启动对象 扩展方法
@interface AnalysisDataModel_Event (AnalysisDataModel_EventCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_Event *)fromJsonObject:(id)jsonObj;
@end

//  页面访问对象 扩展方法
@interface AnalysisDataModel_Visit (AnalysisDataModel_VisitCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_Visit *)fromJsonObject:(id)jsonObj;
@end

//  错误报告对象 扩展方法
@interface AnalysisDataModel_Error (AnalysisDataModel_ErrorCategory)
- (id)toJsonObject;
+ (AnalysisDataModel_Error *)fromJsonObject:(id)jsonObj;
@end


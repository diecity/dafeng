/******************************************************
 * 模块名称:   AnalysisConfig.m
 * 模块功能:   统计分析 参数配置模块
 * 创建日期:   2012-09-28
 * 创建作者:   付大志
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>
#import "AnalysisConfig.h"


//统计分析内部配置信息
//SDK版本
// 统计分析当前版本
#define AnalysisConfig_SdkVersion   @"1.0"

 // 上传类型KEY
#define AnalysisConfig_UpLoadType   @"AnalysisConfig_UpLoadType" 

// 日志存储 文件名
#define AnalysisConfig_FileName     @"AnalysisConfigFileName"      

// 自服务器日志存储 文件名
#define AnalysisConfig_FileNameSubServer  @"AnalysisConfigFileNameSubServer"

// 限制统计数据最大保存字节数，大于次数舍去
#define AnalysisConfig_FileSizeMax   4*1024*1024
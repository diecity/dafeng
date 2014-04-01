/******************************************************
 * 模块名称:   AnalysisUpLoad.h
 * 模块功能:   统计分析数据 上传模块
 * 创建日期:   2012-09-26
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>
#import "AnalysisDataModels.h"
typedef enum {
    HTTPType_Analysis= 0,    // 数据上传
    HTTPType_Ploy,           // 策略
} HTTPType_E;



@interface AnalysisUpLoad : NSObject {

    void (^_requestUpLoadTypeCallBack)(bool isSave, NSInteger ploy);
    AnalysisDataModel_Array  *_analysisDataModel_UnLaod;    // 需要上传的分析数据 
    NSString                 *_serverUrl;                   // 服务器地址
    NSString                 *_ployUrl;                     // 策略服务器url
    
                 
}
@property (nonatomic,retain) AnalysisDataModel_Array  *analysisDataModel_UnLaod;
@property (nonatomic,assign) bool                      is_upLoad;  // 是否正在上传
@property (nonatomic,retain) NSString                 *serverUrl;  
@property (nonatomic,retain) NSString                 *ployUrl;  


/******************************************************
 ** 方法功能: 添加需要下载数据  
 ** 参数:    analysisDataModel --- 单个完整分析数据
 ** 返回:    添加 成功 失败
 ******************************************************/
- (bool) addUpLoaData:(AnalysisDataModel*) analysisDataModel;

/******************************************************
 ** 方法功能: 启动上传所有分析数据
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)startUpLoadAnalysis;

/******************************************************
 ** 方法功能:  设置上传类型修改回调函数
 ** 参数:     callback --- 成功回调
 ** 返回:     无
 ******************************************************/
-(void)setRequestUpLoadTypeCallback:(void(^)(bool isSave, NSInteger ploy))callback;

/******************************************************
 ** 方法功能: 启动请求上传类型
 ** 参数:     appKey   ---  应用标识
 ** 返回:     无
 ******************************************************/
-(void)startRequestUpLoadType:(NSString *)appKey ;
@end

/******************************************************
 * 模块名称:   AnalysisUpLoadSub.h
 * 模块功能:   统计分析数据 子服务器上传模块
 * 创建日期:   2012-10-16
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>
#import "AnalysisDataModels.h"



@interface AnalysisUpLoadSub : NSObject {

    // 子类型AnalysisDataModel_SubServer
    NSMutableArray  *_analysisDataModel_UnLaodSub;    // 需要上传的分析数据  
                 
}
@property (nonatomic,retain) NSMutableArray  *analysisDataModel_UnLaodSub;

/******************************************************
 ** 功能:     启动应用
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)appLaunched ;

/******************************************************
 ** 功能:     退出应用
 ** 参数:     dataModel   ---  一个统计完整数据
 **           urlString    ---  子服务器地址，NSString类型
 ** 返回:     无
 ******************************************************/
- (void)appTerminated:(AnalysisDataModel *)dataModel subUrl:(NSMutableArray*) urlString ;
@end

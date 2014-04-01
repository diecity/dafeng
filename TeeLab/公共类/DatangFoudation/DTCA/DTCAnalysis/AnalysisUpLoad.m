/******************************************************
 * 模块名称:   AnalysisUpLoad.m
 * 模块功能:   统计分析数据 上传模块
 * 创建日期:   2012-09-26
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/


#import "ASIHTTPRequest.h"
#import "ASIDataCompressor.h"
#import "NSDataAdditions.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "SBJson.h"

#import "AnalysisConfig.h"
#import "AnalysisManager.h"
#import "AnalysisDataModels.h"
//#import "AnalysisDataModelsHelper.h"
#import "AnalysisUpLoad.h"


@implementation AnalysisUpLoad

@synthesize analysisDataModel_UnLaod = _analysisDataModel_UnLaod;
@synthesize is_upLoad ;
@synthesize serverUrl =  _serverUrl;
@synthesize ployUrl   =  _ployUrl;
- (id)init {
    if (self = [super init]) {
        _analysisDataModel_UnLaod = [[AnalysisDataModel_Array alloc] init];
    }
    self.is_upLoad = NO;
    return self;
}


- (void)dealloc {
    [_analysisDataModel_UnLaod release];
    [_requestUpLoadTypeCallBack release];
    [_serverUrl release];
    [_ployUrl release];
    [super dealloc];
}

/******************************************************
 ** 方法功能: 添加需要下载数据  
 ** 参数:    analysisDataModel --- 单个完整分析数据
 ** 返回:    添加 成功 失败
 ******************************************************/
- (bool) addUpLoaData:(AnalysisDataModel*) analysisDataModel {
    if (_analysisDataModel_UnLaod == nil) {
        _analysisDataModel_UnLaod = [[[_analysisDataModel_UnLaod alloc] init] autorelease];
    }
    NSString *state;
    state = [AnalysisManager networkState];
    if([state isEqualToString:@""]) return NO;     // 有网络才去下载
    if(self.is_upLoad == YES) return NO;
    // 自己接管 自动释放
//    AnalysisDataModel *tmp = [[[AnalysisDataModel alloc] init] autorelease];
//    [tmp copy:analysisDataModel];

    [_analysisDataModel_UnLaod.analysisDataModel addObject:analysisDataModel];
    

    [self startUpLoadAnalysis ];
    return YES;
    
}
#pragma mark 数据发送处理

/******************************************************
 ** 方法功能: 启动上传所有分析数据
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)startUpLoadAnalysis {
    NSString *state;
//    state = [AnalysisManager networkState];
//    if([state isEqualToString:@""]) {
//        NSLog(@"startUpLoadAnalysis->no net");
//       return ;     // 有网络才去下载  
//    }
    
    if(_analysisDataModel_UnLaod == nil) {
        NSLog(@"startUpLoadAnalysis->_analysisDataModel_UnLaod = nil");
        return;
    }
   
    if(_analysisDataModel_UnLaod.analysisDataModel == nil)  {
        NSLog(@"startUpLoadAnalysis->analysisDataModel = nil");
        return;
    }

    if([_analysisDataModel_UnLaod.analysisDataModel count] <= 0) {
        NSLog(@"startUpLoadAnalysis->analysisDataModel <= 0");
        return;
    }

        
    if(_serverUrl == nil) {
        NSLog(@"startUpLoadAnalysis->noSet ServerUrl");
        return;
    }
    // 发送数据
    id jsonObj = [_analysisDataModel_UnLaod toJsonObject];
   
    SBJsonWriter *writer = [[[SBJsonWriter alloc] init] autorelease];
    NSString *jsonStr = [writer stringWithObject:jsonObj];
    NSLog(@"\n*********************\n");
    NSLog(@"startUpLoadAnalysis->%@", jsonStr);
    NSLog(@"\n*********************\n");
    //zip 压缩
    NSData *bytes = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *zipErr = nil;
    
  //  NSData *zipBytes = [ASIDataCompressor compressData:bytes error:&zipErr];
    
    // base64
    NSString *base64String = bytes.base64Encoding;

    NSData * sendData = [base64String dataUsingEncoding:NSUTF8StringEncoding];
   
    if (sendData != nil && zipErr == nil) {
        NSURL *url = [NSURL URLWithString:_serverUrl];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        request.tag = HTTPType_Analysis;
        [request setDelegate:self];
        //[request setAllowCompressedResponse:YES];
        [request setRequestMethod:@"POST"];
        //[request addRequestHeader:@"Content-Encoding" value:@"gzip"];
        [request appendPostData:sendData];
        
        [request setTimeOutSeconds:30];
        [request setNumberOfTimesToRetryOnTimeout:3];
        
        [request startAsynchronous];
        self.is_upLoad = YES;
    }
}

/******************************************************
 ** 方法功能: 启动请求上传类型
 ** 参数:     appKey   ---  应用标识
 ** 返回:     无
 ******************************************************/
-(void)startRequestUpLoadType:(NSString *)appKey{

    if(_serverUrl == nil) {
        NSLog(@"startUpLoadAnalysis->noSet ServerUrl");
        return;
    }
    NSString *strUrl = [NSString stringWithFormat:_ployUrl, appKey]; 
    NSURL *url = [NSURL URLWithString:strUrl];
     //NSURL *url = [NSURL URLWithString:@"http://192.168.1.230:60000?1234555"];
 
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.tag = HTTPType_Ploy;
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    
    [request setTimeOutSeconds:30];
    [request setNumberOfTimesToRetryOnTimeout:3];
    
    [request startAsynchronous];

}

/******************************************************
 ** 方法功能:  设置上传类型修改回调函数
 ** 参数:     callback --- 成功回调
 ** 返回:     无
 ******************************************************/
-(void)setRequestUpLoadTypeCallback:(void(^)(bool isSave, NSInteger ploy))callback {
    
    [callback release];
    _requestUpLoadTypeCallBack = [callback copy];
    
}

/******************************************************
 ** 方法功能:  上传成功代理
 ** 参数:     request --- 联网句柄
 ** 返回:     无
 ******************************************************/
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];

    NSLog(@" http finished:%@", responseString);


    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSDictionary *json = [parser objectWithString:responseString];

    if(request.tag == HTTPType_Ploy) {          // 策略
        
        NSLog(@" http finished->flag = HTTPType_Ploy");
        if(_requestUpLoadTypeCallBack != nil) {
            NSInteger ployValue;
            NSString  *ploy = [json objectForKey:@"ploy"];
            NSLog(@" http finished->ploy = %@",ploy);
            if(ploy.integerValue == 1)  {
                NSLog(@" http finished->ploy = AnalysisUpLoadType_Lanuch");
                ployValue = AnalysisUpLoadType_Lanuch;
            } else {
                NSLog(@" http finished->ploy = AnalysisUpLoadType_Immediately");
                ployValue = AnalysisUpLoadType_Immediately;                
            }
            _requestUpLoadTypeCallBack(YES, ployValue);
        }
    } else if(request.tag == HTTPType_Analysis ){
         NSLog(@" http finished->flag = HTTPType_Analysis");
         self.is_upLoad = NO;
         NSString  *status = [json objectForKey:@"status"];
         if(status != nil && [status isEqual:@"0"]) {
            // 清空之前的数据
             [_analysisDataModel_UnLaod release];
            _analysisDataModel_UnLaod = [[AnalysisDataModel_Array alloc] init];
        }
    }
}

/******************************************************
 ** 方法功能:  上传失败代理
 ** 参数:     request --- 联网句柄
 ** 返回:     无
 ******************************************************/
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"http error:%@", error);

    
    if(request.tag == HTTPType_Ploy) {          // 策略
        
    } else {
        self.is_upLoad = NO;
    }
    // 联网异常改成启动上传策略
    if(_requestUpLoadTypeCallBack != nil) {
        _requestUpLoadTypeCallBack(NO, AnalysisUpLoadType_Lanuch);
    }
}

@end

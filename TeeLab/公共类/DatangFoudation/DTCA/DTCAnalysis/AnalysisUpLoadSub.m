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


#import "ASIHTTPRequest.h"
#import "ASIDataCompressor.h"
#import "NSDataAdditions.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "SBJson.h"

#import "AnalysisConfig.h"
#import "AnalysisManager.h"
#import "AnalysisDataModels.h"
//#import "AnalysisDataModelsHelper.h"
#import "AnalysisUpLoadSub.h"


@implementation AnalysisUpLoadSub

@synthesize analysisDataModel_UnLaodSub = _analysisDataModel_UnLaodSub;


- (id)init {
    if (self = [super init]) {
        _analysisDataModel_UnLaodSub = [[NSMutableArray alloc] init];
    }

    return self;
}


- (void)dealloc {
    [_analysisDataModel_UnLaodSub release];
    [super dealloc];
}

/******************************************************
 ** 功能:     启动应用
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)appLaunched {

    // 初始化数组
    self.analysisDataModel_UnLaodSub = [[[NSMutableArray alloc] init] autorelease];
    // 把保存数据取出来
    NSString *data = [AnalysisUpLoadSub getAnalysisSubServerData];
    if (data != nil) {
        SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
        id jsonObj = [parser objectWithString:data];
        if (jsonObj != nil) {

//            NSDictionary *json = jsonObj;
    
            NSArray *analysisDataModel_SubServer = jsonObj;
            NSUInteger count = [analysisDataModel_SubServer count];
            for (NSUInteger i = 0; i < count; ++i) {
                AnalysisDataModel_SubServer *obj = [analysisDataModel_SubServer objectAtIndex:i];
                [_analysisDataModel_UnLaodSub addObject:[AnalysisDataModel_SubServer fromJsonObject:obj]];
            }
            // 启动发送
            [self startUpLoadAnalysis];
        }
    } 

}

/******************************************************
 ** 功能:     退出应用
 ** 参数:     dataModel   ---  一个统计完整数据
 **           urlString    ---  子服务器地址，NSString类型
 ** 返回:     无
 ******************************************************/
- (void)appTerminated:(AnalysisDataModel *)dataModel subUrl:(NSMutableArray*) urlString{
     AnalysisDataModel_SubServer *subServer = [[[AnalysisDataModel_SubServer alloc] init] autorelease];
     subServer.subServerUrl = urlString;
     [subServer.analysisDataModel_Array.analysisDataModel addObject:dataModel];
    [_analysisDataModel_UnLaodSub addObject:subServer];
    // 事件
    NSInteger count = [_analysisDataModel_UnLaodSub count];
    NSMutableArray *JsonObj = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; ++i) {
        AnalysisDataModel_SubServer *obj = [_analysisDataModel_UnLaodSub objectAtIndex:i];
        [JsonObj addObject:[obj toJsonObject]];
    }
    SBJsonWriter *writer = [[[SBJsonWriter alloc] init] autorelease];
    NSString *data = [writer stringWithObject:JsonObj];
    [AnalysisUpLoadSub saveAnalysisSubServerData:data];
}


#pragma mark 数据发送处理

/******************************************************
 ** 方法功能: 启动上传所有分析数据
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
- (void)startUpLoadAnalysis {

    NSString *state;
    state = [AnalysisManager networkState];
    if([state isEqualToString:@""]) return ;     // 有网络才去下载
    

    NSString *serverUrlStr;
    AnalysisDataModel_SubServer *subServer;
    // 发送数据;
    if([_analysisDataModel_UnLaodSub count] == 0) return;   // 无数据
    subServer  =  [_analysisDataModel_UnLaodSub objectAtIndex:0];

    serverUrlStr  =  [subServer.subServerUrl objectAtIndex:0];
    //取出需要发送数据
    id jsonObj = [subServer.analysisDataModel_Array toJsonObject];
   
    SBJsonWriter *writer = [[[SBJsonWriter alloc] init] autorelease];
    NSString *jsonStr = [writer stringWithObject:jsonObj];
    NSLog(@"\n%%%%%%%%%%%%%%%%%%%%%\n");
    NSLog(@"startUpLoadAnalysis sub->%@", jsonStr);
    NSLog(@"\n%%%%%%%%%%%%%%%%%%%%%\n");
    //zip 压缩
    NSData *bytes = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *zipErr = nil;
    
    NSData *zipBytes = [ASIDataCompressor compressData:bytes error:&zipErr];
    
    // base64
    NSString *base64String = zipBytes.base64Encoding;
   
    NSData * sendData = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    
    if (sendData != nil && zipErr == nil) {
        NSURL *url = [NSURL URLWithString:serverUrlStr];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        request.tag = HTTPType_Analysis;
        [request setDelegate:self];
        [request setRequestMethod:@"POST"];
        //[request addRequestHeader:@"Content-Encoding" value:@"deflate"];
        [request appendPostData:sendData];
        
        [request setTimeOutSeconds:30];
        [request setNumberOfTimesToRetryOnTimeout:3];
        [request startAsynchronous];
    }
}

/******************************************************
 ** 方法功能:  上传成功代理
 ** 参数:     request --- 联网句柄
 ** 返回:     无
 ******************************************************/
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"CPA http finished:%@", responseString);

    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSDictionary *json = [parser objectWithString:responseString];
    
    NSString  *status = [json objectForKey:@"status"];
    if(status != nil && [status isEqual:@"0"]) {
        AnalysisDataModel_SubServer *subServer;
        subServer  =  [_analysisDataModel_UnLaodSub objectAtIndex:0];
        [subServer.subServerUrl removeObjectAtIndex:0]; // 删除已上传完的服务器记录
        if([subServer.subServerUrl count] == 0){        // 子服务器已发完
            [_analysisDataModel_UnLaodSub removeObjectAtIndex:0];
        }
        
        if([_analysisDataModel_UnLaodSub count] != 0) {  //有继续上传
            [self startUpLoadAnalysis];
        } else {
            [AnalysisUpLoadSub DelAnalysisSubServerData];             // 删除文件数据
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
    // 在网络正常情况下 上传失败 直接丢弃，传下一个
    AnalysisDataModel_SubServer *subServer;
    subServer  =  [_analysisDataModel_UnLaodSub objectAtIndex:0];
    [subServer.subServerUrl removeObjectAtIndex:0]; // 删除已上传完的服务器记录
    if([subServer.subServerUrl count] == 0){        // 子服务器已发完
        [_analysisDataModel_UnLaodSub removeObjectAtIndex:0];
    }
    
    if([_analysisDataModel_UnLaodSub count] != 0) {  //有继续上传
        [self startUpLoadAnalysis];
    } else {
        [AnalysisUpLoadSub DelAnalysisSubServerData];             // 删除文件数据
    }

    // 失败停止上传
}
/******************************************************
 ** 功能:     得到文件缓存 子服务器统计分析数据
 ** 参数:     无
 ** 返回:     分析数据
 ******************************************************/
+ (NSString *)getAnalysisSubServerData {
    
      NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSString *documentsDirectory= [NSHomeDirectory() 
                                   stringByAppendingPathComponent:@"Documents"];
    
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    NSString *path = [documentsDirectory stringByAppendingPathComponent:AnalysisConfig_FileNameSubServer];
    
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
 ** 功能:     保存 子服务器统计分析数据
 ** 参数:     分析数据
 ** 返回:     无
 ******************************************************/
+ (void)saveAnalysisSubServerData:(NSString *)data {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSString *documentsDirectory= [NSHomeDirectory() 
                                   stringByAppendingPathComponent:@"Documents"];
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    NSString *path = [documentsDirectory stringByAppendingPathComponent:AnalysisConfig_FileNameSubServer];
    [fileManager removeItemAtPath:path error:nil];
    NSError *error;
    //[data writeToFile:path atomically:YES];
    [data writeToFile:(NSString *)path atomically:YES encoding:NSUTF8StringEncoding error:&error];
}
/******************************************************
 ** 功能:     删除 子服务器统计分析数据
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
+ (void)DelAnalysisSubServerData {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSString *documentsDirectory= [NSHomeDirectory() 
                                   stringByAppendingPathComponent:@"Documents"];
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    NSString *path = [documentsDirectory stringByAppendingPathComponent:AnalysisConfig_FileNameSubServer];
    [fileManager removeItemAtPath:path error:nil];
    

}
@end

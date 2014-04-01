/******************************************************
 *标题:         数据库操作类
 *创建人:        闫燕
 *创建日期:      13-5-28
 *功能及说明:    集合了数据库相关各增、删、改、查操作方法。
 *
 *修改记录列表:
 *修改记录:
 *修改日期:
 *修改者:
 *修改内容简述:
 *********************************************************/

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "Define.h"

//modle
#import "Photo.h"
#import "PluginInfo.h"
#import "WeatherInfo.h"




@interface DataBase : NSObject
{
    NSString                *_dbPath;
    FMDatabaseQueue         *_queue;
}

+(DataBase*) sharedDataBase;

#pragma mark- insert
/*****************************************
 功能：插入一条照片数据
 参数：照片model
 返回：无
 ********************************************/
- (void)insertPhoto:(Photo*)photo;

/*******************************************
 功能：插入一条文字内容数据
 参数：nsstring（文字内容），nsstring（唯一标识key），nsstring（更新时间）
 返回：无
 ********************************************/
- (void)insertContent:(NSString*)content key:(NSString*)key andUpdateTime:(NSString*)updateTime;

/*******************************************
 功能：插入一条插件数据
 参数：PluginInfo（插件信息）
 返回：无
 ********************************************/
- (void)insertPlugin:(PluginInfo*)plugin;


#pragma mark- select
#pragma mark- 查照片
/*******************************************
 功能：根据报案号和照片类型从数据库查出照片
 参数：nsstring（报案号），nsstring（照片类型）
 返回：nsarray（照片model的数组）
 ********************************************/
- (NSArray*)selectPhotoWithReportNum:(NSString*)reportNum type:(NSString*)type andMark:(NSString*)mark;

/*******************************************
 功能：根据报案号从数据库查出照片
 参数：nsstring（报案号）
 返回：nsarray（照片model的数组）
 ********************************************/
- (NSArray*)selectPhotoWithReportNum:(NSString*)reportNum andMark:(NSString*)mark;

/*******************************************************************
 功能：根据标识从数据库查出照片
 参数：NSString（查勘照片／理赔照片））
 返回：nsarray（照片model的数组）
 ******************************************************************/
- (NSArray*)selectPhotoWithMark:(NSString *)mark;

/*******************************************************************
 功能：根据报案号\mark\上传状态从数据库查出照片
 参数：nsstring（报案号）
 返回：nsarray（照片model的数组）
 ******************************************************************/
- (NSArray*)selectPhotoWithReportNum:(NSString*)reportNum mark:(NSString *)mark andUploadStatus:(NSString*)uploadStatus;

#pragma mark- 查文字
/*******************************************************************
 功能：根据key值，查对应的文字内容
 参数：nsstring（key值）
 返回：nsstring（文字内容）
 ******************************************************************/
- (NSString*)selectContentByKey:(NSString*)key;
/*******************************************************************
 功能：根据key值，查找更新时间
 参数：nsstring（key值）
 返回：nsstring（更新时间） 空时返回nil
 ******************************************************************/
- (NSString*)selectUpdateTimeByKey:(NSString*)key;

/*******************************************************************
 功能：根据type值，选出插件
 参数：nsstring（type值）
 返回：nsarray（所有符合条件的plugin）
 ******************************************************************/
- (NSArray*)selectPluginByType:(NSString*)type;

/*******************************************************************
 功能：选出全部插件
 参数：无
 返回：nsarray（所有符合条件的plugin）
 ******************************************************************/
- (NSArray*)selectAllPlugin;

#pragma mark- 更新
/*******************************************************************
 功能：更新照片上传状态
 参数：nsstring（照片状态）
 返回：无
 ******************************************************************/
- (void)updatePhoto:(Photo*)photo withUploadStatus:(NSString*)status;

/*******************************************************************
 功能：更新文字内容的 内容和更新时间
 参数：nsstring（文字内容）， nsstring（更新时间）,nsstring（唯一标识）
 返回：无
 ******************************************************************/
- (void)updateContent:(NSString*)content updateTime:(NSString*)time byKey:(NSString*)key;

#pragma mark- 更新插件
/*******************************************************************
 功能：更新插件
 参数：pluginInfo
 返回：无
 ******************************************************************/
- (void)updatePlugin:(PluginInfo*)plugin;

#pragma mark- 删除
/*******************************************************************
 功能：删除照片
 参数：NSString（路径）
 返回：无
 ******************************************************************/
-(void)deletePhotoByPath:(NSString*)path;

@end



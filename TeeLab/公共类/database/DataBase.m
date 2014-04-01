
//  DataBase.m
//  cninsureClient
//
//  Created by cloudpower on 13-5-28.
//  Copyright (c) 2013年 cloudpower. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase

#define DATABASE_NAME @"minan.db"    ////改为minan.bd 清除原来的tp
//数据库照片表
#define TABLE_PHOTO @"photo"
#define CREATE_PHOTO_TABLE @"CREATE TABLE photo (_id INTEGER PRIMARY KEY AUTOINCREMENT,reportNum TEXT,createTime TEXT,message TEXT,path TEXT,type TEXT, uploadStatus TEXT, mark TEXT, fileName TEXT,orig TEXT)"
// reportNum, createTime, message, path, type
//增加字段，存储照片拍照时候的属性，是横拍还是竖排？ 1 横排，0，竖排 by dujw
//数据库文字内容更新表
#define TABLE_UPDATE_TEXT @"update_text"
#define CREATE_UPDATE_TEXT_TABLE @"CREATE TABLE update_text (_id INTEGER PRIMARY KEY AUTOINCREMENT,contentKey TEXT,content TEXT,updateTime TEXT)"

//数据库插件表
#define TABLE_PLUGIN @"plugin"
#define CREATE_PLUGIN_TABLE @"CREATE TABLE plugin (_id INTEGER PRIMARY KEY AUTOINCREMENT,key TEXT,pluginName TEXT,updateTime TEXT,version TEXT, hostUrl TEXT, localZipUrl TEXT, localFolderUrl TEXT, imageName TEXT, startPageName TEXT, type TEXT, status TEXT)"
//key, pluginName, updateTime, version, hostUrl, localZipUrl, localFolderUrl, imageName, startPageName, type, status




////数据库天气预报缓存
//#define TABLE_WEATHER @"weather"
//#define CREATE_WEATHER_TABLE @"CREATE TABLE weather (_id INTEGER PRIMARY KEY AUTOINCREMENT,cityName TEXT,date TEXT,weekDay TEXT,carWash TEXT, temp TEXT, weather TEXT, imgName TEXT, updateTime TEXT)"
////cityName date weekDay carWash temp weather imgName updateTime




static DataBase *myDB = nil;
+(DataBase*) sharedDataBase
{
    @synchronized(self)
    {
        if (myDB == nil)
        {
            myDB = [[DataBase alloc] init];
        }
    }
    
    return myDB;
}


- (id)init
{
    self = [super init];
    if(nil != self)
    {
        NSURL *appUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        _dbPath = [[NSString alloc] initWithFormat:@"%@",[[appUrl path] stringByAppendingPathComponent:DATABASE_NAME]];
        
        [self loadDB];//创建数据库
        [self checkTable];//创建表
    }
    return self;
}


//读取数据库－－创建数据库
-(void)loadDB
{
    _queue = [[FMDatabaseQueue alloc] initWithPath:_dbPath];
}
//创建表
-(void) checkTable
{
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
        //用户表不存在则创建
         if(![db tableExists: TABLE_PHOTO])//消息表
         {
            [db executeUpdate:CREATE_PHOTO_TABLE];
         }
         if (![db tableExists:TABLE_UPDATE_TEXT])//文字内容更新表
         {
             [db executeUpdate:CREATE_UPDATE_TEXT_TABLE];
         }
//         if (![db tableExists:TABLE_WEATHER]) {
//             [db executeUpdate:CREATE_WEATHER_TABLE];
//         }
     }];
}




#pragma mark- 增
/*******************************************
 功能：插入一条照片数据
 参数：照片model
 返回：无
 ********************************************/
- (void)insertPhoto:(Photo*)photo{
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"INSERT INTO photo (reportNum,createTime,message,path,type,uploadStatus,mark,fileName,orig) VALUES (?,?,?,?,?,?,?,?,?)",
          photo.reportNum,
          photo.createTime,
          photo.message,
          photo.path,
          photo.type,
          photo.uploadStatus,
          photo.mark,
          photo.fileName,
          photo.orig
          ];
     }];
}

/*******************************************
 功能：插入一条文字内容数据
 参数：nsstring（文字内容），nsstring（唯一标识key），nsstring（更新时间）
 返回：无
 ********************************************/
- (void)insertContent:(NSString*)content key:(NSString*)key andUpdateTime:(NSString*)updateTime{
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"INSERT INTO update_text (content,contentKey,updateTime) VALUES (?,?,?)",
          content,
          key,
          updateTime
          ];
     }];
}


/*******************************************
 功能：插入一条插件数据
 参数：PluginInfo（插件信息）
 返回：无
 ********************************************/
- (void)insertPlugin:(PluginInfo*)plugin{
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"INSERT INTO plugin (key,pluginName,updateTime, version, hostUrl, localZipUrl, localFolderUrl, imageName, startPageName, type, status) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
          plugin.key,
          plugin.pluginName,
          plugin.updateTime,
          plugin.version,
          plugin.hostUrl,
          plugin.localZipUrl,
          plugin.localFolderUrl,
          plugin.imageName,
          plugin.startPageName,
          plugin.type,
          plugin.status
          ];
     }];
}

/*******************************************
 功能：插入一条天气数据
 参数：PluginInfo（插件信息）
 返回：无
 ********************************************/
//- (void)insertWeather:(WeatherInfo*)weather{
//    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
//     {
//         [db executeUpdate:@"INSERT INTO weather (cityName,date,weekDay, carWash, temp, weather, imgName, updateTime) VALUES (?,?,?,?,?,?,?,?)",
//          weather.cityName,
//          weather.date,
//          [weather.weekDay objectAtIndex:0],
//          weather.
//          weather.carWashf
//          ];     
//     }];
//}



#pragma mark- 查
/*******************************************
 功能：根据报案号和照片类型和标识从数据库查出照片
 参数：nsstring（报案号），nsstring（照片类型），NSString（查勘照片／理赔照片）
 返回：nsarray（照片model的数组）
 ********************************************/
- (NSArray*)selectPhotoWithReportNum:(NSString*)reportNum type:(NSString*)type andMark:(NSString *)mark{
    __block NSMutableArray *res = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM photo WHERE reportNum = '%@' and mark = '%@' and type = '%@'",reportNum, mark, type];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             Photo *photo = [[[Photo alloc] init] autorelease];
             [photo setPath:[rs stringForColumn:@"path"]];
             [photo setReportNum:[rs stringForColumn:@"reportNum"]];
             [photo setType:[rs stringForColumn:@"type"]];
             [photo setMessage:[rs stringForColumn:@"message"]];
             [photo setCreateTime:[rs stringForColumn:@"createTime"]];
             [photo setUploadStatus:[rs stringForColumn:@"uploadStatus"]];
             [photo setMark:[rs stringForColumn:@"mark"]];
             [photo setFileName:[rs stringForColumn:@"fileName"]];
             [photo setOrig:[rs stringForColumn:@"orig"]];
             [res addObject:photo];
         }
         [rs close];
     }];
    return res;
}

/*******************************************************************
 功能：根据报案号、标识从数据库查出照片
 参数：nsstring（报案号），NSString（查勘照片／理赔照片）
 返回：nsarray（照片model的数组）
 ******************************************************************/
- (NSArray*)selectPhotoWithReportNum:(NSString*)reportNum andMark:(NSString *)mark{
    __block NSMutableArray *res = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM photo WHERE reportNum = '%@' and mark = '%@'" ,reportNum,mark];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             Photo *photo = [[[Photo alloc] init] autorelease];
             [photo setPath:[rs stringForColumn:@"path"]];
             [photo setReportNum:[rs stringForColumn:@"reportNum"]];
             [photo setType:[rs stringForColumn:@"type"]];
             [photo setMessage:[rs stringForColumn:@"message"]];
             [photo setCreateTime:[rs stringForColumn:@"createTime"]];
             [photo setUploadStatus:[rs stringForColumn:@"uploadStatus"]];
             [photo setMark:[rs stringForColumn:@"mark"]];
             [photo setFileName:[rs stringForColumn:@"fileName"]];
              [photo setOrig:[rs stringForColumn:@"orig"]];
             [res addObject:photo];
         }
         [rs close];
     }];
    return res;
}

/*******************************************************************
 功能：根据标识从数据库查出照片
 参数：NSString（查勘照片／理赔照片））
 返回：nsarray（照片model的数组）
 ******************************************************************/
- (NSArray*)selectPhotoWithMark:(NSString *)mark{
    __block NSMutableArray *res = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM photo WHERE mark = '%@'" ,mark];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             Photo *photo = [[[Photo alloc] init] autorelease];
             [photo setPath:[rs stringForColumn:@"path"]];
             [photo setReportNum:[rs stringForColumn:@"reportNum"]];
             [photo setType:[rs stringForColumn:@"type"]];
             [photo setMessage:[rs stringForColumn:@"message"]];
             [photo setCreateTime:[rs stringForColumn:@"createTime"]];
             [photo setUploadStatus:[rs stringForColumn:@"uploadStatus"]];
             [photo setMark:[rs stringForColumn:@"mark"]];
             [photo setFileName:[rs stringForColumn:@"fileName"]];
              [photo setOrig:[rs stringForColumn:@"orig"]];
             [res addObject:photo];
         }
         [rs close];
     }];
    return res;
}


/*******************************************************************
 功能：根据报案号\mark\上传状态从数据库查出照片
 参数：nsstring（报案号）
 返回：nsarray（照片model的数组）
 ******************************************************************/
- (NSArray*)selectPhotoWithReportNum:(NSString*)reportNum mark:(NSString *)mark andUploadStatus:(NSString*)uploadStatus{
    __block NSMutableArray *res = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM photo WHERE reportNum = '%@' and mark = '%@' and uploadStatus = '%@'" ,reportNum,mark,uploadStatus];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             Photo *photo = [[[Photo alloc] init] autorelease];
             [photo setPath:[rs stringForColumn:@"path"]];
             [photo setReportNum:[rs stringForColumn:@"reportNum"]];
             [photo setType:[rs stringForColumn:@"type"]];
             [photo setMessage:[rs stringForColumn:@"message"]];
             [photo setCreateTime:[rs stringForColumn:@"createTime"]];
             [photo setUploadStatus:[rs stringForColumn:@"uploadStatus"]];
             [photo setMark:[rs stringForColumn:@"mark"]];
             [photo setFileName:[rs stringForColumn:@"fileName"]];
              [photo setOrig:[rs stringForColumn:@"orig"]];
             [res addObject:photo];
         }
         [rs close];
     }];
    return res;
}


/*******************************************************************
 功能：根据key值，查对应的文字内容
 参数：nsstring（key值）
 返回：nsstring（文字内容） 空时返回nil
 ******************************************************************/
- (NSString*)selectContentByKey:(NSString*)key{
    __block NSString *str = nil;

    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM update_text WHERE contentKey = '%@'",key];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             
             str = [[[NSString alloc] initWithString:[rs stringForColumn:@"content"]] autorelease];
         }
         [rs close];
     }];
    return str;
}

/*******************************************************************
 功能：根据key值，查找更新时间
 参数：nsstring（key值）
 返回：nsstring（更新时间） 空时返回nil
 ******************************************************************/
- (NSString*)selectUpdateTimeByKey:(NSString*)key{
    __block NSString *str = nil;
    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM update_text WHERE contentKey = '%@'",key];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             str = [[[NSString alloc] initWithString:[rs stringForColumn:@"updateTime"]] autorelease];
         }
         [rs close];
     }];
    return str;
}


/*******************************************************************
 功能：根据type值，选出插件
 参数：nsstring（type值）
 返回：nsarray（所有符合条件的plugin）
 ******************************************************************/
- (NSArray*)selectPluginByType:(NSString*)type{
    __block NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM plugin WHERE type = '%@'",type];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             PluginInfo *plugin = [[PluginInfo alloc] init];
             plugin.key = [rs stringForColumn:@"key"];
             plugin.pluginName = [rs stringForColumn:@"pluginName"];
             plugin.updateTime = [rs stringForColumn:@"updateTime"];
             plugin.version = [rs stringForColumn:@"version"];
             plugin.hostUrl = [rs stringForColumn:@"hostUrl"];
             plugin.localZipUrl = [rs stringForColumn:@"localZipUrl"];
             plugin.localFolderUrl = [rs stringForColumn:@"localFolderUrl"];
             plugin.imageName = [rs stringForColumn:@"imageName"];
             plugin.startPageName = [rs stringForColumn:@"startPageName"];
             plugin._id = [rs stringForColumn:@"_id"];
             plugin.status = [rs stringForColumn:@"status"];
             [array addObject:plugin];
             [plugin release];
         }
         [rs close];
     }];
    return array;
}

/*******************************************************************
 功能：选出全部插件
 参数：无
 返回：nsarray（所有符合条件的plugin）
 ******************************************************************/
- (NSArray*)selectAllPlugin{
    __block NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    [_queue inDatabase:^(FMDatabase *db)
     {
         FMResultSet *rs = nil;
         NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM plugin"];
         rs = [db executeQuery:SQL];
         while ([rs next])
         {
             PluginInfo *plugin = [[PluginInfo alloc] init];
             plugin.key = [rs stringForColumn:@"key"];
             plugin.pluginName = [rs stringForColumn:@"pluginName"];
             plugin.updateTime = [rs stringForColumn:@"updateTime"];
             plugin.version = [rs stringForColumn:@"version"];
             plugin.hostUrl = [rs stringForColumn:@"hostUrl"];
             plugin.localZipUrl = [rs stringForColumn:@"localZipUrl"];
             plugin.localFolderUrl = [rs stringForColumn:@"localFolderUrl"];
             plugin.imageName = [rs stringForColumn:@"imageName"];
             plugin.startPageName = [rs stringForColumn:@"startPageName"];
             plugin._id = [rs stringForColumn:@"_id"];
             plugin.status = [rs stringForColumn:@"status"];
             [array addObject:plugin];
             [plugin release];
         }
         [rs close];
     }];
    return array;
}


#pragma mark- 更新
#pragma mark- 更新照片
/*******************************************************************
 功能：更新照片上传状态
 参数：nsstring（照片状态）
 返回：无
 ******************************************************************/
- (void)updatePhoto:(Photo*)photo withUploadStatus:(NSString*)status{
    
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         NSString *SQL = NULL;         
         SQL = [NSString stringWithFormat:@"UPDATE photo SET uploadStatus = '%@' where path = '%@'",status, photo.path];
         [db executeUpdate:SQL];
     }];
}


#pragma mark- 更新文字内容
/*******************************************************************
 功能：更新文字内容的 内容和更新时间
 参数：nsstring（文字内容）， nsstring（更新时间）,nsstring（唯一标识）
 返回：无
 ******************************************************************/
- (void)updateContent:(NSString*)content updateTime:(NSString*)time byKey:(NSString*)key{
    
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         NSString *SQL = NULL;
         SQL = [NSString stringWithFormat:@"UPDATE update_text SET content = '%@', updateTime = '%@' where contentKey = '%@'",content, time, key];
         [db executeUpdate:SQL];
     }];
    
}

#pragma mark- 更新插件
/*******************************************************************
 功能：更新插件
 参数：pluginInfo
 返回：无
 ******************************************************************/
- (void)updatePlugin:(PluginInfo*)plugin{
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         NSString *SQL = NULL;
         SQL = [NSString stringWithFormat:@"UPDATE plugin SET key = '%@' and pluginName = '%@' and updateTime = '%@' and version = '%@' and hostUrl = '%@' and localZipUrl = '%@' and localFolderUrl = '%@' and imageName = '%@' and startPageName = '%@' and type = '%@' and status = '%@' where _id = '%@'",plugin.key, plugin.pluginName, plugin.updateTime, plugin.version, plugin.hostUrl, plugin.localZipUrl, plugin.localFolderUrl, plugin.imageName, plugin.startPageName, plugin._id, plugin.type, plugin.status];
        [db executeUpdate:SQL];
     }];
}



#pragma mark- 删除
/*******************************************************************
 功能：删除照片
 参数：NSString（路径）
 返回：无
 ******************************************************************/
-(void)deletePhotoByPath:(NSString*)path{
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         [db executeUpdate:@"DELETE FROM photo WHERE path = ?",
          path
          ];
     }];
}


@end

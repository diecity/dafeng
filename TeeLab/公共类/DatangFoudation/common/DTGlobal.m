//
//  DTGlobal.m
//  DTC_TK
//
//  Created by feng gang on 12-6-15.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "DTGlobal.h"
#import "JSONKit.h"
#import "SFHFKeychainUtils.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMResultSet.h"
@implementation DTGlobal

+ (void)showAlert:(NSString *)title message:(NSString *) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

+ (NSDictionary *)transferJSONToDic:(NSString *)str{
    
    return [self transferJSONToDic:str needHandle:NO];
}

+ (NSDictionary *)transferJSONToDic:(NSString *)str needHandle:(BOOL)handle{
    DLog(@"%@", str);
    JSONDecoder *decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    NSError *error = nil;
    
    id object = [decoder objectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] error:&error];
    if (error) {
        DLog(@"%@", error);
        error = nil;
        [DTGlobal showAlert:nil message:@"服务器返回数据错误!"];
        return nil;
    }
    if (handle) {
        //如果是字典的话
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary*  dict				= (NSDictionary*)object;
            NSDictionary*  ret				= [dict objectForKey:@"ret"];
            NSDictionary*  header			= [ret objectForKey:@"header"];
            NSDecimalNumber* retCode		= [header objectForKey:@"ret"];
            
            if ([retCode intValue] == 0) { //数据返回成功
                return ret;
            }else{ //数据返回失败失败或者异常情况
                NSString *retText          = [header objectForKey:@"text"];
                [DTGlobal showAlert:nil message:retText];
                return nil;
            }
        }else{ //json格式不正确
            [DTGlobal showAlert:nil message:@"服务器返回数据错误!"];
            return nil;
        }
    }
    return object;
}

+ (NSString *)hostAddress
{
    NSString *filePath          = [[NSBundle mainBundle] pathForResource:@"HTTPRequestAddress" ofType:@"plist"];
    NSDictionary *addressDic    = [NSDictionary dictionaryWithContentsOfFile:filePath];
    //取得IP地址
    NSNumber *hostIndexEnabled  = [addressDic objectForKey:@"hostIndexEnabled"];
    NSArray *hosts              = [addressDic objectForKey:@"hosts"];
    NSString *host              = [hosts objectAtIndex:[hostIndexEnabled intValue]];
    
    return host;
}

//返回写死在配置文件中的网络地址路径
+ (NSString *) requestAddress: (NSString *) addressType{
    NSString *filePath          = [[NSBundle mainBundle] pathForResource:@"HTTPRequestAddress" ofType:@"plist"];
    NSDictionary *addressDic    = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSString *host              = [self hostAddress];
    //取得请求的接口地址
    NSString *address           = [addressDic objectForKey:addressType];
    NSString *retAddress        = [NSString stringWithFormat:@"%@/%@" , host ,address];
    DLog(@"请求服务器地址为:%@",retAddress);
    
    return retAddress;
}

//返回在服务器中返回 的路径，比如图片的URL地址，下次请求时的服务器地址
+ (NSString *) getImageOrNextAddress: (NSString *) address{
    //取得IP地址
    NSString *host              = [self hostAddress];
    NSString *retAddress        = [NSString stringWithFormat:@"%@/%@" , host ,address];
    DLog(@"请求服务器地址为:%@",retAddress);
    return retAddress;
}

+ (NSDictionary *)readJSONFileToDic:(NSString *)str{
    NSString *cityFilePath = [[NSBundle mainBundle] pathForResource:str ofType:@"json"];
    NSError  *nsError        = nil;
    NSString *string         = [NSString stringWithContentsOfFile:cityFilePath encoding:NSUTF8StringEncoding error:&nsError];
    
    if (nsError != nil) {
        DLog(@"%@", nsError);
        nsError = nil;
        return nil;
    }
    return [self transferJSONToDic:string needHandle:NO];
}

//设置用户名密码和用户 id 
+ (BOOL)setSecureKey:(NSString *)object key:(NSString *)key{
    
    if ([key isEqualToString:@"autoLogin"]) {
        
        //设置是否自动登录
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
        return YES;
    }
    
    NSError *error = nil;
    BOOL flag = [SFHFKeychainUtils storeUsername:key andPassword:object forServiceName:@"dtcloud" updateExisting:YES error:&error ];
    if (error != nil) {
        error = nil;
    }
    return flag;
}

//取得保存的用户名和密码等信息
+ (NSString *)getSecureForKey:(NSString *)key{
    
    //取得是否自动登录,因为删除后安装,用私钥保存的数据不会删除,改为用这种处理方式
    if ([key isEqualToString:@"autoLogin"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"];
    }
    
    NSError *error = nil;
    NSString *str = [SFHFKeychainUtils getPasswordForUsername:key andServiceName:@"dtcloud" error:&error];
    if (error != nil) {
        error = nil;
    }
    return str;
}

//打开数据库，如果没有该数据库则创建之
+ (FMDatabase*)openDataBase
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    NSString *DBPath = [documentDirectory stringByAppendingPathComponent:DB_NAME];
    FMDatabase* db = [FMDatabase databaseWithPath:DBPath];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        NSLog(@"Open success db !");
        return db;
    }else {
        NSLog(@"Failed to open db!");
        return nil;
    }

}


@end

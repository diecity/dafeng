//
//  DTGlobal.h
//  DTC_TK
//
//  Created by feng gang on 12-6-15.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;

#define DB_NAME @"products.db"

@interface DTGlobal : NSObject

//弹出提示框
+ (void)showAlert:(NSString *)title message:(NSString *) msg;

////将json格式字符串转换为字典或者数组
//+ (id) transferStringToJSON:(NSString *)str;
//
////自动处理header里的节点,返回 ret 节点的值
//+ (id) transferStringToJSON:(NSString *)str needHandle:(BOOL)needHandle;

//将服务器返回的json转换为dictionary
+ (NSDictionary *)transferJSONToDic:(NSString *)str;
//需要处理ret等节点
+ (NSDictionary *)transferJSONToDic:(NSString *)str needHandle:(BOOL)handle;

//返回服务器的地址
+ (NSString *)hostAddress;

//返回写死在配置文件中的网络地址路径
+ (NSString *) requestAddress: (NSString *) addressType;

//返回在服务器中返回 的路径，比如图片的URL地址，下次请求时的服务器地址
+ (NSString *) getImageOrNextAddress: (NSString *) address;

//直接读取json文件到字典中
+ (NSDictionary *)readJSONFileToDic:(NSString *)str;

//设置用户名密码和用户 id 
+ (BOOL)setSecureKey:(NSString *)object key:(NSString *)key;

//取得保存的用户名和密码等信息
+ (NSString *)getSecureForKey:(NSString *)key;

//打开数据库，如果没有该数据库则创建之
+ (FMDatabase*)openDataBase;

@end

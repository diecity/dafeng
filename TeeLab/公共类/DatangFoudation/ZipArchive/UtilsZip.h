//
//  utilsZip.h
//  BaseProject
//
//  Created by dazhi on 13-3-7.
//
//

#import <Foundation/Foundation.h>

@interface UtilsZip : NSObject {
 
}

/******************************************************
 ** 功能:     解压一个压缩文档到指定位置
 ** 参数:     [in] zipFileString   ---  压缩包的名字
 **                outPathString  ---   指定路径
 ** 返回:     无
 ******************************************************/
+(BOOL) upZipFolder:(NSString *)zipFileString outPathString:outPathString;


/******************************************************
 ** 功能:     压缩文件夹
 ** 参数:     [in] srcFileString   ---  要压缩文件/文件夹名
 **                zipFileString  ---   指定压缩的目的和名字
 ** 返回:     无
 ******************************************************/
+(BOOL) zipFolder:(NSString *)srcFileString zipFileString:zipFileString;

@end

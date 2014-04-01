//
//  utilsZip.m
//  BaseProject
//
//  Created by dazhi on 13-3-7.
//
//

#import "ZipArchive.h"
#import "UtilsZip.h"

@implementation UtilsZip


/******************************************************
 ** 功能:     解压一个压缩文档到指定位置
 ** 参数:     [in] zipFileString   ---  压缩包的名字
 **                outPathString  ---   指定路径
 ** 返回:     无
 ******************************************************/
+(BOOL) upZipFolder:(NSString *)zipFileString outPathString:outPathString {

    BOOL ret;
    ZipArchive* zip = [[ZipArchive alloc] init];      
    if([zip UnzipOpenFile:zipFileString]) {
        ret = [zip UnzipFileTo:outPathString overWrite:YES];
   
        [zip UnzipCloseFile];
    }
    [zip release];
    return ret;
}

/******************************************************
 ** 功能:     压缩文件夹
 ** 参数:     [in] srcFileString   ---  要压缩文件/文件夹名
 **                zipFileString  ---   指定压缩的目的和名字
 ** 返回:     无
 ******************************************************/
+(BOOL) zipFolder:(NSString *)srcFileString zipFileString:zipFileString {
    
      BOOL isExist = NO;
      BOOL isDirectory = NO;
      NSFileManager *fileManager = [NSFileManager defaultManager];

     if([fileManager fileExistsAtPath:srcFileString isDirectory:&isDirectory] == NO) return NO;
    ZipArchive* zip = [[ZipArchive alloc] init];
    BOOL ret = [zip CreateZipFile2:zipFileString];
     if (isDirectory == NO) {           // 只压缩单个文件
 
        // 查找文件名
        NSString *search = @"/";
        NSString *tmp  = [NSString stringWithString:srcFileString];
        NSRange range = [tmp rangeOfString:search];
        
        while(range.length!= 0){
            tmp = [tmp substringFromIndex:(range.length+range.location)];
            range = [tmp rangeOfString:search];
        }
        ret = [zip addFileToZip:srcFileString newname:tmp];
        [zip CloseZipFile2];
        [zip release];
        return YES;
    }


     NSArray *fileList = [fileManager subpathsAtPath:srcFileString];
     for(int i = 0; i < [fileList count]; i++) {
          NSString *fileName = [fileList objectAtIndex:i];
          NSString *path = [NSString stringWithFormat:@"%@/%@", srcFileString, fileName];
          isExist = [fileManager   fileExistsAtPath:path isDirectory:&isDirectory];
         if(isExist == YES) {
             if (isDirectory == NO) {
                 [zip addFileToZip:path newname:fileName];
             }
         }
    }

    [zip CloseZipFile2];
    [zip release];
    return YES;
}

- (void)dealloc
{
 
    [super dealloc];
}
@end

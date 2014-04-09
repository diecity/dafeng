/******************************************************
 *标题:         共用方法类－－单例
 *创建人:        闫燕
 *创建日期:      13-7-22
 *功能及说明:    集合全局变量
 
 *修改记录列表:
 *修改记录:
 *修改日期:
 *修改者:
 *修改内容简述:
 *********************************************************/
#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "Define.h"

@interface CommonVariable : NSObject


@property (nonatomic, assign)   BOOL                isLogin;
@property (nonatomic, retain)   UserInfo            *userInfoo;
@property (nonatomic, copy)     NSString            *userInfoStr;

@property (nonatomic, retain)   NSString                *simulateCheckStatus;
@property (nonatomic, retain)   NSMutableArray          *simulateCheckPhotos;
@property (nonatomic, retain)   NSString                *checkStatus;

@property (nonatomic, retain)   NSString                *caseTel;//用户输入的报案手机号码
@property (nonatomic, retain)   NSString                *mapOfShow;//地图第二次进入加载成功赋值判断

/**************************************************************
 ** 功能:     获取单例
 ** 参数:     无
 ** 返回:     commonvariable对象
 **************************************************************/
+ (id)shareCommonVariable;

@property (nonatomic, assign) NSInteger addrType; //0:本地测试地址，1：内网测试地址， 2：公网电信地址， 3：公网联通地址
@property (nonatomic, retain) NSString  *serverAddr;

@property (nonatomic, copy) NSString *curLocalAddr;
@property (nonatomic, copy) NSString *curDefaultAddr;
@property (nonatomic, copy) NSString *curDianXinAddr;
@property (nonatomic, copy) NSString *curLianTongAddr;

@end

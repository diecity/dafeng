/******************************************************
 *标题:         用户信息model类
 *创建人:        qiang
 *创建日期:      14-04-02
 *功能及说明:    用户信息model类
 *
 *修改记录列表:
 *修改记录:
 *修改日期:
 *修改者:
 *修改内容简述:
 *********************************************************/
#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, retain)    NSString               *userName;//用户名
@property (nonatomic, retain)    NSString               *realName;//真实姓名
@property (nonatomic, retain)    NSString               *idType;//证件类型
@property (nonatomic, retain)    NSString               *idNumber;//证件号码
@property (nonatomic, retain)    NSString               *phoneNum;//电话号码
@property (nonatomic, retain)    NSString               *postAddr;//通讯地址


//userName realName idType idNumber phoneNum postAddr userLever vipCardNum userPoints userNum
@end

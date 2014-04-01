/******************************************************
 * 模块名称:   Location.h
 * 模块功能:   定位模块 获取经纬度、区域
 * 创建日期:   2012-10-06
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject <CLLocationManagerDelegate> {
 
    NSString *_strLat;
    NSString *_strLng;
    NSString *_city;
    NSString *_country;
    CLLocationManager *_locationManager;
    void (^_locationCallBack)();
    
}

@property (nonatomic, retain) NSString *strLat;
@property (nonatomic, retain) NSString *strLng;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *address;     ///地址信息 mzq
/******************************************************
 ** 方法功能: 启动定位
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
-(void)startLocation:(void(^)())callback;

/******************************************************
 ** 方法功能: 停止定位
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
-(void)stopLocation;
@end

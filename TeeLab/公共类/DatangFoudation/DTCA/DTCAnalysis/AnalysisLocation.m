/******************************************************
 * 模块名称:   Location.m
 * 模块功能:   定位模块 获取经纬度、区域
 * 创建日期:   2012-10-06
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import "AnalysisLocation.h"

@implementation Location

@synthesize   strLat = _strLat;
@synthesize   strLng = _strLng;
@synthesize   city = _city;
@synthesize   country = _country;
- (id)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;    
        _locationManager.distanceFilter=1000.0f;   // 位置过滤
        _locationManager.desiredAccuracy= kCLLocationAccuracyBest;
    }
    return self;
}

/******************************************************
 ** 方法功能: 启动定位
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
-(void)startLocation:(void(^)())callback{
    
    [callback release];
   _locationCallBack = [callback copy];

   [_locationManager startUpdatingLocation];

    
}

/******************************************************
 ** 方法功能: 停止定位
 ** 参数:     无
 ** 返回:     无
 ******************************************************/
-(void)stopLocation {
    [_locationManager stopUpdatingLocation]; 
    
}

/******************************************************
 ** 方法功能:  定位成功委托
 ** 参数:      newLocation  ---  新地址
 **           oldLocation   ---  旧位置
 ** 返回:     无
 ******************************************************/
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation

{
    
    self.strLat = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.latitude];  
    self.strLng = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.longitude];  
 
   
    //定位城市通过CLGeocoder
    CLGeocoder * geoCoder = [[[CLGeocoder alloc] init] autorelease];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error) {
            NSString *rr = [NSString stringWithFormat:@"%@",
                          [error localizedDescription]
                          ];
            NSLog(@"error%@", rr);                    // 错误信息
      
       
            if(_locationCallBack != nil) _locationCallBack();
            return ;
        }
        for (CLPlacemark * placemark in placemarks) {
            _city  = [placemark administrativeArea];
            _country = [placemark country];
            NSLog(@"city = %@", self.city );
            NSLog(@"country = %@", self.country );
            NSLog(@"name = %@", [placemark name]);
            NSLog(@"thoroughfare = %@", [placemark thoroughfare]);
            NSLog(@"subThoroughfare = %@", [placemark subThoroughfare]);
            NSLog(@"locality = %@", [placemark locality]);
            NSLog(@"subLocality = %@", [placemark subLocality]);
            NSLog(@"administrativeArea = %@", [placemark administrativeArea]);
            NSLog(@"subAdministrativeArea = %@", [placemark subAdministrativeArea]);
            
            NSLog(@"postalCode = %@", [placemark postalCode]);
            
            NSLog(@"ISOcountryCode = %@", [placemark ISOcountryCode]);
            
            NSLog(@"country = %@", [placemark country]);
            
            NSLog(@"inlandWater = %@", [placemark inlandWater]);
            
            NSLog(@"ocean = %@", [placemark ocean]);
            NSLog(@"areasOfInterest = %@", [placemark areasOfInterest]);
            

        ///    ///////地址信息获取    mzq 
            NSString *subThoroughfare=[placemark subThoroughfare];
            if (subThoroughfare==NULL) {
                subThoroughfare=@"";
            }
            self.address=[NSString stringWithFormat:@"%@%@%@%@%@",[placemark administrativeArea],[placemark locality],[placemark subLocality],[placemark thoroughfare],subThoroughfare];
            NSLog(@"address==%@",self.address);
            
            
            if(_locationCallBack != nil) _locationCallBack();
            return;
        }    
       
    }];
    
}

/******************************************************
 ** 方法功能:  定位出错委托
 ** 参数:      manager  ---  句柄
 **           error    ---   错误信息
 ** 返回:     无
 ******************************************************/
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSString* rr = @"";
    
    rr = [NSString stringWithFormat:@"%@",
                  [error localizedDescription]
                  ];
    NSLog(@"%@", rr);
	[_locationManager stopUpdatingLocation];
	
}

- (void)dealloc {
    [_locationCallBack release];
    [_locationManager release];
//    [_city release];
//    [_country release];
//    [_strLat release];
//    [_strLng release];
    
	[super dealloc];
}


@end

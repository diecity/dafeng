//
//  Helper.m
//  bbbb
//
//  Created by feng gang on 12-9-24.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "ServerHelper.h"
#import "ASIHTTPRequest.h"
#import "DTConstants.h"
//#import "JSON.h"
//#import "CPAGlobals.h"

@implementation ServerHelper
@synthesize didFinishSelector, didFailedSelector, delegate ;

-(void ) sendUrl:(NSString *) s andPostString: (NSString *) string RequestMethod :(NSString *) method IsShowActive :(BOOL) show
     SetDelegate :(id) d SetSelector :(SEL)  selector  
{
    //[self init];
     NSLog(@"%d",[d retainCount]);
    self.delegate=d;
    NSLog(@"%d",[self.delegate retainCount]);
    self.didFinishSelector=selector;
    
    s=[s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    NSURL *messageURL = [NSURL URLWithString:s];
    
    
    ASIHTTPRequest *asiHttpReq = [[ASIHTTPRequest alloc] initWithURL:messageURL];
   
    if (string!=nil) {
        [asiHttpReq appendPostData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [asiHttpReq setRequestMethod:method];
    //[asiHttpReq addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded; charset=UTF-8"];
    [asiHttpReq setDidFinishSelector:@selector(requestFinish:)];
    [asiHttpReq setDidFailSelector:@selector(requestFailed:)];
    [asiHttpReq setDelegate:self];
    //asiHttpReq.showMask = show;
    [asiHttpReq setValidatesSecureCertificate:NO];
    [asiHttpReq startAsynchronous];
//    [asiHttpReq release];
    
    
    //return self;
    
    
}


//请求成功
- (void) requestFinish:(ASIHTTPRequest *)request{
    request.responseEncoding = NSUTF8StringEncoding;
    NSData  *d=[request responseData];
    //NSString *responseStr = [request responseString];
    
     if (delegate && [delegate respondsToSelector:didFinishSelector]) {
    
   [delegate performSelector:didFinishSelector withObject:d];
     }
    /*
    NSLog(responseStr);
    NSDictionary *dic = [DTGlobal transferJSONToDic:responseStr needHandle:NO];    
    
    if (dic != nil) {
        NSDictionary*  ret				= [dic objectForKey:@"ret"];
        NSDictionary*  header			= [ret objectForKey:@"header"];
        NSDecimalNumber* retCode		= [header objectForKey:@"retCode"];
        
        if ([retCode intValue] == 0) { //数据返回成功
            if (delegate && [delegate respondsToSelector:didFinishSelector]) {
                NSDictionary *body       = [ret objectForKey:@"body"];
                [delegate performSelector:didFinishSelector withObject:body];
            }
            
        }else{ //数据返回失败失败或者异常情况
            //            if (self.showMask) {
            //                NSString *retText          = [header objectForKey:@"retText"];
            //                [DTGlobal showAlert:nil message:retText];
            
            //            }
        }
        
        
    }
    */
    
    [request release];
}



//请求失败
- (void) requestFailed:(ASIHTTPRequest *)request{
    if (delegate && [delegate respondsToSelector:didFailedSelector]) {
        NSDictionary *retDic       = [NSDictionary dictionaryWithObject:@"连接服务器失败!" forKey:@"retText"];
		[delegate performSelector:didFailedSelector withObject:retDic];
	}
    
    [request release];
}

- (void) dealloc{
    
    
    //[didFailedSelector release];
    //[delegate release];
    //delegate=nil;
    [super dealloc];
   
}


@end






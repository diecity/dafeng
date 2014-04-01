//
//  Helper.h
//  bbbb
//
//  Created by feng gang on 12-9-24.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface ServerHelper : NSObject{
SEL didFinishSelector;
SEL didFailedSelector;

    id delegate;

}
@property (assign,nonatomic) SEL didFinishSelector;
@property (assign,nonatomic) SEL didFailedSelector;
@property (assign, nonatomic) id delegate;

//@property (retain,nonatomic) NSString* autoLogin;
//@property (retain,nonatomic) NSString* accountName;
- (void) requestFinish:(ASIHTTPRequest *)request;
- (void) requestFailed:(ASIHTTPRequest *)request;

-(void ) sendUrl:(NSString *) s  andPostString: (NSString *) string RequestMethod :(NSString *) method IsShowActive :(BOOL) show
     SetDelegate :(id) d SetSelector :(SEL)  selector   ;

@end

//
//  CustomNavigationBar.m
//  CustomNavigationBar
//
//  Created by George on 10/27/10.
//  Copyright 2010 RED/SAFI. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation UINavigationBar (UINavigationBarCategory)

#pragma mark -
#pragma mark 重载navigationBar的背景图片
-(void)drawRect:(CGRect)rect{
	
	UIImage *image = [UIImage imageNamed:@"top_home.png"];
    [image drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
}


@end
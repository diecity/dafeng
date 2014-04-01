//
//  UIHelper.m
//  tp_self_help
//
//  Created by cloudpower on 13-7-23.
//  Copyright (c) 2013年 cloudpower. All rights reserved.
//

#import "UIHelper.h"
//#import "JSONKit.h"
@implementation UIHelper


/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.title = @"温馨提示";
    view.message=title;
    [view addButtonWithTitle:@"确定"];
    [view show];
    [view release];
}

/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（内容）
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title andMSG:(NSString*)msg{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.title = title;
    view.message = msg;
    [view addButtonWithTitle:@"确定"];
    [view show];
    [view release];
}
/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（内容）
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title andMSG:(NSString*)msg delegate:(id)sender andTag:(NSInteger)tag{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.title = title;
    view.message = msg;
    view.tag=tag;
    view.delegate=sender;
    [view addButtonWithTitle:@"取消"];
    [view addButtonWithTitle:@"确定"];
    [view show];
    [view release];
}

/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（输入框内容）、代理对象
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title textFContent:(NSString*)text delegate:(id)sender andTag:(NSInteger)tag{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[view textFieldAtIndex:0] setText:text];
    [[view textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[view textFieldAtIndex:0] setTag:TAG_TEXT_FIELD_PHONE_NUM];
    [[view textFieldAtIndex:0] setDelegate:sender];
    view.title = title;
    [view addButtonWithTitle:@"取消"];
    [view addButtonWithTitle:@"拨打"];
    view.delegate = sender;
    view.tag = tag;
    [view show];
    [view release];
}

/**************************************************************
 ** 功能:     弹出拨打电话前的alert提示
 ** 参数:     nsstring（提示内容内容）、代理对象
 ** 返回:     无
 **************************************************************/
+ (void)alertWithMsg:(NSString*)msg delegate:(id)sender andTag:(NSInteger)tag{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:sender cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    view.tag = tag;
    [view show];
    [view release];
}


/**************************************************************
 ** 功能:     加loading view
 ** 参数:     cgrect(loadingview的frame)、id（加在此对象上）
 ** 返回:     无
 **************************************************************/
+ (void)addLoadingViewTo:(UIView*)targetV withFrame:(CGRect)frame andText:(NSString*)text{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:frame];
    [targetV addSubview:hud];
    [hud release];
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}


/**************************************************************
 ** 功能:     定制navigation bar
 ** 参数:     uiimage（背景图片）、nsstring（标题）、id（目标对象）
 ** 返回:     uiview
 **************************************************************/
+ (UIView*)headerViewWithImage:(UIImage*)img title:(NSString*)title target:(id)sender{
    
  
    
    UIImageView *view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, IOS70_71?20:0, 320, 50)] autorelease];
    view.userInteractionEnabled = YES;
    [view setImage:[UIImage imageNamed:@"民安自助ok切图_navtitle.png"]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"民安自助ok切图-nav_back.png"] forState:UIControlStateNormal];
    [button addTarget:sender action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[[UILabel alloc] init] autorelease];
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:20]];
    
//    if (IOS_VERSION>=7.0) {
//        [button setFrame:CGRectMake(5, 15, 33, 33)];
//         [label setFrame:CGRectMake((320 - size.width)/2, 15, size.width, (44 - 10))];
//    }
//    else
//    {
        [button setFrame:CGRectMake(5, 5, 33, 33)];
         [label setFrame:CGRectMake((320 - size.width)/2, 5, size.width, (44 - 10))];
//    }
    
    /////nav 右边按钮
    UIButton *button_right = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_right setImage:[UIImage imageNamed:@"民安自助ok切图-nav_long.png"] forState:UIControlStateNormal];
    [button_right addTarget:sender action:@selector(backBtnClickedOfRootCV:) forControlEvents:UIControlEventTouchUpInside];
    button_right.frame=CGRectMake(282, 5, 33, 33);
    
    [view addSubview:button_right];
    [view addSubview:button];

    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
 
    return view;
}
/**************************************************************
 ** 功能:     定制navigation bar  二级界面
 ** 参数:     uiimage（背景图片）、nsstring（标题）、id（目标对象）
 ** 返回:     uiview
 **************************************************************/
+ (UIView*)headerViewWithTitle:(NSString*)title target:(id)sender{
    UIImageView *view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, IsIOS7?20:0, 320, 50)] autorelease];
    view.userInteractionEnabled = YES;
    [view setImage:[UIImage imageNamed:@"民安自助ok切图_navtitle.png"]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"民安自助ok切图-nav_left.png"] forState:UIControlStateNormal];
    [button addTarget:sender action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[[UILabel alloc] init] autorelease];
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:20]];
    
    //    if (IOS_VERSION>=7.0) {
    //        [button setFrame:CGRectMake(5, 15, 33, 33)];
    //         [label setFrame:CGRectMake((320 - size.width)/2, 15, size.width, (44 - 10))];
    //    }
    //    else
    //    {
    [button setFrame:CGRectMake(5, 5, 33, 33)];
    [label setFrame:CGRectMake((320 - size.width)/2, 5, size.width, (44 - 10))];
    //    }
    
    /////nav 右边按钮
    UIButton *button_right = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_right setImage:[UIImage imageNamed:@"民安自助ok切图-nav_long.png"] forState:UIControlStateNormal];
    [button_right addTarget:sender action:@selector(backBtnClickedOfRootCV:) forControlEvents:UIControlEventTouchUpInside];
    button_right.frame=CGRectMake(282, 5, 33, 33);
    
    [view addSubview:button_right];
//    [view addSubview:button];
    
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    
    
    return view;
}

//获得JSON 字典 只有头
+ (NSMutableDictionary *) createJSONDic:(id) reqCode{
    if (reqCode==nil) {
        return nil;
    }
    NSMutableDictionary * reqDic = [[[NSMutableDictionary alloc]init]autorelease];
    [reqDic setObject:reqCode forKey:@"method"];
    return reqDic;
}

//获得JSON 字典 有头, body
+ (NSMutableDictionary *) createJSONDic:(id) reqCode andBodyObj:(id)bodyObj{
    if (reqCode==nil) {
        return nil;
    }
    NSMutableDictionary * reqDic = [self createJSONDic:reqCode];
    if (bodyObj) {
        NSLog(@"souceDict%@", (NSDictionary*)bodyObj);
        NSLog(@"jsonString---- %@ end---",  [((NSDictionary*)bodyObj) JSONString]);
        NSString * jsonStr =[NSString stringWithString: [((NSDictionary*)bodyObj) JSONString]];
        if (jsonStr) {
            [reqDic setObject:jsonStr forKey:@"body"];
        }
    }
    return reqDic;
}


@end

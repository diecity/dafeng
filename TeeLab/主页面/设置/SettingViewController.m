//
//  SettingViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-8.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "SettingViewController.h"
//#import "LoginViewController.h"
#import "FeedbackViewController.h"
#import "ShippingInformationViewController.h"
#define TAG_ALERT_REFRESH         500
#define TAG_ALERT_LOG_OUT_SUCC    101

@interface SettingViewController ()

@end

@implementation SettingViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    self.refreshUrl = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title=@"设置";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkRefreshFinished:) name:@"checkRefreshFinished" object:nil];
    ////是否取消消息推送
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(decideNotificaFinished:) name:@"decideNotificaFinished" object:nil];

    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, 320, 350);
    _rootTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    _rootTableView.scrollEnabled = NO;
    _rootTableView.backgroundColor = [UIColor yellowColor];
    [_rootTableView setBackgroundView:nil];
    //[_rootTableView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    [_rootTableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_rootTableView];
   
    
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [logOutBtn setBackgroundImage:[UIImage imageNamed:@"button_4.png"] forState:UIControlStateNormal];
//    [logOutBtn setBackgroundImage:[UIImage imageNamed:@"button_4_clicked.png"] forState:UIControlStateSelected];
    logOutBtn.backgroundColor=[UIColor redColor];
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logOutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [logOutBtn addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    [logOutBtn setFrame:CGRectMake(8, 380, 304, 48)]; //380 按钮向上40个像素
    [self.view addSubview:logOutBtn];
    
    
    //nav
    [self.view addSubview:[UIHelper headerViewWithImage:[UIImage imageNamed:@"nav_settting.png"] title:@"设置" target:self]];
}


#pragma mark- table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5; //5 后续加入插件功能设置用.
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //cell.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 150, 30)];
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *label = [[cell.contentView subviews] objectAtIndex:0];
    CGRect frame = CGRectMake(200, 7, 80, 36);
        if (indexPath.row == 0){
        label.text = @"清除缓存";
        _cleanB = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cleanB setBackgroundImage:[UIImage imageNamed:@"button_setting_page.png"] forState:UIControlStateNormal
         ];
        [_cleanB setBackgroundImage:[UIImage imageNamed:@"button_setting_page_clicked.png"] forState:UIControlStateSelected
         ];
        [_cleanB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cleanB setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_cleanB setTitle:@"清除" forState:UIControlStateNormal];
        [_cleanB addTarget:self action:@selector(cleanBClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_cleanB setFrame:frame];
        [cell.contentView addSubview:_cleanB]; 
    }else if (indexPath.row == 1){
        label.text = @"消息是否推送";
        _pushMsgS = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 80, 36)];
        _pushMsgS.onTintColor=[UIColor colorWithRed:0.1 green:0.3 blue:0.5 alpha:0.5];////调整颜色 mzq
        [_pushMsgS addTarget:self action:@selector(pushMsgSwiched:) forControlEvents:UIControlEventValueChanged];
        _pushMsgS.on = YES;
        [cell.contentView addSubview:_pushMsgS];
    }else if (indexPath.row == 3){
        label.text = @"配送信息设置";
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 15, 13, 13)];
        [arrowImgView setImage:[UIImage imageNamed:@"travel_help_cell_right_btn.png"]];
        [cell.contentView addSubview:arrowImgView];
    }else if (indexPath.row == 2){
        label.text = @"检测更新";
        _refreshB = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshB setBackgroundImage:[UIImage imageNamed:@"button_setting_page.png"] forState:UIControlStateNormal
         ];
        [_refreshB setBackgroundImage:[UIImage imageNamed:@"button_setting_page_clicked.png"] forState:UIControlStateSelected
         ];
        [_refreshB setTitle:@"更新" forState:UIControlStateNormal];
        [_refreshB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_refreshB setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_refreshB addTarget:self action:@selector(refreshBClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_refreshB setFrame:frame];
        [cell.contentView addSubview:_refreshB];
  
    }else{
        label.text = @"反馈";
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 15, 13, 13)];
        [arrowImgView setImage:[UIImage imageNamed:@"travel_help_cell_right_btn.png"]];
        [cell.contentView addSubview:arrowImgView];
    
    }
    
    return cell;
}
#pragma mark- table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {//插件设置
        ShippingInformationViewController *shipping=[[ShippingInformationViewController alloc]init];
        [self.navigationController pushViewController:shipping animated:YES];
        return;
        
    }else if (indexPath.row==4){
    
        FeedbackViewController *feed=[[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:feed animated:YES];
        
    }
}


#pragma mark-  clicked!! and  value changed!!!

- (void)logOut:(UIButton*)btn{
    
    
    if ([[CommonVariable shareCommonVariable] isLogin]) {
        [[CommonVariable shareCommonVariable] setIsLogin:NO];
       // [[CommonVariable shareCommonVariable] setUser];
       
       // [[CommonVariable shareCommonVariable] setIsLogin:YES];
        [[CommonVariable shareCommonVariable] setUserInfoo:nil];
     
        [[CommonVariable shareCommonVariable] setUserInfoStr:nil];
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"loginFinished" object:SUCC];
        //[UIHelper alertWithMsg:@"退出成功" delegate:self andTag:TAG_ALERT_LOG_OUT_SUCC];
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:KEY_ID_NUMBER];
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:KEY_PASS_WORD];
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:KEY_USER_NAME];
        _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"退出成功";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud show:YES];
        [self performSelector:@selector(pop) withObject:nil afterDelay:1.5f];
    }else{
        [UIHelper alertWithTitle:@"您当前并未登陆，不需要退出！"];
    }
}

- (void)pop{
    _hud.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- 检测更新 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 
    if (alertView.tag == TAG_ALERT_REFRESH) {
        if (buttonIndex == 1) {//更新
            NSString *str = [NSString stringWithFormat:@"itms-apps://%@",_refreshUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
//    else if(alertView.tag == TAG_ALERT_LOG_OUT_SUCC){
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}


- (void)checkRefreshFinished:(NSNotification*)notify{
    
    if ([[self.navigationController.viewControllers lastObject] isKindOfClass:[SettingViewController class]]) {
        NSString *notifyStr = notify.object;
        if ([notifyStr isEqualToString:REFRESH_DESC_YES]) {//需要更新
            //self.refreshUrl = [[NSString alloc] initWithString:[notify.userInfo objectForKey:@"downloadUrl"]];
                self.refreshUrl = [notify.userInfo objectForKey:@"downloadUrl"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检测到更新" message:@"是否更新？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                alert.tag = TAG_ALERT_REFRESH;
                [alert show];
        }else{//不需要更新--提示用户
            [UIHelper alertWithTitle:@"当前已是最新版本！"];
        }
    }
}




- (void)refreshBClicked:(UIButton*)btn{


}


#pragma mark- 清理缓存
- (void)cleanBClicked:(UIButton*)btn{
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:KEY_PASS_WORD] &&[[[NSUserDefaults standardUserDefaults] objectForKey:KEY_PASS_WORD] length] > 0 ) {
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:KEY_ID_NUMBER];
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:KEY_PASS_WORD];
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:KEY_USER_NAME];
    }
    ////取消自动登录
    [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:KEY_IS_AUTOLOGIN];

    [UIHelper alertWithTitle:@"清除缓存成功!"];
}

#pragma mark- 是否接受推送
- (void)pushMsgSwiched:(UISwitch*)swich{
    
//    if (swich.isOn) {
//        [[NetWork shareNetWork]  setAcceptPushMessage:YES ];
//    }
//    else{
//        [[NetWork shareNetWork]  setAcceptPushMessage:NO ];
//    }
}
-(void)decideNotificaFinished:(NSNotification*)nodify{
    NSObject *myObj = nodify.object;
    if (myObj) {
        [UIHelper alertWithTitle:(NSString*)myObj];

    }else{
        [UIHelper alertWithTitle:@"网络连接异常，请稍后再试！"];

    }

}

- (void)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
     [_hud show:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

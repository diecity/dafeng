//
//  LogInmainViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-2.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "LogInmainViewController.h"
#import "UIHelper.h"

#import "RootViewController.h"
@interface LogInmainViewController ()

@end

@implementation LogInmainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//初始化广告图片
- (void)initADimageView
{
    [_ad_scrollView setContentSize:CGSizeMake(320*5, 0)];
    //    _ad_scrollView.delegate = self;
    for (int i = 0; i < 5; i++)
    {
        UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30 + 320 * i, 10, 260, 220)];
        NSString *imageName = nil;
      
        imageName = [NSString stringWithFormat:@"photo%d.jpg",i + 1];
        
        [adImageView setImage:[UIImage imageNamed:imageName]];
        [_ad_scrollView addSubview:adImageView];

        NSString*str=@"";
        NSString*str_titile=@"";

        switch (i) {
            case 0:
                str=@"UMS_qq_icon.png";
                str_titile=@"设计师：QQ大师";
                break;
            case 1:
                str=@"UMS_sina_icon.png";
                str_titile=@"设计师：新浪微博大师";

                break;
            case 2:
                str=@"UMS_renren_icon.png";
                str_titile=@"设计师：人人网大师";

                break;
            case 3:
                str=@"UMS_sina_icon.png";
                str_titile=@"设计师：新浪微博大师";
                
                break;
            case 4:
                str=@"UMS_renren_icon.png";
                str_titile=@"设计师：人人网大师";
                
                break;
            default:
                break;
        }
        UIImageView *img_title=[[UIImageView alloc]initWithFrame:CGRectMake(15, 180, 30, 30)];
        img_title.image=[UIImage imageNamed:str];
        [adImageView addSubview:img_title];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 195, 150, 30)];
        label.text=str_titile;
        label.font=[UIFont systemFontOfSize:10];
        label.textColor=[UIColor redColor];
        label.backgroundColor=[UIColor clearColor];
        [adImageView addSubview:label];
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=adImageView.frame;
        btn.tag=300+i;
        [btn addTarget:self action:@selector(buttonnextOfview:) forControlEvents:UIControlEventTouchUpInside];

        UIButton *btn0=[UIButton buttonWithType:UIButtonTypeCustom];
        btn0.frame=CGRectMake(200, 180, 60, 30);
        btn0.tag=350+i;
        [btn0 setTitle:@"据为己有" forState:UIControlStateNormal];

        btn0.backgroundColor=[UIColor redColor];
        [btn0 setImage:[UIImage imageNamed:@"UMS_renren_icon.png"] forState:UIControlStateNormal];
        [btn0 addTarget:self action:@selector(buttonnextOfview0:) forControlEvents:UIControlEventTouchUpInside];
        btn.userInteractionEnabled=YES;
        [btn addSubview:btn0];
        [_ad_scrollView addSubview:btn];
    }
    //1秒换图片
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImageInTimer:) userInfo:nil repeats:YES];
    
}
-(void)buttonnextOfview:(UIButton*)sender{
    NSLog(@"2222222");

    
}
-(void)buttonnextOfview0:(UIButton*)sender{
    
    [UIHelper alertWithTitle:@"购买吗！"];
    NSLog(@"1111111");
}
#pragma mark -1秒换图片-
- (void)changeImageInTimer:(NSTimer *)timer
{
    
    static int page_ye=0;
    //    int page = _ad_pageControl.currentPage;
    page_ye++;
    page_ye = page_ye > 4 ? 0:page_ye;
    //    _ad_pageControl.currentPage = page_ye;
    _ad_scrollView.contentOffset = CGPointMake(0 + 320 * page_ye, 0);
}



- (void)onTap
{
    [self hideKeyBoard];
}

- (void)hideKeyBoard
{
    [_UseName resignFirstResponder];
    [_PassWord resignFirstResponder];
    _LogIn_view.frame=CGRectMake(0, 302, 320, 119);


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"登陆";
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;      //设置回调对象

    
    //添加手势
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tapGesture.delegate = self;
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGesture];
    _PassWord.delegate=self;
    _UseName.delegate=self;
    
    
    _ad_scrollView=[[UIScrollView alloc]init];
    _ad_scrollView.frame=CGRectMake(0, 64, 320, 340);
//    _ad_scrollView.backgroundColor=[UIColor grayColor];
    [self initADimageView];   ///添加广告位
    [self.view addSubview:_ad_scrollView];
    [self.view addSubview:_LogIn_view];
    
}
- (IBAction)LogIn:(id)sender {
    NSLog(@"登陆");
    if ([_UseName.text length]==0) {
        [UIHelper alertWithTitle:@"请输入用户名！"];
        return;
    }else  if ([_UseName.text length]<3||[_UseName.text length]>30) {
        [UIHelper alertWithTitle:@"用户名只能为3到30位字符！"];
        return;
    }
    if ([_PassWord.text length]==0) {
        [UIHelper alertWithTitle:@"请输入密码！"];
        return;
        
    }if ([_PassWord.text length]<6) {
        [UIHelper alertWithTitle:@"密码不能少于6位！"];
        return;
    }
    
    [self hideKeyBoard];
    
    RootViewController *root=[[RootViewController alloc]init];
    [self.navigationController pushViewController:root animated:YES];
    
    
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    _LogIn_view.frame=CGRectMake(0, 120, 320, 144);
//
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField{       // became first responder
    
    _LogIn_view.frame=CGRectMake(0, 120, 320, 178);

//    if (iPhone4Retina) {
//        <#statements#>
//    }
}



- (IBAction)QQlogIn:(id)sender {
    NSLog(@"qq登陆");

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"UMShareToTencent==response is %@",response);
        
        if (response.responseCode==UMSResponseCodeSuccess) {
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"openid"];
            
            NSLog(@"QQ===response is %@",str);

            NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];

            UMSocialAccountEntity *accountEnitity = [snsAccountDic valueForKey:@"qzone"];

            NSLog(@"QQ详细信息===response is %@",accountEnitity.userName);
            
            NSLog(@"QQ详细信息==accessToken=response is %@",accountEnitity.accessToken);

            NSLog(@"QQ详细信息=usid==response is %@",accountEnitity.usid);
            
            NSLog(@"QQ详细信息===response is %@",[accountEnitity description]);
            
            

        }else  if (response.responseCode==UMSResponseCodeCancel){
//            [UIHelper alertWithTitle:@"取消授权！"];
        }else{
            [UIHelper alertWithTitle:@"授权失败！"];

        }
        

    });

    
    
    
}
/**
 请求获取用户微博账号的详细数据,获取返回数据和其他方法一样，在<UMSocialDataDelegate>中的`didFinishGetUMSocialDataResponse`返回的`UMSocialResponseEntity`对象，数据部分是`data`属性，为`NSDictionary`类型
 
 @param platformType 要获取微博信息的微博平台
 @param completion 请求之后执行的block对象
 
 */
- (void)requestSnsInformation:(NSString *)platformType completion:(UMSocialDataServiceCompletion)completion{
    

}




- (IBAction)SinaLogIn:(id)sender {
    NSLog(@"新浪登陆");
    
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);

       

        if (response.responseCode==UMSResponseCodeSuccess) {
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"usid"];
            
            NSLog(@"resnse is %@",str);
            
            
            NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
            
            UMSocialAccountEntity *accountEnitity = [snsAccountDic valueForKey:@"sina"];
            
            NSLog(@"QQ详细信息===response is %@",accountEnitity.userName);
            
            NSLog(@"QQ详细信息==accessToken=response is %@",accountEnitity.accessToken);
            
            NSLog(@"QQ详细信息=usid==response is %@",accountEnitity.usid);
            
            NSLog(@"QQ详细信息===response is %@",[accountEnitity description]);

            
        }else  if (response.responseCode==UMSResponseCodeCancel){
            //            [UIHelper alertWithTitle:@"取消授权！"];
        }else{
            [UIHelper alertWithTitle:@"授权失败！"];
            
        }
        
        
        
    });

}
//实现回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    
    if (response.viewControllerType == UMSViewControllerOauth) {
        NSLog(@"didFinishOauthAndGetAccount response is %@",response);
        
    }
}


- (IBAction)XiaoneiLogIn:(id)sender {
    NSLog(@"人人登陆");
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToRenren];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
        
        if (response.responseCode==UMSResponseCodeSuccess) {
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"renren"] objectForKey:@"usid"];
            
            NSLog(@"renren====response is %@",str);
            
        }else  if (response.responseCode==UMSResponseCodeCancel){
            //            [UIHelper alertWithTitle:@"取消授权！"];
        }else{
            [UIHelper alertWithTitle:@"授权失败！"];
            
        }
            
    });
}
- (IBAction)declineLogIn:(id)sender {
    NSLog(@"更多");
    
    
    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"更多登陆方式" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    NSArray *share_arry=[[NSArray alloc]initWithObjects:@"豆瓣", nil];
    
    for (NSString *snsName in share_arry) {
        [editActionSheet addButtonWithTitle:snsName];
        
    }
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = 101;
    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
    //    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
    [editActionSheet showInView:self.view];
    editActionSheet.delegate = self;
    
    return;
    
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。 摔香炉
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
        

        if (response.responseCode==UMSResponseCodeSuccess) {
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"usid"];
            NSLog(@"response is %@",str);
        }else  if (response.responseCode==UMSResponseCodeCancel){
            //            [UIHelper alertWithTitle:@"取消授权！"];
        }else{
            [UIHelper alertWithTitle:@"授权失败！"];
            
        }
    });

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex + 1 >= actionSheet.numberOfButtons ) {
        return;
    }
    NSString *snsName = @"";
    switch (buttonIndex) {
        case 0:
            snsName=@"tencent";
            break;
        case 1:
            snsName=@"sina";
            break;
        default:
            break;
    }
    
    NSLog(@"豆瓣登陆");
    
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToDouban];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
        
        if (response.responseCode==UMSResponseCodeSuccess) {
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"usid"];
            NSLog(@"response is %@",str);
        }else  if (response.responseCode==UMSResponseCodeCancel){
            //            [UIHelper alertWithTitle:@"取消授权！"];
        }else{
            [UIHelper alertWithTitle:@"授权失败！"];
            
        }
        
    });

}
- (IBAction)DouBanLogin:(id)sender {
    
    NSLog(@"豆瓣登陆");
    
    //`snsName` 代表各个支持云端分享的平台名，有`UMShareToSina`,`UMShareToTencent`等五个。 
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToDouban];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
       
        if (response.responseCode==UMSResponseCodeSuccess) {
            NSDictionary *dicdate=(NSDictionary*)response.data;
            NSString *str=[[ dicdate objectForKey:@"sina"] objectForKey:@"usid"];
            NSLog(@"response is %@",str);
        }else  if (response.responseCode==UMSResponseCodeCancel){
            //            [UIHelper alertWithTitle:@"取消授权！"];
        }else{
            [UIHelper alertWithTitle:@"授权失败！"];
            
        }
        
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

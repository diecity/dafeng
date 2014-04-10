//
//  ShippingInformationViewController.m
//  TeeLab
//
//  Created by teelab2 on 14-4-8.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import "ShippingInformationViewController.h"
#import "Define.h"
#import "CustomCells.h"
#import "UIHelper.h"
#import "DataBase.h"
#import "ShipInformation.h"


@interface ShippingInformationViewController ()

@end

@implementation ShippingInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)onTap
{
    [self hideKeyBoard];
}
////隐藏键盘
- (void)hideKeyBoard
{
    [_Name resignFirstResponder];
    [_tel resignFirstResponder];
    [_address resignFirstResponder];
    [_Youbian resignFirstResponder];
    [_Address_textview resignFirstResponder];
    _root_view.frame=CGRectMake(0, 64, 320, 504);

}
-(void)addinformation{
    static int add=0;
    
    if (_root_view.hidden) {
        add=0;
    }
    
    if (add==0) {
        [btn_add setTitle:@"取消" forState:UIControlStateNormal];
        NSLog(@"321");
        _AddOrEdit=@"add";
     //////添加新的信息 将输入框设置位可编辑并设置位空
        _Name.enabled=YES;
        _tel.enabled=YES;
        _Address_textview.editable=YES;
        _Youbian.enabled=YES;
        _Name.text=@"";
        _tel.text=@"";
        _Address_textview.text=@"";
        _Youbian.text=@"";
        
        self.root_view.hidden=NO;
        self.editing.hidden=YES;
        
        [self.view addSubview:_root_view];
        add=1;
    }else{
    
        [btn_add setTitle:@"添加" forState:UIControlStateNormal];

        self.root_view.hidden=YES;

        add=0;
    }
    
    
  
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [[NSUserDefaults standardUserDefaults]setValue:Arr_Information forKey:SHIP_INFORMATIN];
    Arr_Information=[[NSMutableArray alloc]init];
    Arr_Information=(NSMutableArray*)[[DataBase sharedDataBase] selectAllShipInformatin];

    NSLog(@"arr===%@",Arr_Information);
    
    self.title=@"配送信息";
    self.interger=0;
    _deault=0;
    _update_ship=@"";
    _address.delegate=self;
    _Youbian.delegate=self;
    
    
    btn_add=[UIButton buttonWithType:UIButtonTypeCustom];
    btn_add.frame=CGRectMake(0, 0, 50, 30);
    [btn_add setTitle:@"添加" forState:UIControlStateNormal];
    [btn_add setTintColor:[UIColor grayColor]];
    [btn_add addTarget:self action:@selector(addinformation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_add];
    self.navigationItem.rightBarButtonItem=bar;
    
    
    
    //添加手势
 UITapGestureRecognizer*   tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tapGesture.delegate = self;
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [self.root_view addGestureRecognizer:tapGesture];
    
    /////设置位圆角
    self.Address_textview.layer.masksToBounds = YES;
    self.Address_textview.layer.cornerRadius = 4.0;
    self.Address_textview.layer.borderWidth = 1.0;
    self.Address_textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    self.Name.layer.masksToBounds = YES;
    self.Name.layer.cornerRadius = 4.0;
    self.Name.layer.borderWidth = 1.0;
    self.Name.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.tel.layer.masksToBounds = YES;
    self.tel.layer.cornerRadius = 4.0;
    self.tel.layer.borderWidth = 1.0;
    self.tel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.Youbian.layer.masksToBounds = YES;
    self.Youbian.layer.cornerRadius = 4.0;
    self.Youbian.layer.borderWidth = 1.0;
    self.Youbian.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //add root view
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FOR_SIT_IOS7_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FOR_SIT_IOS7_HEIGHT) style:UITableViewStylePlain];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
    
}


#pragma mark 编辑并 保存
- (IBAction)Editing:(UIButton*)sender {
    
    if (sender.tag==88) {
        
        _AddOrEdit=@"edit";
        _Name.enabled=YES;
        _tel.enabled=YES;
        _address.enabled=YES;
        _Youbian.enabled=YES;
        _Address_textview.editable=YES;

    }else{
      
        if ([_Name.text length]<1) {
            [UIHelper alertWithTitle:@"请输入接收人姓名！"]; return;

        }if ([_Address_textview.text length]<1) {
            [UIHelper alertWithTitle:@"请输入接收人地址！"]; return;
            
        }if ([_tel.text length]==0) {
            [UIHelper alertWithTitle:@"请输入接收人手机号！"]; return;
            
        }
        NSString * regex        = @"1[0-9]{10}";
        NSPredicate * pred_tel      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if( ![pred_tel evaluateWithObject:_tel.text] ){
            [UIHelper alertWithTitle:@"接收人人手机号格式不对！"];        return;
        }
        _Name.enabled=NO;
        _tel.enabled=NO;
        _address.enabled=NO;
        _Youbian.enabled=NO;
        _Address_textview.editable=NO;
        self.editing.hidden=NO;
        [btn_add setTitle:@"添加" forState:UIControlStateNormal];

        
        NSMutableDictionary *diction=[[NSMutableDictionary alloc]init];
        [diction setObject:_Name.text forKey:@"name"];
        [diction setObject:_tel.text forKey:@"telphone"];
        [diction setObject:_Address_textview.text forKey:@"address"];
        [diction setObject:_Youbian.text forKey:@"youbian"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *locationString=[formatter stringFromDate: [NSDate date]];
        NSLog(@"==%@",locationString);
        
        [diction setObject:locationString forKey:@"mark"];

        [diction setObject:@"0" forKey:@"deault"];

        
        
        diction=nil;
        self.root_view.hidden=YES;
        
//        [[NSUserDefaults standardUserDefaults]setValue:Arr_Information forKey:SHIP_INFORMATIN];

        
        ////添加到数据库
        ShipInformation *ship=[[ShipInformation alloc]init];
        ship.userName=_Name.text;
        ship.postcode=_Youbian.text;
        ship.postAddr=_Address_textview.text;
        ship.phoneNum=_tel.text;
        ship.deault=@"0";

        
        NSString *strdate=_update_ship;
        if ([_AddOrEdit isEqualToString:@"edit"]) {
            [Arr_Information replaceObjectAtIndex:(NSInteger)_interger withObject:ship];
            
            [[DataBase sharedDataBase] updateContent:ship byKey:strdate];

            
        }else{
            
            ship.mark=locationString;
            [Arr_Information addObject:ship];
            [[DataBase sharedDataBase] insertShipInformation:ship];

        }
        
        [_rootTableView reloadData];

    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{       // became first responder
    
    
    if (textField.tag==131||textField.tag==132) {
        _root_view.frame=CGRectMake(0, -50, 320, 504);
        
    }
    
}

#pragma mark Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return [Arr_Information count];
//    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellId = @"caseListCell";
    CustomCells *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCells" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

   
    ShipInformation *ship=[[ShipInformation alloc]init];
    ship=[Arr_Information objectAtIndex:indexPath.row];
    if ([Arr_Information count]>0) {
        cell.reportNumL.text=ship.userName;
        cell.accidentDateL.text=ship.postAddr;
        
    }
  
    cell.Defaultbutton.tag=500+indexPath.row;
    [cell.Defaultbutton setBackgroundColor:[UIColor clearColor]];

    if ([ship.deault isEqualToString:@"1"]) {
        [cell.Defaultbutton setBackgroundColor:[UIColor redColor]];

    }
    [cell.Defaultbutton addTarget:self action:@selector(defaultOfseclect:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.textLabel.font=[UIFont systemFontOfSize:16];
	return cell;
}

-(void)defaultOfseclect:(UIButton *)sender{
 
    NSLog(@"==%d",sender.tag);
    
    /////数据库都设置为非默认
    [[DataBase sharedDataBase] updateContedeualt];

    ShipInformation *ship=[[ShipInformation alloc]init];
    ship=[Arr_Information objectAtIndex:sender.tag-500];
    ship.deault=@"1";
    
    [[DataBase sharedDataBase] updateContent:ship byKey:ship.mark];

    Arr_Information=(NSMutableArray*)[[DataBase sharedDataBase] selectAllShipInformatin];

    [_rootTableView reloadData];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    _interger=indexPath.row ;
    self.root_view.hidden=NO;
    [self.view addSubview:_root_view];
    self.editing.hidden=NO;
    
    ShipInformation *ship=[Arr_Information objectAtIndex:indexPath.row];
    //////查看信息详情 暂时不能修改
    _Name.text=ship.userName;
    _tel.text=ship.phoneNum;
    _Address_textview.text=ship.postAddr;
    _Youbian.text=ship.postcode;
    
    
    _update_ship=ship.mark;
    
    NSLog(@"update+ship====%@",_update_ship);
    _Name.enabled=NO;
    _tel.enabled=NO;
    _address.enabled=NO;
    _Youbian.enabled=NO;
    _Address_textview.editable=NO;
    
    


}
#pragma mark 提交编辑操作时会调用这个方法(删除，)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"===index==%d",indexPath.row);
    // 删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.删除数据
//        [Arr_Information removeObjectAtIndex:indexPath.row];
        
        ShipInformation *ship=[[ShipInformation alloc]init];
        ship=[Arr_Information objectAtIndex:indexPath.row];
        [[DataBase sharedDataBase] deleteshipByPath:ship.mark];
        
        if ([[DataBase sharedDataBase] selectAllShipInformatin]>0) {
            Arr_Information=(NSMutableArray*)[[DataBase sharedDataBase] selectAllShipInformatin];

        }

        // 2.更新UITableView UI界面
         [tableView reloadData];
    }
}
#pragma mark 决定tableview的编辑模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexpath==%d",indexPath.row);
    return UITableViewCellEditingStyleDelete;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

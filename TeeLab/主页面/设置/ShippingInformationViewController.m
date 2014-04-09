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

    NSLog(@"321");
    _AddOrEdit=@"add";
    
    _Name.enabled=YES;
    _tel.enabled=YES;
    _Address_textview.editable=YES;
    _Youbian.enabled=YES;
    _Name.text=@"";
    _tel.text=@"";
    _Address_textview.text=@"";
    _Youbian.text=@"";

    
    _Address_textview.editable=YES;
    self.root_view.hidden=NO;
    self.editing.hidden=YES;
    
    [self.view addSubview:_root_view];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title=@"配送信息";
    self.interger=0;
    _deault=0;
    Arr_Information=[[NSMutableArray alloc]init];
    _address.delegate=self;
    _Youbian.delegate=self;
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    [btn setTitle:@"ADD" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addinformation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=bar;
    
    
    
    //添加手势
 UITapGestureRecognizer*   tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tapGesture.delegate = self;
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [self.root_view addGestureRecognizer:tapGesture];
    
    
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
- (IBAction)Editing:(UIButton*)sender {
    
    if (sender.tag==88) {
        
        _AddOrEdit=@"edit";
        _Name.enabled=YES;
        _tel.enabled=YES;
        _address.enabled=YES;
        _Youbian.enabled=YES;
        _Address_textview.editable=YES;

    }else{
        _Name.enabled=NO;
        _tel.enabled=NO;
        _address.enabled=NO;
        _Youbian.enabled=NO;
        _Address_textview.editable=NO;
        
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
        
        NSMutableDictionary *diction=[[NSMutableDictionary alloc]init];
        [diction setObject:_Name.text forKey:@"name"];
        [diction setObject:_tel.text forKey:@"telphone"];
        [diction setObject:_Address_textview.text forKey:@"address"];
        [diction setObject:_Youbian.text forKey:@"youbian"];
        
        if ([_AddOrEdit isEqualToString:@"edit"]) {
            [Arr_Information replaceObjectAtIndex:(NSInteger)_interger withObject:diction];
        }else{
        [Arr_Information addObject:diction];
        }
        
        diction=nil;
        self.root_view.hidden=YES;
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
    
//    cell.textLabel.text=@"321";
//    cell.detailTextLabel.text=@"广东省广州市海珠区小港新街888号小月湾大厦B座2308室";
//
    cell.reportNumL.text = @"321";
    cell.accidentDateL.text =@"广东省广州市海珠区小港新街888号小月湾大厦B座2308室";
    
    if ([Arr_Information count]>0) {
        cell.reportNumL.text=[[Arr_Information objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.accidentDateL.text=[[Arr_Information objectAtIndex:indexPath.row] objectForKey:@"address"];
        
    }
  
    cell.Defaultbutton.tag=500+indexPath.row;
    [cell.Defaultbutton setBackgroundColor:[UIColor clearColor]];

    if (cell.Defaultbutton.tag==_deault) {
        [cell.Defaultbutton setBackgroundColor:[UIColor redColor]];

    }
    [cell.Defaultbutton addTarget:self action:@selector(defaultOfseclect:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.textLabel.font=[UIFont systemFontOfSize:16];
	return cell;
}

-(void)defaultOfseclect:(UIButton *)sender{
 
    NSLog(@"==%d",sender.tag);
    _deault=sender.tag;
    [_rootTableView reloadData];
    
    NSLog(@"==%@",[[Arr_Information objectAtIndex:sender.tag-500] objectForKey:@"name"]);
    NSLog(@"==%@",[[Arr_Information objectAtIndex:sender.tag-500] objectForKey:@"telphone"]);
    NSLog(@"==%@",[[Arr_Information objectAtIndex:sender.tag-500] objectForKey:@"address"]);
    NSLog(@"==%@",[[Arr_Information objectAtIndex:sender.tag-500] objectForKey:@"youbian"]);

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    _interger=indexPath.row ;
    self.root_view.hidden=NO;

    [self.view addSubview:_root_view];

    
    self.editing.hidden=NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

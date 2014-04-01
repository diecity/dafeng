//
//  ApplicantInfoInputViewController.m
//  DTC_YGJT
//
//  Created by feng gang on 12-4-9.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPInputTableViewController.h"
#import "CPCaptionItem.h"
#import "CPSingleSelectTextField.h"
#import "CPDatePicker.h"
#import "CPSegmentedControl.h"
#import "CPTelephoneView.h"

@implementation CPInputTableViewController

@synthesize delegate, didFinishedModify, userInputListArray, preActiveField, dataSource, allUsrInputDic, describe, dataFileName;

static CGFloat x = 126;
static CGFloat y = 6;
static CGFloat width = 170;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableViewDataSource];
    // Do any additional setup after loading the view from its nib.
}

-(void)initTableViewDataSource{
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 416) style:UITableViewStyleGrouped] autorelease];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self initUserInputView];
    
}

//初始化用户输入框界面
- (void)initUserInputView{
    
    NSDictionary *userInputDic =  [DTGlobal readJSONFileToDic:dataFileName];
    
    //取得第0个section的数据,并取得它的输入框数组
    NSArray *textFieldArray = [[userInputDic objectForKey:@"userInputInfo"] objectForKey:@"textField"];
    
    
    
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    //给datasource赋值
    for (NSDictionary *dic in textFieldArray) {
        NSString *controlType   = [dic objectForKey:@"type"];
        NSString *caption       = [dic objectForKey:@"label"];
        //取得非空时的提示语
        NSString *alertText   = [dic objectForKey:@"placeHolder"];
        //将请选择 请输入等字样去除
        NSString *placeHolder   = [alertText substringFromIndex:3];
        NSString *name          = [dic objectForKey:@"name"];
        NSInteger tag           = [[dic objectForKey:@"tag"]intValue];
        CPCaptionItem *item     = nil;
        CGRect frame = CGRectMake(x, y, width, 31);
        //如果是textField,只有文本输入
        if ([controlType isEqualToString:@"textField"]) {
            
            UITextField *textField = [self createTextField:frame placeHolder:placeHolder tag:tag];
            //将数据放置到item中,用于后期取数据方便
            item = [CPCaptionItem itemWithCaption:caption control:textField];
        }else if([controlType isEqualToString:@"dateSelect"]){
            //日期选择框
            CPDatePicker *datePicker = [[[CPDatePicker alloc]initWithFrame:frame] autorelease];
            [datePicker setDelegate:self];
            datePicker.tag = tag;
            [datePicker setDidFinishSelect:@selector(didDateSelectFinished:)];
            
            item = [CPCaptionItem itemWithCaption:caption control:datePicker];
        }else if([controlType isEqualToString:@"singleSelect"]){
            //单选框
            CPSingleSelectTextField *selField = [[[CPSingleSelectTextField alloc]initWithFrame:frame] autorelease];
            NSArray *selectArray = [dic objectForKey:@"option"];
            selField.placeholder = placeHolder;
            
            //选择完成后,需要回调
            [selField setSelectDelegate:self];
            [selField setDidFinishedSelect:@selector(didSingleSelectFinished:)];
            
            [selField setSelectArray:selectArray];
            selField.tag = tag;
            //将数据放置到item中,用于后期取数据方便
            item = [CPCaptionItem itemWithCaption:caption control:selField];
        }else if([controlType isEqualToString:@"segmentSelect"]){
            //性别选择框或者是否骨折等
            NSArray *selectArray = [dic objectForKey:@"option"];
            CPSegmentedControl *segment = [[[CPSegmentedControl alloc]initWithCPItems:selectArray] autorelease];
            [segment setFrame:frame];
            segment.tag = tag;
            //将数据放置到item中,用于后期取数据方便
            item = [CPCaptionItem itemWithCaption:caption control:segment];
        }else if([controlType isEqualToString:@"telephone"]){
            CPTelephoneView *tv = [[CPTelephoneView alloc] initWithFrame:frame];
            tv.tag = tag;
            item = [CPCaptionItem itemWithCaption:caption control:tv];
            [tv release];
        }
        item.controlName    = name;
        item.alertText      = alertText;
        item.tag            = tag;
        [array addObject:item];
    }
    
    NSString *sectionTitle = [[userInputDic objectForKey:@"userInputInfo"] objectForKey:@"sectionTitle"];
    
    //初始化datasource
    self.allUsrInputDic = [NSDictionary dictionaryWithObjectsAndKeys:
                           sectionTitle, @"sectionTitle",
                           array, @"item",
                           nil];
    self.dataSource = allUsrInputDic;
}

//将生成输入框的代码提取出来
-(UITextField *)createTextField:(CGRect)frame placeHolder:(NSString*)placeHolder tag:(NSInteger)tag{
    //生成输入框
    UITextField *textField = [[[UITextField alloc]initWithFrame:frame] autorelease];
    textField.borderStyle = UITextBorderStyleNone;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.placeholder = placeHolder;
    textField.delegate = self;
    textField.tag = tag;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.background = [UIImage imageNamed:@"textfieldBg"];
    //文字右边距
    CGFloat width = 5;
    
    frame.origin.x = textField.frame.origin.x + (textField.frame.size.width - 2*width);
    frame.size.width = width;
    UIView *rightView = [[UIView alloc] initWithFrame:frame];
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightView = rightView;
    [rightView release];
    
    //设置文字左边距
    frame.origin.x = textField.frame.origin.x;
    UIView *leftView = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftView;
    [leftView release];
    
    //当编辑时,出现x删除按钮
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[dataSource objectForKey:@"item"] count];
    //return 5;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    return [dataSource objectForKey:@"sectionTitle"];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    NSInteger row = [indexPath row];
    //取出item
    NSArray *array = [self.dataSource objectForKey:@"item"];
    CPCaptionItem *item = [array objectAtIndex:row];
    UIControl *control = item.control;
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 128, 24)] autorelease];
    [label setText:item.captionText];
    [label setBackgroundColor:[UIColor clearColor]];
    label.adjustsFontSizeToFitWidth = YES;
    
    [cell addSubview:label];
    [cell addSubview:control];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the cell...
//    cell.contentView.backgroundColor = [UIColor clearColor];
//    cell.backgroundColor = RGBCOLOR(237, 231, 226);
    return cell;
}

#pragma mark - textField delegate 

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

//取得item中的控件
- (UIControl *)itemControlWithTag:(NSInteger)tag{
    for (CPCaptionItem *item in [self.dataSource objectForKey:@"item"]) {
        if (item.tag == tag) {
            return item.control;
        }
    }
    return nil;
}

//单选框选择完成后的回调
-(void)didSingleSelectFinished:(NSDictionary *)dic{
    
}

//日期选择完成后的回调
-(void)didDateSelectFinished:(CPDatePicker *)datePicker{
    
}


- (void) dealloc{
    TT_RELEASE_SAFELY(userInputListArray);
    TT_RELEASE_SAFELY(preActiveField);
    TT_RELEASE_SAFELY(dataSource);
    TT_RELEASE_SAFELY(allUsrInputDic);
    TT_RELEASE_SAFELY(describe);
    TT_RELEASE_SAFELY(dataFileName);
    [super dealloc];
}

@end

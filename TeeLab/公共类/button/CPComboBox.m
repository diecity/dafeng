//
//  CPComboBox.m
//  YDYW
//
//  Created by HsiehWangKuei on 14-1-18.
//  Copyright (c) 2014年 minan. All rights reserved.
//

#import "CPComboBox.h"
#import "TableViewWithBlock.h"
#import "UITableView+DataSourceBlocks.h"
#import <QuartzCore/QuartzCore.h>

@implementation CPComboBox

@synthesize textField = _textField;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initComboBox];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        [self initComboBox];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initComboBox
{
    _isOpened = NO;
    
//    CGRect subFrame = self.bounds;
//    UITextField* textField = [[[UITextField alloc] initWithFrame:subFrame] autorelease];
//    textField.font = [UIFont systemFontOfSize:14];
////    textField.backgroundColor = [UIColor cyanColor];
//    textField.borderStyle = UITextBorderStyleNone;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    textField.enabled = NO;
//    self.textField = textField;
//    //    self.textField.placeholder = @"点击选择日期";
//    [self addSubview:_textField];
    
    [self addTarget:self action:@selector(showTableViewBlock) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showTableViewBlock
{
    UIView *supView = self.superview;
    for (UIView *subView in supView.subviews) {
        if ([subView isKindOfClass:[TableViewWithBlock class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGFloat origin_x = self.frame.origin.x, origin_y = self.frame.origin.y + self.frame.size.height, width = self.frame.size.width, height = _dataSource.count > 4?176:88;
    if (self.tableView) {
        self.tableView = nil;
    }
    
    width=200;
    height=150;
    _tableView = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(origin_x, origin_y, width, height) style:UITableViewStylePlain];
    [_tableView initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView, NSInteger section) {
        return _dataSource.count;
    } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
//        cell.textLabel.font = [UIFont systemFontOfSize:11];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@",[_dataSource objectAtIndex:indexPath.row]];
        
        UIImageView*imeg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        imeg.image=[UIImage imageNamed:@"UMS_sina_icon.png"];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(40, 0, 50, 30);
        [btn setTitle:@"adsdff" forState:UIControlStateNormal];
        [btn setTintColor:[UIColor redColor]];
        btn.titleLabel.font=[UIFont systemFontOfSize:10];
        [btn addTarget:self action:@selector(cpconmbuton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel*labe=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 120, 30)];
        labe.text=[NSString stringWithFormat:@"%@",[_dataSource objectAtIndex:indexPath.row]];
        labe.backgroundColor=[UIColor clearColor];
        labe.font=[UIFont systemFontOfSize:10];

        [cell.contentView addSubview:imeg];
        [cell.contentView addSubview:btn];
        [cell.contentView addSubview:labe];

        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
//        UITableViewCell *cellSelected = [tableView cellForRowAtIndexPath:indexPath];
        _selectedIndex = indexPath.row;
        __block NSString *selectedValue = @"";
        selectedValue = [NSString stringWithFormat:@"%@",[_dataSource objectAtIndex:indexPath.row]];
        [self setSelectedValue:[NSString stringWithFormat:@"%@",[_dataSource objectAtIndex:indexPath.row]]];
        [self setTitle:selectedValue forState:UIControlStateNormal];
        [tableView removeFromSuperview];
        [self.delegate recieveValue:_selectedValue];

        
        if (self.didSelectedFinished) {
            self.didSelectedFinished(self,indexPath);
        }
        
    }];
    
    [_tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_tableView.layer setBorderWidth:2];
    
    [supView addSubview:_tableView];
}

-(void)cpconmbuton:(UIButton *)sender{

    NSLog(@"=======cpbutton====");
}

- (void)showComboBox:(void (^)(id, NSIndexPath *))block
{
    self.didSelectedFinished = block;
}

- (void)setSelectedValue:(NSString *)selectedValue
{
    if (_dataSource) {
        [self setSelected:YES];
        if (_selectedValue!=nil && _selectedValue == selectedValue) {
             [_selectedValue release];
        }
       
        _selectedValue = [selectedValue copy];
        _selectedIndex = [_dataSource indexOfObject:selectedValue];
        if (_codeArray && _selectedIndex < _dataSource.count) {
            _selectedCode = [_codeArray objectAtIndex:_selectedIndex];
        }
        
        [self setTitle:selectedValue forState:UIControlStateNormal];

    }
}

- (void)setSelectedCode:(NSString *)selectedCode
{
    if (_codeArray) {
        [self setSelected:YES];
        if (_selectedCode!=nil && _selectedCode == selectedCode) {
            [_selectedCode release];
        }
        
        _selectedCode = [selectedCode copy];
        _selectedIndex = [_codeArray indexOfObject:selectedCode];
        if (_dataSource && _selectedIndex < _codeArray.count) {
            _selectedValue = [_dataSource objectAtIndex:_selectedIndex];
        }
        
        [self setTitle:_selectedValue forState:UIControlStateNormal];
    }
}

- (void)dealloc
{
    [_textField release];
    if (self.tableView) {
        self.tableView = nil;
    }
    if (self.dataSource) {
        self.dataSource = nil;
    }
    if (self.codeArray) {
        self.codeArray = nil;
    }
    
    if (self.selectedValue) {
        self.selectedValue = nil;
    }
    if (self.selectedCode) {
        self.selectedCode = nil;
    }
    if (_didSelectedFinished) {
        [_didSelectedFinished release];
    }
    
    [super dealloc];
}

@end

//
//  CPComboBox.h
//  YDYW
//
//  Created by HsiehWangKuei on 14-1-18.
//  Copyright (c) 2014年 minan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@class TableViewWithBlock;

typedef void (^didSelectedFinished)(id sender,NSIndexPath *indexPath);

@interface CPComboBox : UIButton
{
    BOOL _isOpened;
}

@property (nonatomic, retain) UITextField *textField;
@property (assign) SEL didFinishSelect;
@property (nonatomic, retain) TableViewWithBlock *tableView;
@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, retain) NSArray *codeArray;
@property (nonatomic, copy) didSelectedFinished didSelectedFinished;
@property (nonatomic, copy)   NSString *selectedValue;
@property (nonatomic, copy)   NSString *selectedCode;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (retain, nonatomic) id<PassValueDelegate>delegate;

- (void)showComboBox:(void(^)(id sender,NSIndexPath *indexPath))block;

@end

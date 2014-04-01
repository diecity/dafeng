//
//  CPTable.h
//  DTC_TK
//
//  Created by feng gang on 12-6-19.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPTable : UIView <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
	UIScrollView *leftScrollView;
	UIScrollView *rightScrollView;
	
	UITableView *leftTableView;
	UITableView *rightTableView;
	
	NSMutableArray *titleArray;
	UIView *view2;
    
    //取得第一列的宽度
    NSInteger headerWidth ;
    
    //取得第一列的高度
    NSInteger headerHeight;
    
    //取得scrollview的高度
    NSInteger scrollViewHeight ;
    
    //取得scrollview的宽度
    NSInteger scrollViewWidth;
    
    //tr的高度数组
    NSMutableArray *trHeightArray;
    
    //td的宽度数组
    NSMutableArray *tdWidthArray;
    
    //所有的tr数组
    NSMutableArray *allTrArray;
}

- (void)loadTableWithDictionary:(NSDictionary *)dic;

@end

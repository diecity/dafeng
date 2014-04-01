//
//  CPTable.m
//  DTC_TK
//
//  Created by feng gang on 12-6-19.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPTable.h"

@implementation CPTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)loadTableWithDictionary:(NSDictionary *)dic{
    
    //取得table的数据
    NSDictionary *table = dic;
    CGRect frame = self.frame;
    
    //取得公共的高宽
    NSString *trHeight = [table objectForKey:@"height"];
    NSString *tdWidth = [table objectForKey:@"width"];
    
    //取得tr数组
    allTrArray = [[NSMutableArray alloc] initWithArray:[table objectForKey:@"tr"]];
    tdWidthArray  = [[NSMutableArray alloc] init];
    trHeightArray  = [[NSMutableArray alloc] init];
    
    NSArray *tdArray = [[allTrArray objectAtIndex:0] objectForKey:@"td"];
    
    
    //取得scrollview的宽度
    scrollViewWidth = 0;
    
    //配置各列的宽度
    for (NSDictionary *dic in [[allTrArray objectAtIndex:0] objectForKey:@"td"]) {
        //如果该列配置了width属性,则取它的width,否则,取table节点中配置的width
        if ([dic objectForKey:@"width"]) {
            [tdWidthArray addObject:[dic objectForKey:@"width"]];
            scrollViewWidth = scrollViewWidth + [[dic objectForKey:@"width"] intValue];
        }else{
            [tdWidthArray addObject:tdWidth];
            scrollViewWidth = scrollViewWidth + [tdWidth intValue];
        }
    }
    
    //取得scrollview的高度
    scrollViewHeight = 0;
    
    //配置各行的高度
    for (NSDictionary *dic in allTrArray) {
        //如果该列配置了width属性,则取它的width,否则,取table节点中配置的width
        if ([dic objectForKey:@"height"]) {
            [trHeightArray addObject:[dic objectForKey:@"height"]];
            scrollViewHeight = scrollViewHeight + [[dic objectForKey:@"height"] intValue];
        }else{
            [trHeightArray addObject:trHeight];
            scrollViewHeight = scrollViewHeight + [trHeight intValue];
        }
    }
    
    //配置生成第一行的title
    titleArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [tdArray count]; i++) {
        NSString *title = [[tdArray objectAtIndex:i] objectForKey:@"text"];
        [titleArray addObject:title];
    }
    
    //取得第一列的宽度
    headerWidth = [[tdWidthArray objectAtIndex:0] intValue];
    
    //取得第一列的高度
    headerHeight = [[trHeightArray objectAtIndex:0] intValue];
    
    //添加标题行
    UIView *th0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, headerHeight)];
	th0.backgroundColor = [UIColor grayColor];
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, headerWidth, headerHeight)];
	nameLabel.backgroundColor = [UIColor clearColor];
	nameLabel.font = [UIFont systemFontOfSize:15];
	nameLabel.text = [titleArray objectAtIndex:0];
	[th0 addSubview:nameLabel];
	[nameLabel release];
	[self addSubview:th0];
	
	view2 = [[UIView alloc] initWithFrame:CGRectMake(headerWidth, 0, scrollViewWidth - headerWidth, headerHeight)];
	view2.backgroundColor = [UIColor grayColor];
	
    
    NSInteger x = 0;
    for(int i=1;i<[titleArray count];i++)
	{
        //取得当前列的宽度
        NSInteger tdWidth = [[tdWidthArray objectAtIndex:i] intValue];
        
		UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, tdWidth, headerHeight)];
		tmpLabel.backgroundColor = [UIColor clearColor];
		tmpLabel.font = [UIFont systemFontOfSize:15];
		tmpLabel.text = [titleArray objectAtIndex:i];
		tmpLabel.textAlignment = UITextAlignmentCenter;
		[view2 addSubview:tmpLabel];
		[tmpLabel release];
        
        x = x + tdWidth;
	}
    
	[self addSubview:view2];
    //用于上下滚动
	leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, headerHeight, 320, 480 - headerHeight - 64  - frame.origin.y)];
	leftScrollView.backgroundColor = [UIColor clearColor];
	leftScrollView.bounces = NO;
    
    //用于左右滚动 和 上下滚动
	rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(headerWidth, 0, 320-headerWidth, scrollViewHeight - headerHeight)];
	rightScrollView.backgroundColor = [UIColor clearColor];
	rightScrollView.alwaysBounceHorizontal = FALSE;
	rightScrollView.bounces = NO;
	rightScrollView.delegate = self;
	
	[self addSubview:leftScrollView];
	[leftScrollView addSubview:rightScrollView];
	
	rightScrollView.directionalLockEnabled = YES;
	
	
	leftScrollView.contentSize = CGSizeMake(320, scrollViewHeight - headerHeight);
	rightScrollView.contentSize = CGSizeMake(scrollViewWidth - headerWidth, scrollViewHeight - headerHeight);
	rightScrollView.directionalLockEnabled = YES;
	
	
	leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, scrollViewHeight - headerHeight)];
	leftTableView.delegate = self;
	leftTableView.dataSource = self;
	leftTableView.scrollEnabled = NO;
	leftTableView.alwaysBounceHorizontal = FALSE;
	leftTableView.bounces = NO;
	[leftScrollView addSubview:leftTableView];
	leftTableView.backgroundColor = [UIColor blackColor];
	leftTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
	
	rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, scrollViewWidth - headerWidth, scrollViewHeight - headerHeight)];
	rightTableView.delegate = self;
	rightTableView.dataSource = self;
	rightTableView.scrollEnabled = NO;
	rightTableView.bounces = NO;
	rightTableView.alwaysBounceHorizontal = FALSE;
	[rightScrollView addSubview:rightTableView];
	rightTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
	rightTableView.backgroundColor = [UIColor blackColor];
}


#pragma mark ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
    CGRect frame = view2.frame;
    
	view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, frame.size.width, frame.size.height);
	view2.clipsToBounds = YES;	
	view2.backgroundColor = [UIColor grayColor];
	[rightTableView reloadData];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.0];
	CGRect frame = view2.frame;
    
	view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, frame.size.width, frame.size.height);
	
	view2.clipsToBounds = YES;
    //	[self.view addSubview:view2];
	[UIView commitAnimations];
	
}


#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [trHeightArray count] - 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[trHeightArray objectAtIndex:indexPath.row + 1] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == leftTableView)
	{
		static NSString *cellIdetify = @"cell1";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
		if(!cell)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] autorelease];
		}
		NSArray *td = [[allTrArray objectAtIndex:indexPath.row + 1] objectForKey:@"td"];
		cell.textLabel.text = [[td objectAtIndex:0] objectForKey:@"text"];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.backgroundColor = [UIColor clearColor];
		return cell;
	}
	else {
		static NSString *cellIdetify = @"cell1";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
		if(!cell)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] autorelease];
            
            //取得当前行的td数组
            NSArray *td = [[allTrArray objectAtIndex:indexPath.row + 1] objectForKey:@"td"];
            NSInteger height = [[trHeightArray objectAtIndex:indexPath.row + 1] intValue];
			NSInteger x = 0;
            
            for (int i = 1; i < [td count]; i++) {
                
                NSDictionary *dic = [td objectAtIndex:i];
                
                //当前列的宽度
                NSInteger width = [[tdWidthArray objectAtIndex:i] intValue];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, height)];
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.lineBreakMode = UILineBreakModeCharacterWrap;
                
                //最多显示3行,如果文字,太多,需要增加该列的宽度
                label.numberOfLines = 3;
                label.text = [dic objectForKey:@"text"];
                [cell.contentView addSubview:label];
                
                [label release];
                x = x + width;
            }
		}
        
		return cell;
	}
	
}

- (void)dealloc {
    TT_RELEASE_SAFELY(leftScrollView);
    TT_RELEASE_SAFELY(rightScrollView);
    TT_RELEASE_SAFELY(leftTableView);
    TT_RELEASE_SAFELY(rightTableView);
    TT_RELEASE_SAFELY(titleArray);
    TT_RELEASE_SAFELY(view2);
    TT_RELEASE_SAFELY(trHeightArray);
    TT_RELEASE_SAFELY(tdWidthArray);
    TT_RELEASE_SAFELY(allTrArray);
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

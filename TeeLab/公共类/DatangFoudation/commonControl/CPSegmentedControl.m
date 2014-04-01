//
//  CPSegmentedControl.m
//  DTC_YGJT
//
//  Created by feng gang on 12-5-24.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import "CPSegmentedControl.h"

@implementation CPSegmentedControl

@synthesize segmentItems,selectedID;

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithCPItems:(NSArray *)items{
    self.segmentItems = items;
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in items ) {
        [array addObject:[dic objectForKey:@"text"]];
    }
    self = [super initWithItems:array];
    
    [self addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    return self;
}

//控件 变动事件
-(void)segmentAction:(CPSegmentedControl *)segment{
    self.selectedID = [[segmentItems objectAtIndex:[segment selectedSegmentIndex]] objectForKey:@"id"];
}

-(void)setSegmentSelectedIndexWithText:(NSString *)text{
    for (int i = 0 ; i < [segmentItems count] ; i ++ ) {
        NSDictionary *dic = [segmentItems objectAtIndex:i];
        if ([text isEqualToString:[dic objectForKey:@"text"]]) {
            self.selectedSegmentIndex = i;
            self.selectedID = [dic objectForKey:@"id"];
            return;
        }
    }
}

-(void)setSegmentSelectedIndexWithID:(NSString *)segID{
    for (int i = 0 ; i < [segmentItems count] ; i ++ ) {
        NSDictionary *dic = [segmentItems objectAtIndex:i];
        if ([segID isEqualToString:[dic objectForKey:@"id"]]) {
            self.selectedSegmentIndex = i;
            self.selectedID = segID;
            return;
        }
    }
}

-(void)dealloc{
    [segmentItems release];
    [selectedID release];
    [super dealloc];
}
@end

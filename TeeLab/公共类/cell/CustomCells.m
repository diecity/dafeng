//
//  CommonViews.m
//  tp_self_help
//
//  Created by cloudpower on 13-7-24.
//  Copyright (c) 2013年 cloudpower. All rights reserved.
//

#import "CustomCells.h"

@implementation CustomCells

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //设置tap手势，用于关闭键盘
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
        tapGestureRecognizer.delegate = self;
        [tapGestureRecognizer setNumberOfTapsRequired:1];
        [tapGestureRecognizer setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)onTap:(id)sender{
    if ([self.delegate respondsToSelector:@selector(leftImgTaped:)] ){
        [self.delegate leftImgTaped:_leftImgView];
    }
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

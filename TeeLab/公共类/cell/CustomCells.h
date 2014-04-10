//
//  CommonViews.m
//  tp_self_help
//
//  Created by teelab2 on 14-4-8.
//  Copyright (c) 2014年 TeeLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCellDelegate <NSObject>

@optional
- (void)leftImgTaped:(UIImageView*)imgView;

@end

@interface CustomCells : UITableViewCell<
UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tapGestureRecognizer;
}

//cell 0
@property (nonatomic, retain) IBOutlet UILabel             *centerLabel;
@property (nonatomic, retain) IBOutlet UIImageView         *leftImgView;

@property (nonatomic, assign) id<CustomCellDelegate> delegate;



//cell 1
@property (nonatomic, retain) IBOutlet  UILabel             *reportNumL;
@property (strong, nonatomic) IBOutlet UIButton *Defaultbutton;
@property (nonatomic, retain) IBOutlet  UILabel             *accidentDateL;

@end

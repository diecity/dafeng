//
//  CommonViews.h
//  tp_self_help
//
//  Created by cloudpower on 13-7-24.
//  Copyright (c) 2013年 cloudpower. All rights reserved.
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

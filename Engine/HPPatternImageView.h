//
//  HPPatternImageView.h
//  V-POS
//
//  Created by nick liu on 12-11-11.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPPatternImageView : UIView

@property (nonatomic, retain) UIImage *image;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)img;
- (void)refreshImag:(UIImage *)img;
@end

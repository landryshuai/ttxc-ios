//
//  GuideViewController.h
//  ttxc
//
//  Created by shuaijiman on 7/14/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *left;
@property (nonatomic,strong) UIImageView *right;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *gotoMainViewBtn;
- (IBAction)gotoMainView:(id)sender;

@end

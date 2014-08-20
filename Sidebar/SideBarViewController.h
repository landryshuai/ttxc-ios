//
//  SideBarViewController.h
//  ttxc
//
//  Created by shuaijiman on 7/16/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface SideBarViewController : UIViewController
<UITableViewDelegate>
@property (nonatomic, weak) MainViewController *delegate;
@end

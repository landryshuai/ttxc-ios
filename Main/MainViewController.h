//
//  MainViewController.h
//  ttxc
//
//  Created by shuaijiman on 7/14/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SideBarViewController;
@interface MainViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SideBarViewController *leftSidebarViewController;
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, strong) NSArray *listImg;
@property (nonatomic) NSInteger selectedPos;
@end

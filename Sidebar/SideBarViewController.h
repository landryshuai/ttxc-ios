//
//  SideBarViewController.h
//  ttxc
//
//  Created by shuaijiman on 7/16/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SideBarViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, strong) NSArray *listImg;
@property (nonatomic) NSInteger selectedPos;
@property (nonatomic,weak) UINavigationController *navControll;
@end

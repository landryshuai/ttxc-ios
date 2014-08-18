//
//  TTXCAppDelegate.h
//  ttxc
//
//  Created by shuaijiman on 7/14/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuideViewController;
@interface TTXCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GuideViewController *guideViewController;
@property (strong, nonatomic) UINavigationController *navController;
@end

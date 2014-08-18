//
//  XCLoginViewController.h
//  ttxc
//
//  Created by shuaijiman on 8/7/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountPwd;
- (IBAction)onClick:(id)sender;
- (IBAction)btnRegister:(id)sender;
- (IBAction)btnForgetPwd:(id)sender;

@end

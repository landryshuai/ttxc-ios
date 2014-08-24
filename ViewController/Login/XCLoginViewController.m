//
//  XCLoginViewController.m
//  ttxc
//
//  Created by shuaijiman on 8/7/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import "XCLoginViewController.h"
#import "CategoryUtil.h"
#import "ZZTongUIEngine.h"
#import "XHHTTPClient.h"
#import "TTXCDefine.h"

@interface XCLoginViewController ()

@end

@implementation XCLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString* log =[NSString stringWithFormat:@"login in initWithNibName:%@", nibNameOrNil];
    NSLog(@"%@",log);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender {
    //校验
    NSString* userName = self.accountTextField.text;
    if ([NSString isNilOrEmpty:userName]) {
        [HPUIENG showAlert:@"请输入手机号"];
        [self.accountTextField becomeFirstResponder];
        return;
    }
    
    NSString* pwd = self.accountPwd.text;
    
    if ([NSString isNilOrEmpty:pwd]) {
        [HPUIENG showAlert:@"请输入密码"];
        [self.accountPwd becomeFirstResponder];
        return;
    }
    
    self.accountPwd.text = @"";
    
    [self.accountPwd resignFirstResponder];
    [self.accountTextField resignFirstResponder];
    NSMutableString *server = [[NSMutableString alloc] init];
    [server appendFormat:@"%@/%@", BASE_SERVER_URL, ACTION_LOGIN];
    [XHHTTPClient GETPath:[server description] parameters:[NSDictionary dictionaryWithObjectsAndKeys:pwd,@"password",userName,@"phoneNumber", nil] jsonSuccessHandler:^(id json){
        NSLog(@"%@", json);
    } failureHandler:^(NSData *responseData, NSURLResponse *response, NSError *error){
        NSLog(@"%@, error:%@, responseData:%@", response, error, responseData);
    }];
}

- (IBAction)btnRegister:(id)sender {
}

- (IBAction)btnForgetPwd:(id)sender {
}
@end

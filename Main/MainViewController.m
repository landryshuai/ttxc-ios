//
//  MainViewController.m
//  ttxc
//
//  Created by shuaijiman on 7/14/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import "MainViewController.h"
#import "JTRevealSidebarV2Delegate.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "SideBarViewController.h"
#import "ZZTongClientEngine.h"
#import "XCLoginViewController.h"
@interface MainViewController ()<JTRevealSidebarV2Delegate>

@end

@implementation MainViewController
@synthesize leftSidebarViewController;
@synthesize listData = _listData;
@synthesize listImg = _listImg;
@synthesize selectedPos;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"MainViewController view DidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(revealLeftSidebar:)];
    self.navigationItem.title = NSLocalizedStringFromTable(@"MAINTITLE",@"Localization", nil);    self.navigationItem.revealSidebarDelegate = self;
    NSArray *array = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"MENUPAYLIST",@"Localization", nil),
                      NSLocalizedStringFromTable(@"MENUIFCENTER",@"Localization", nil),
                      NSLocalizedStringFromTable(@"MENUFREIND",@"Localization", nil),
                      NSLocalizedStringFromTable(@"MENUSETTING",@"Localization", nil),
                      NSLocalizedStringFromTable(@"MENUEXIT",@"Localization", nil),nil];
    NSArray *arrayImg = [[NSArray alloc] initWithObjects:        [UIImage imageNamed:@"xfjl.jpg"],
                         [UIImage imageNamed:@"sz.jpg"],
                         [UIImage imageNamed:@"zshy.jpg"],
                         [UIImage imageNamed:@"sz.jpg"],
                         [UIImage imageNamed:@"zx.jpg"], nil];
    self.listImg = arrayImg;
    self.listData = array;
    array = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

#pragma mark JTRevealSidebarDelegate

// This is an examle to configure your sidebar view through a custom UIViewController
- (UIView *)viewForLeftSidebar {
    // Use applicationViewFrame to get the correctly calculated view's frame
    // for use as a reference to our sidebar's view
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    SideBarViewController *controller = self.leftSidebarViewController;
    if (!controller) {
        self.leftSidebarViewController = [[SideBarViewController alloc] init];
        controller = self.leftSidebarViewController;
        controller.title = @"LeftSidebarViewController";
    }
    self.leftSidebarViewController.delegate = self;
    //20px here. why title bar's height
    NSLog(@"viewFrame.origin.y:%f",viewFrame.origin.y);
    controller.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

// Optional delegate methods for additional configuration after reveal state changed
- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController {
    // Example to disable userInteraction on content view while sidebar is revealing
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

#pragma mark TableView DataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"menu";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSInteger row = [indexPath row];
    cell.textLabel.text = [self.listData objectAtIndex:row];
    cell.imageView.image = [self.listImg objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //保存之前选择的位置
    selectedPos = [indexPath row];
    //没有登录，进入登录界面
    if (![[ZZTongClientEngine sharedInstance] isLogin]) {
        /*XCLoginViewController* login = [[XCLoginViewController alloc] initWithNibName:@"XCLoginViewController" bundle:nil];*/
        XCLoginViewController *login = [[XCLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        return;
    }
    [self menuClick:selectedPos];
    
}

-(void) menuClick:(NSInteger)pos
{
    //reset Pos
    selectedPos = -1;
}
@end

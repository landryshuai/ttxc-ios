//
//  SideBarViewController.m
//  ttxc
//
//  Created by shuaijiman on 7/16/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import "SideBarViewController.h"
#import "ZZTongClientEngine.h"
#import "XCLoginViewController.h"
#import "PKRevealController.h"

@interface SideBarViewController ()
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, strong) NSArray *listImg;
@property (nonatomic) NSInteger selectedPos;
@end

@implementation SideBarViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupData];
    }
    return self;
}

- (void) setupData
{
    //self.navigationItem.revealSidebarDelegate = self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.revealController setMinimumWidth:220.0 maximumWidth:244.0 forViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.selectedPos = [indexPath row];
    //没有登录，进入登录界面
    if (![[ZZTongClientEngine sharedInstance] isLogin]) {
        /*XCLoginViewController* login = [[XCLoginViewController alloc] initWithNibName:@"XCLoginViewController" bundle:nil];*/
        XCLoginViewController *login = [[XCLoginViewController alloc] init];
        //[self.revealController.frontViewController pushViewController:login animated:NO];
        [self showViewController:login];
        //[self presentViewController:login animated:YES completion:nil];
        return;
    }
    [self menuClick:self.selectedPos];
    
}

- (void)showViewController:(UIViewController*) controller
{
    [self.revealController setFrontViewController:controller];
    [self.revealController showViewController:self.revealController.frontViewController animated:YES completion:nil];
//    [self.revealController resignPresentationModeEntirely:YES
//                                                 animated:YES completion:nil];
    /*if ([self.revealController.frontViewController respondsToSelector:@selector(pushViewController:animated:)]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self.revealController.frontViewController methodSignatureForSelector:@selector(pushViewController:animated:)]];
        [inv setSelector:@selector(pushViewController:animated:)];
        [inv setArgument:&controller atIndex:2];
        BOOL ani = YES;
        [inv setArgument:&ani atIndex:3];
        [inv invokeWithTarget:self.revealController.frontViewController];
    }*/
}

-(void) menuClick:(NSInteger)pos
{
    //reset Pos
    self.selectedPos = -1;
}

@end

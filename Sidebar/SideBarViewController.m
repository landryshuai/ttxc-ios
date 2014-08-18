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

@interface SideBarViewController ()

@end

@implementation SideBarViewController
@synthesize listData = _listData;
@synthesize listImg = _listImg;
@synthesize selectedPos;
@synthesize navControll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectedPos = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
        XCLoginViewController* login = [[XCLoginViewController alloc] initWithNibName:@"XCLoginViewController" bundle:nil];
        [self.navControll pushViewController:login animated:YES];
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

//
//  SideBarViewController.m
//  ttxc
//
//  Created by shuaijiman on 7/16/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import "SideBarViewController.h"

@interface SideBarViewController ()

@end

@implementation SideBarViewController
@synthesize delegate;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView DataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([self.delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
//        return [self.delegate performSelector:@selector(tableView:numberOfRowsInSection:) withObject:tableView withObject:nil];
//    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        return [self.delegate performSelector:@selector(tableView:cellForRowAtIndexPath:) withObject:tableView withObject:indexPath];
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate performSelector:@selector(tableView:didSelectRowAtIndexPath:) withObject:tableView withObject:indexPath];
    }
}
@end

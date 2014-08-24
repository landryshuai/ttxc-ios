//
//  MainViewController.m
//  ttxc
//
//  Created by shuaijiman on 7/14/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import "MainViewController.h"
#import "PKRevealController.h"
#import "XCLoginViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)order:(id)sender {
    //[self startPresentationMode];
//    [self.revealController showViewController:self.revealController.leftViewController
//     animated:NO completion:nil];
    XCLoginViewController *login = [[XCLoginViewController alloc] init];
    //[self.revealController.frontViewController pushViewController:login animated:NO];
    //[self showViewController:login];
    [self presentViewController:login animated:YES completion:nil];
}

- (void)viewDidLoad
{
    NSLog(@"MainViewController view DidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(startPresentationMode)];
    self.navigationItem.title = NSLocalizedStringFromTable(@"MAINTITLE",@"Localization", nil);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)startPresentationMode
{
    [self.revealController showViewController:self.revealController.leftViewController];
    /*if (![self.revealController isPresentationModeActive])
    {
        NSLog(@"isPresentationModeActive false");
        [self.revealController enterPresentationModeAnimated:YES completion:nil];
    }
    else
    {
        NSLog(@"isPresentationModeActive true");
        [self.revealController resignPresentationModeEntirely:NO animated:YES completion:nil];
    }*/
}
@end

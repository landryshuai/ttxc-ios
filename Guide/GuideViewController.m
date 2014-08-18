//
//  GuideViewController.m
//  ttxc
//
//  Created by shuaijiman on 7/14/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import "GuideViewController.h"
#import "MainViewController.h"
#import "UIImage+SplitImageIntoTwoParts.h"

@interface GuideViewController ()

@end

@implementation GuideViewController
@synthesize gotoMainViewBtn = _gotoMainViewBtn;

//@synthesize imageView;
@synthesize left = _left;
@synthesize right = _right;
@synthesize scrollView;
@synthesize pageControl;
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
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, self.view.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear %f , %f", self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, self.view.frame.size.height);
    //self.scrollView.contentSize=CGSizeMake(400.0,600.0);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoMainView:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    MainViewController *controller = [[MainViewController alloc] init];
    //remove GuideViewController
    NSMutableArray* viewControllerArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllerArray removeObjectAtIndex:0];
    self.navigationController.viewControllers = viewControllerArray;
    //show mainViewController
    [self.navigationController pushViewController:controller animated:YES];
//    [self.gotoMainViewBtn setHidden:YES];
//    NSArray *array = [UIImage splitImageIntoTwoParts:self.right.image];
//    self.left = [[UIImageView alloc] initWithImage:[array objectAtIndex:0]];
//    self.right = [[UIImageView alloc] initWithImage:[array objectAtIndex:1]];
//    [self.view addSubview:self.left];
//    [self.view addSubview:self.right];
//    [self.scrollView setHidden:YES];
//    [self.pageControl setHidden:YES];
//    self.left.transform = CGAffineTransformIdentity;
//    self.right.transform = CGAffineTransformIdentity;
//    
//    [UIView beginAnimations:@"split" context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    
//    self.left.transform = CGAffineTransformMakeTranslation(-160 ,0);
//    self.right.transform = CGAffineTransformMakeTranslation(160 ,0);
//    [UIView commitAnimations];
}
-(void)scrollViewDidScroll:(UIScrollView *)sv
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((sv.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}
//-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
//{
//    if ([animationID isEqualToString:@"split"] && finished) {
//        
//        [self.left removeFromSuperview];
//        [self.right removeFromSuperview];
//        MainViewController *controller = [[MainViewController alloc] init];
//        [self presentViewController:controller animated:YES completion:nil];
//    }
//}
@end

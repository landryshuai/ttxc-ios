//
//  ZZTongUIEngine.m
//  V-POS
//
//  Created by handpay on 12-10-24.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import "ZZTongUIEngine.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/CAAnimation.h>
#import "GuideViewController.h"
#import "ZZTongAlertWaitingView.h"

@interface ZZTongUIEngine () {
}

@property (nonatomic, retain) ZZTongAlertWaitingView *alertView;
@property (nonatomic, retain) ZZTongAlertWaitingView *waitingView;

@end


@implementation ZZTongUIEngine
@synthesize mAlertData;
@synthesize mAlertView;
static ZZTongUIEngine* instance = nil;

+ (ZZTongUIEngine*)getInstance{
	if (!instance) {
		instance = [[ZZTongUIEngine alloc] init];
        // 设置导航条
	}
	return instance;
}

+ (void)releaseInstance{
	if (instance) {
		//[instance release];
		instance = nil;
	}
}

// 移除欢迎页面
- (void) removeWelcomeScreen
{
    NSMutableArray* viewControllerArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    UIViewController* tempViewController = [viewControllerArray objectAtIndex:0];
    if ([tempViewController isKindOfClass:[GuideViewController class]]) {
        [viewControllerArray removeObjectAtIndex:0];
        self.navigationController.viewControllers = viewControllerArray;
    }
}

#pragma mark - 公共方法

- (void) uiShowTipsAlertWithMessage:(NSString *)message{
    [self uiShowTipsAlertWithTitle:@"提示" message:message];
}

- (void) uiShowTipsAlertWithTitle:(NSString *)title message:(NSString *)message
{
    ZZTongAlertWaitingView* tempAlertView = [[ZZTongAlertWaitingView alloc] initAlertViewWithTitleTagImageName:@"alert_title_tag.png" title:title message:message];
    self.alertView = tempAlertView;
    //[tempAlertView release];
    tempAlertView = nil;
    [self.alertView addButtonWithTitle:@"确定"];
    [self.alertView show];
}

- (void) showAlertWithTitleTagImageName:(NSString *)titleTagImageName title:(NSString *)title message:(NSString *)message commands:(NSArray *)commands
{
    ZZTongAlertWaitingView* tempAlertView = [[ZZTongAlertWaitingView alloc] initAlertViewWithTitleTagImageName:titleTagImageName title:title message:message];
    self.alertView = tempAlertView;
    //[tempAlertView release];
    
    if(!commands)
    {
        for (NSDictionary * command in commands)
        {
            NSString * label = [command objectForKey:@"label"];
            id obj = [command objectForKey:@"delegate"];
            NSString * clickFunc = [command objectForKey:@"function"];
            SEL func = @selector(onClick:);
            if (clickFunc)
            {
                func = @selector(clickFunc);
            }
            UIButton * button = [self.alertView addButtonWithTitle:label];
            [button addTarget:obj action:func forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [self.alertView show];
}
- (void) onClick:(UIButton *) sender{
    [self dismissAlertOrWaitingView];
}
- (void) showWaitingWithTitle:(NSString *)title
{
    if (self.waitingView) {
        [self.waitingView setTitle:title];
        return;
    }
    
    ZZTongAlertWaitingView* tempWaitingView = [[ZZTongAlertWaitingView alloc] initWaitingViewWithTitle:title];
    self.waitingView = tempWaitingView;
    //[tempWaitingView release];
    
    [self.waitingView show];
}

- (void) dismissAlertOrWaitingView
{
    if (self.alertView) {
        [self.alertView dismiss];
        self.alertView = nil;
    }
    if (self.waitingView) {
        [self.waitingView dismiss];
        self.waitingView = nil;
    }
}


#pragma mark - VPOSAlertWaitingViewDelegate

- (void) dismissAlertView:(ZZTongAlertWaitingView *)alertView_
{
    if (self.alertView == alertView_) {
        self.alertView = nil;
    }
}


- (void)doShowAlert:(AlertData*)alertData{
    [self removeAlert];
    
    UIAlertView* alertView = [[UIAlertView alloc] init];
    alertView.title = alertData.title;
    alertView.message = alertData.message;
    if (!alertData.alertCommandArray || [alertData.alertCommandArray count] == 0) {
        [alertView addButtonWithTitle:@"确定"];
    }else{
        for (AlertCommandData* command in alertData.alertCommandArray) {
            [alertView addButtonWithTitle:command.title];
        }
    }
    
    alertView.delegate = self;
    self.mAlertView = alertView;
    //[alertView release];
    [self.mAlertView show];
}

- (void)showAlert:(NSString*)title msg:(NSString*)msg{
    if (self.mAlertData.isMustOperate) {
        return;
    }
    
    AlertData* alertData = [[AlertData alloc] initAlertData:title message:msg];
    [self showAlertWithData:alertData];
    //[alertData release];
}

- (void)showAlertWithData:(AlertData*)alertData{
    if (self.mAlertData.isMustOperate) {
        return;
    }
    self.mAlertData = alertData;
    [self performSelectorOnMainThread:@selector(doShowAlert:) withObject:alertData waitUntilDone:YES];
}

- (void)doRemoveAlert{
    [self.mAlertView dismissWithClickedButtonIndex:0 animated:NO];
    self.mAlertView = nil;
}

- (void)removeAlert{
    if (self.mAlertData.isMustOperate) {
        return;
    }
    
    if (self.mAlertView) {
        if ([NSThread isMainThread]) {
            [self doRemoveAlert];
        }else{
            [self performSelectorOnMainThread:@selector(doRemoveAlert) withObject:nil waitUntilDone:YES];
        }
    }
}
- (void)showAlert:(NSString *)msg{
    [self showAlert:@"提示" msg:msg];
}


- (id)init{
    self = [super init];
    if (self) {
        [self createNavigationContoller];
    }
    return self;
}

- (void)setBarColor:(UINavigationController*)nav{
    if ([nav.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        //nav.navigationBar.barTintColor = kTitleFontColor;
    }else{
       // nav.navigationBar.tintColor = kTitleFontColor;
    }
}

- (void)createNavigationContoller{
    UINavigationController* nav = [[UINavigationController alloc] init];
    [self setBarColor:nav];
    self.navigationController = nav;
    //[nav release];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = self.navigationController;
}



- (UINavigationController*)getCurrentNavigation{
    if (self.navigationController) {
        return self.navigationController;
    }
    
    return nil;
}


- (void)popToRootScreen:(BOOL)animations{
    UINavigationController* tempNav = [self getCurrentNavigation];
    
    [tempNav popToRootViewControllerAnimated:animations];
}
- (void)popToLoginScreen:(BOOL)animations{
    //self.tabBarController = nil;
    [self.navigationController popToRootViewControllerAnimated:animations];
}
- (void)popScreen:(int)backNum animations:(BOOL)animations
{
    UINavigationController* tempNav = [self getCurrentNavigation];
    
    NSArray* viewControllers = tempNav.viewControllers;
    int controllerCount = (int)viewControllers.count;
    if (controllerCount <= 1) {
        if (![tempNav isEqual:self.navigationController]) {
            //self.tabBarController = nil;
            [self.navigationController popViewControllerAnimated:animations];
        }
        return;
    }
    
    if (backNum >= controllerCount) {
        backNum = controllerCount - 1;
    }
    UIViewController *viewController = [viewControllers objectAtIndex:(controllerCount - backNum - 1)];
   
    [tempNav popToViewController:viewController animated:animations];
    return;
}

-(NSArray*)getCurrentControllerArray{
    UINavigationController* tempNav = [self getCurrentNavigation];
    
    return tempNav.viewControllers;
}





- (void) showWaiting:(NSString*)msg
{
    [self.mAlertView dismissWithClickedButtonIndex:0 animated:NO];
    self.mAlertView = nil;
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    if (version < 7.0){
        [alertView setMessage:@"\n\n"];
        
        UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGRect tempRect = indicatorView.frame;
        tempRect.origin.x = (280 - tempRect.size.width) / 2;
        tempRect.origin.y = 20;
        indicatorView.frame = tempRect;
        
        [alertView addSubview:indicatorView];
        
        [indicatorView startAnimating];
        //[indicatorView release];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 280, 20)];
        label.text = msg;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [alertView addSubview:label];
        //[label release];
        
    }
    
    self.mAlertView = alertView;
    //[alertView release];
    
    [self.mAlertView show];
}


- (void)showNetWaiting{
    [self showWaiting:@"正在加载中..."];
}

- (void)hideNavigationBar:(BOOL)hidden{
    UINavigationController* nav = [self getCurrentNavigation];
    [nav setNavigationBarHidden:hidden];
}



- (void)dealloc {
    
    self.navigationController = nil;
    //self.tabBarController = nil;
    self.alertView = nil;
    self.waitingView = nil;
    
    //[super dealloc];
}

/**
 * 根据经纬度显示地图
 */
- (void) showMapWithLongitude:(CLLocationDegrees)longitude latitude:(CLLocationDegrees)latitude
{
    //    if (self.hpUtilDelegate && [self.hpUtilDelegate respondsToSelector:@selector(showMapWithLongitude:latitude:)]) {
    //        CLLocationDegrees longitude = [[degreesDic objectForKey:@"longitude"] doubleValue];
    //        CLLocationDegrees latitude = [[degreesDic objectForKey:@"latitude"] doubleValue];
    //        [self.hpUtilDelegate showMapWithLongitude:longitude latitude:latitude];
    //    }
}
@end

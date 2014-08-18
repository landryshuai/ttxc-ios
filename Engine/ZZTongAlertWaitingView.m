//
//  ZZTongAlertWaitingView.m
//  V-POS
//
//  Created by handpay on 12-12-20.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import "ZZTongAlertWaitingView.h"
#import "TTXCDefine.h"
#import "HPPatternImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface ZZTongAlertWaitingView ()
{
    // 类别
    ZZTongAlertWaitingViewType type;
    
    // 按钮下标 从1开始
    NSInteger buttonIndex;
    
    BOOL addedButtonFlag;
}

// 内容窗口
@property (retain, nonatomic) UIView *contentView;

// 标题
@property (retain, nonatomic) UILabel *titleLabel;

// 内容
@property (retain, nonatomic) UILabel *messageLabel;

@end

@implementation ZZTongAlertWaitingView

- (void)dealloc
{
    /*[self.contentView release];
    [self.titleLabel release];
    [self.messageLabel release];*/
    self.contentView = nil;
    self.titleLabel = nil;
    self.messageLabel = nil;
    
    //[super dealloc];
}

- (id) initMySelf
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        addedButtonFlag = YES;
        type = ZZTongAlertWaitingViewType_Waiting;
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

- (ZZTongAlertWaitingView *) initWaitingViewWithTitle:(NSString *)title
{
    self = [self init];
    if (!self) {
        return nil;
    }
    self = [self initMySelf];
    type = ZZTongAlertWaitingViewType_Waiting;
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIView *contentView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    [contentView_ setBackgroundColor:UIColorFromRGBA(0x000000, .8)];
    contentView_.layer.masksToBounds = YES;
    contentView_.layer.cornerRadius = 15.;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(52, 35, 37, 37)];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicatorView startAnimating];
    [contentView_ addSubview:activityIndicatorView];
    //[activityIndicatorView release];
    self.contentView = contentView_;
    //[contentView_ release];
    
    [self addSubview:self.contentView];
    
    UILabel *titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 140, 40)];
    [titleLabel_ setBackgroundColor:[UIColor clearColor]];
    [titleLabel_ setNumberOfLines:0];
    [titleLabel_ setTextColor:[UIColor whiteColor]];
    [titleLabel_ setFont:kNormalFont];
    [titleLabel_ setTextAlignment:NSTextAlignmentCenter];
    if (title && title.length > 0) {
        [titleLabel_ setText:title];
    } else {
        [titleLabel_ setText:@"正在加载..."];
    }
    self.titleLabel = titleLabel_;
    //[titleLabel_ release];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView setCenter:self.center];
    
    return self;
}

- (id) initAlertViewWithTitleTagImageName:(NSString *)titleTagImageName title:(NSString *)title
{
    self = [self initMySelf];
    type = ZZTongAlertWaitingViewType_Tips;
    
    [self setBackgroundColor:UIColorFromRGBA(0x000000, .80)];
    
    UIView *contentView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    self.contentView = contentView_;
    //[contentView_ release];
    
    [self addSubview:self.contentView];
    
    [self initBackgroundWithWidth:self.contentView.frame.size.width];
    
    if (titleTagImageName) {
        UIImageView *titleTagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 31, 22, 22)];
        [titleTagImageView setImage:[UIImage imageNamed:titleTagImageName]];
        [self.contentView addSubview:titleTagImageView];
        //[titleTagImageView release];
    }
    
    UILabel *titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 230, 22)];
    [titleLabel_ setBackgroundColor:[UIColor clearColor]];
    [titleLabel_ setTextColor:kNormalFontColor];
    [titleLabel_ setFont:kNormalFont];
    if (title && title.length > 0) {
        [titleLabel_ setText:title];
    } else {
        [titleLabel_ setText:@"温馨提示"];
    }
    self.titleLabel = titleLabel_;
    //[titleLabel_ release];
    
    [self.contentView addSubview:self.titleLabel];
    
    return self;
}

- (ZZTongAlertWaitingViewType) alertWaitingViewType
{
    return type;
}

#define kMaxHeight  280

- (ZZTongAlertWaitingView *) initAlertViewWithTitleTagImageName:(NSString *)titleTagImageName title:(NSString *)title message:(NSString *)message
{
    self = [self init];
    if (!self) {
        return nil;
    }
    self = [self initAlertViewWithTitleTagImageName:titleTagImageName title:title];
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 260, 0)];
    [textLabel setNumberOfLines:0];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setTextColor:kNormalFontColor];
    [textLabel setFont:kNormalFont];
    [textLabel setText:message];
    [textLabel sizeToFit];
    
    float height = textLabel.frame.size.height;
    
    if (height < kMaxHeight) {
        [self.contentView addSubview:textLabel];
    } else {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(textLabel.frame.origin.x, textLabel.frame.origin.y, textLabel.frame.size.width, kMaxHeight)];
        [scrollView setContentSize:CGSizeMake(textLabel.frame.size.width, height)];
        CGRect textLabelFrame = textLabel.frame;
        textLabelFrame.origin = (CGPoint){0, 0};
        textLabel.frame = textLabelFrame;
        [scrollView addSubview:textLabel];
        [self.contentView addSubview:scrollView];
        //[scrollView release];
        height = kMaxHeight;
    }
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.size.height += height;
    self.contentView.frame = contentViewFrame;
    //[textLabel release];
    
    [self.contentView setCenter:self.center];
    
    return self;
}

- (ZZTongAlertWaitingView *) initAlertViewWithTitleTagImageName:(NSString *)titleTagImageName title:(NSString *)title customView:(UIView *)customView
{
    self = [self init];
    if (!self) {
        return nil;
    }
    self = [self initAlertViewWithTitleTagImageName:titleTagImageName title:title];
    
    CGRect customViewFrame = customView.frame;
    customViewFrame.origin = (CGPoint){20, 60};
    customViewFrame.size.width = 260;
    customView.frame = customViewFrame;
    
    float addHeight;
    
    if (customViewFrame.size.height > kMaxHeight) {
        addHeight = customViewFrame.size.height;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(customViewFrame.origin.x, customViewFrame.origin.y, customViewFrame.size.width, kMaxHeight)];
        [scrollView setContentSize:CGSizeMake(customViewFrame.size.width, customViewFrame.size.height)];
        customViewFrame.origin = (CGPoint){0, 0};
        customView.frame = customViewFrame;
        [scrollView addSubview:customView];
        [self.contentView addSubview:scrollView];
        //[scrollView release];
    } else {
        addHeight = kMaxHeight;
        [self.contentView addSubview:customView];
    }
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.size.height += addHeight;
    self.contentView.frame = contentViewFrame;
    
    [self.contentView setCenter:self.center];
    
    return self;
}

- (void) setTitle:(NSString *)title
{
    if (type == ZZTongAlertWaitingViewType_Waiting) {
        [self.titleLabel setText:title];
    }
}

- (void) initBackgroundWithWidth:(float)width
{
    UIImageView *topBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, width, 18)];
    UIImage *topImage = [UIImage imageNamed:@"note_top.png"];
//    topImage = [topImage reSize:topBgImageView.frame.size];
    [topBgImageView setImage:topImage];
    [topBgImageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [self.contentView addSubview:topBgImageView];
    
    UIImage *middleImage = [UIImage imageNamed:@"note_middle.png"];
    HPPatternImageView *middleImageView = [[HPPatternImageView alloc] initWithFrame:CGRectMake(0, 18, topBgImageView.frame.size.width, self.contentView.frame.size.height - (2 * 18)) image:middleImage];
    [middleImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.contentView addSubview:middleImageView];
    [self.contentView sendSubviewToBack:middleImageView];
    
    UIImageView *bottomBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 18, width, 18)];
    UIImage *bottomBgImage = [UIImage imageNamed:@"note_bottom.png"];
//    bottomBgImage = [bottomBgImage reSize:topBgImageView.frame.size];
    [bottomBgImageView setImage:bottomBgImage];
    [bottomBgImageView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [self.contentView addSubview:bottomBgImageView];
    
    //[topBgImageView release];
    //[middleImageView release];
    //[bottomBgImageView release];
}

- (UIButton *) addButtonWithTitle:(NSString *)buttonTitle
{
    if (type == ZZTongAlertWaitingViewType_Waiting) {
        return nil;
    }
    buttonIndex ++;
    
    if (buttonIndex > 2) {
        // 暂时只允许加2个按钮
        return nil;
    }
    
    float kContentMaxWidth = self.contentView.frame.size.width - 40;
    
    UIImage *buttonBgImage = [[UIImage imageNamed:@"golden_button.png"] stretchableImageWithLeftCapWidth:12. topCapHeight:.0];
    if (buttonIndex > 1) {
        UIButton *lb = (UIButton *)[self.contentView viewWithTag:buttonIndex - 1];
        
        [lb setBackgroundImage:[[UIImage imageNamed:@"gray_button.png"] stretchableImageWithLeftCapWidth:12. topCapHeight:.0] forState:UIControlStateNormal];
        [lb setTitleColor:kNormalFontColor forState:UIControlStateNormal];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setExclusiveTouch:YES];
    [button setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    [button setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [button setTitleColor:kGoldenButtonTitleColor forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTag:buttonIndex];
    [button.titleLabel setFont:kNormalButtonFont];
    [button setFrame:CGRectMake(20, 0, kContentMaxWidth, 55)];
    [self.contentView addSubview:button];
    
    if (addedButtonFlag) {
        CGRect alertViewFrame = self.contentView.frame;
        alertViewFrame.size.height += (button.frame.size.height + 12);
        self.contentView.frame = alertViewFrame;
        addedButtonFlag = NO;
    }
    
    float buttonWidth = (kContentMaxWidth - (buttonIndex - 1)) / buttonIndex;
    float buttonX = 20;
    for (int i = 1; i <= buttonIndex; i ++) {
        UIButton *b = (UIButton *)[self.contentView viewWithTag:i];
        [b setFrame:CGRectMake(buttonX, self.contentView.frame.size.height - 20 - b.frame.size.height, buttonWidth, 55)];
        buttonX += buttonWidth + 8;
    }
    
    [self.contentView setCenter:self.center];
    
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void) show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    /* 去除抖动
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.contentView.layer addAnimation:animation forKey:nil];*/
}

- (void) dismiss
{
    [self removeFromSuperview];
    if (self.delegate) {
        [self.delegate dismissAlertView:self];
    }
}

@end

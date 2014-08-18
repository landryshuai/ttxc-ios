//
//  ZZTongAlertWaitingView.h
//  V-POS
//
//  Created by handpay on 12-12-20.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZZTongAlertWaitingViewType_Alert,     // 警告或提示
    ZZTongAlertWaitingViewType_Waiting,   // 等待窗口
    ZZTongAlertWaitingViewType_Tips,      // 提示窗口
} ZZTongAlertWaitingViewType;

@class ZZTongAlertWaitingView;

@protocol ZZTongAlertWaitingViewDelegate <NSObject>

- (void) dismissAlertView:(ZZTongAlertWaitingView *)alertView;

@end

@interface ZZTongAlertWaitingView : UIView

- (ZZTongAlertWaitingView *) initAlertViewWithTitleTagImageName:(NSString *)titleTagImageName title:(NSString *)title message:(NSString *)message;

- (ZZTongAlertWaitingView *) initWaitingViewWithTitle:(NSString *)title;

- (void) setTitle:(NSString *)title;

- (UIButton *) addButtonWithTitle:(NSString *)buttonTitle;

- (void) show;

- (void) dismiss;

@property (assign, nonatomic, readonly) ZZTongAlertWaitingViewType alertWaitingViewType;

@property (assign, nonatomic) id<ZZTongAlertWaitingViewDelegate> delegate;

@end

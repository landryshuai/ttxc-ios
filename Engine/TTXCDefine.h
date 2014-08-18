//
//  TTXCDefine.h
//  ttxc
//
//  Created by shuaijiman on 8/2/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#ifndef ttxc_TTXCDefine_h
#define ttxc_TTXCDefine_h

#define BASE_SERVER_URL    @"http://www.tiantianxinche.com"
#define ACTION_LOGIN @"Login.action?login"
#define ACTION_GETPWD @"UserOperator.action?getPassBack"
#define ACTION_CHECK_OLD_PWD @"UserOperator.action?checkOldPass"
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

// 键盘大小
#define kKeyboardSize   CGSizeMake(320, 236)

#define IOS7_VIEW_FRAME_Y 64
#define HEIGHT_NAVIGATION_BAR  44
#define HEIGHT_STATUS_BAR      20
#define TABBAR_HEIGHT         49

// 黄色按钮文字颜色
#define kGoldenButtonTitleColor             UIColorFromRGB(0x795102)

// 背景颜色
#define kNormalBackgroundColor              RGBCOLOR(243, 243, 243)


// 默认按钮字体
#define kNormalButtonFont                   [UIFont boldSystemFontOfSize:18.]

#define kCellHeight 50


//lzwu  六期新加的

// 默认字体
#define kNormalFont                         [UIFont systemFontOfSize:16.]

//最大金额
#define kMaxAmountFont                      [UIFont systemFontOfSize:40.]

//今日两字
#define kBigFont                            [UIFont systemFontOfSize:28.]

#define kSecondBigFont                     [UIFont systemFontOfSize:22.]

#define kSecondSmallFont                    [UIFont systemFontOfSize:14.]
#define kSmallFont                          [UIFont systemFontOfSize:12.]


//金额字体在深色背景
#define kLightGreenFontColor                     UIColorFromRGB(0x5BFF26)

//金额字体在浅色背景
#define kDarkGreenFontColor                      UIColorFromRGB(0x24CC3A)

//失败字体颜色
#define kRedFontColor                            UIColorFromRGB(0xFF5200)

//主要字体颜色
#define kNormalFontColor                         UIColorFromRGB(0x777777)

//突出字体颜色/主题title
#define kTitleFontColor                          UIColorFromRGB(0x4B85E4)
//#define kTitleFontColor                          UIColorFromRGB(0x548BDB)

//横线颜色
#define kLineFontColor                           UIColorFromRGB(0xCCCCCC)

//默认背景文字颜色
#define kGrayFontColor                           UIColorFromRGB(0xDDDDDD)

//审核中文字颜色
#define kLicFontColor                           UIColorFromRGB(0xF8C500)

#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]

#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#endif

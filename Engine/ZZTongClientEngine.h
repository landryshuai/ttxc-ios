//
//  ZZTongClientEngine.h
//  V-POS
//
//  Created by handpay on 12-10-26.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZZTongUIEngine.h"
#import "User.h"
//#import "AccountInfoData.h"
//#import "HPSwiperService.h"

//#define ZZT_FOR_TEST 1

#define ZZT_CLIENG      [ZZTongClientEngine sharedInstance]
#define ZZT_UIENG      ZZT_CLIENG.uiEngine

@interface ZZTongClientEngine : NSObject {
    ZZTongUIEngine* uiEngine;
    User* user;
}

+ (ZZTongClientEngine *) sharedInstance;
+ (void)releaseInstance;

@property(nonatomic, retain)ZZTongUIEngine* uiEngine;
@property(nonatomic, retain)User* user;
//@property(nonatomic, retain)AccountInfoData* accountInfo;

- (void)clearAccountInfo;

- (void)doAsyncFunction:(id)target func:(SEL)func arg:(NSObject*)obj;

- (BOOL)isLogin;

- (void)saveUser:(User*) user;

@end

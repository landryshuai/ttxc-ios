//
//  AlertData.h
//  ZZTong
//
//  Created by xy on 13-5-13.
//  Copyright (c) 2013年 handpay. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    AlertType_Waiting = 0,  // 等待框
    AlertType_Toast,        // 渐隐提示
    AlertType_Alert,        // 对话框
    AlertType_Tips,         // 大范围提示
}AlertType;

@interface AlertCommandData : NSObject{
    NSString* title;
    SEL func;
}

-(id)initCommand:(NSString*)commandTitle function:(SEL)function;
-(id)initCommand:(NSString*)commandTitle;

@property(nonatomic, retain)NSString* title;
@property(nonatomic)SEL func;
@end

@interface AlertData : NSObject{
    NSString* title;
    NSString* message;
    NSArray* alertCommandArray;
    AlertType alertType;
    id mTarget;
    BOOL isMustOperate;  // 是否一定要操作，为yes,屏蔽后面的alert
    CGFloat leftPadding; // 左边预留边界值
}

/**
 type 默认是alert
 **/
-(id)initAlertData:(id)target title:(NSString*)alertTitle message:(NSString*)msg commands:(AlertCommandData*)command,...;
-(id)initAlertData:(NSString*)alertTitle message:(NSString*)msg;

-(id)initAlertData:(AlertType)type withMsg:(NSString*)message;

@property(nonatomic, retain)NSString* title;
@property(nonatomic, retain)NSString* message;
@property(nonatomic, retain)NSArray* alertCommandArray;
@property(nonatomic)AlertType alertType;
@property(nonatomic, retain)id mTarget;
@property(nonatomic)BOOL isMustOperate;
@property(nonatomic)CGFloat leftPadding;
@end

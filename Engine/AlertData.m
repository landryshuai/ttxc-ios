//
//  AlertData.m
//  ZZTong
//
//  Created by xy on 13-5-13.
//  Copyright (c) 2013年 handpay. All rights reserved.
//

#import "AlertData.h"

@implementation AlertCommandData
@synthesize func;
@synthesize title;

-(id)initCommand:(NSString*)commandTitle function:(SEL)function{
    self = [super init];
    if (self) {
        self.title = commandTitle;
        self.func = function;
    }
    return self;
}

-(id)initCommand:(NSString*)commandTitle{
    return [self initCommand:commandTitle function:nil];
}

-(void)dealloc{
    self.title = nil;
    self.func = nil;
    
    //[super dealloc];
}

@end

@implementation AlertData
@synthesize alertCommandArray;
@synthesize message;
@synthesize title;
@synthesize alertType;
@synthesize mTarget;
@synthesize isMustOperate;
@synthesize leftPadding;

-(id)initAlertData:(id)target title:(NSString*)alertTitle message:(NSString*)msg commands:(AlertCommandData*)command,...{
    self = [super init];
    if (self) {
        self.title = alertTitle;
        self.message = msg;
        self.mTarget = target;
        alertType = AlertType_Alert;
        
        NSMutableArray* tempArray = nil;
        if (command) {
            tempArray = [[NSMutableArray alloc] init];
            [tempArray addObject:command];
            
            id otherCommand;
            va_list otherCommandList;
            va_start(otherCommandList, command);
            while ((otherCommand = va_arg(otherCommandList, id))) {
                [tempArray addObject:otherCommand];
            }
            va_end(otherCommandList);
        }
        
        self.alertCommandArray = tempArray;
        //[tempArray release]; // nil release没有关系
    }
    return self;
}

-(id)initAlertData:(NSString*)alertTitle message:(NSString*)msg{
    return [self initAlertData:nil title:alertTitle message:msg commands:nil];
}

-(id)initAlertData:(AlertType)type withMsg:(NSString*)msg{
    self = [super init];
    if (self) {
        alertType = type;
        self.message = msg;
    }
    return self;
}

-(void)dealloc{
    self.alertCommandArray = nil;
    self.message = nil;
    self.title = nil;
    self.mTarget = nil;
    
    //[super dealloc];
}

@end

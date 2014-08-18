//
//  User.m
//  ttxc
//
//  Created by shuaijiman on 8/7/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize phone;
@synthesize name;
@synthesize pwd;
@synthesize tokenID;
@synthesize userID;

- (id)initWithPhone:(NSString *)phone_ name:(NSString *)name_ password:(NSString *)pwd_
{
    self = [super init];
    if (self) {
        phone = phone_;
        name = name_;
        pwd = pwd_;
    }
    return self;
}

- (void) dealloc
{
    phone = nil;
    name = nil;
    pwd = nil;
    tokenID = nil;
    userID = nil;
}

@end

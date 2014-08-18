//
//  User.h
//  ttxc
//
//  Created by shuaijiman on 8/7/14.
//  Copyright (c) 2014 shuaijiman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString* phone;
    NSString* name;
    NSString* pwd;
    NSString* tokenID;
    NSString* userID;
}
@property(nonatomic, retain) NSString* phone;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* pwd;
@property(nonatomic, retain) NSString* tokenID;
@property(nonatomic, retain) NSString* userID;

- (id)initWithPhone:(NSString*)phone_ name:(NSString*)name_ password:(NSString*)pwd_;
@end

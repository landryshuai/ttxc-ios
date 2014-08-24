//
//  XHHTTPClient.m
//  XHOperationNetworkKit
//
//  Created by 曾 宪华 on 14-1-4.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHHTTPClient.h"

@interface NSString (URLEncoding)

- (NSString *)urlEncodedUTF8String;

@end

@interface NSURLRequest (DictionaryPost)

+ (NSURLRequest *)postRequestWithURL:(NSURL *)url
                          parameters:(NSDictionary *)parameters;

@end

@implementation NSString (URLEncoding)

- (NSString *)urlEncodedUTF8String {
    return (id)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(0, (CFStringRef)self, 0,
                                                       (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8));
}

@end

@implementation XHHTTPClient

+ (void)GETPath:(NSString *)urlString parameters:(NSDictionary *)parameters jsonSuccessHandler:(XHJSONSuccessHandler)jsonSuccessHandler
failureHandler:(XHHTTPFailureHandler)failureHandler {
    XHOperationNetworkKit *operation = [[XHOperationNetworkKit alloc] initWithRequest:[self requestWithURLString:urlString HTTPMethod:@"GET" parameters:parameters] jsonSuccessHandler:jsonSuccessHandler failureHandler:failureHandler];
    [operation startRequest];
}

+ (void)POSTPath:(NSString *)urlString parameters:(NSDictionary *)parameters jsonSuccessHandler:(XHJSONSuccessHandler)jsonSuccessHandler
failureHandler:(XHHTTPFailureHandler)failureHandler {
    XHOperationNetworkKit *operation = [[XHOperationNetworkKit alloc] initWithRequest:[self requestWithURLString:urlString HTTPMethod:@"POST" parameters:parameters] jsonSuccessHandler:jsonSuccessHandler failureHandler:failureHandler];
    [operation startRequest];
}

+ (void)DELETEPath:(NSString *)urlString parameters:(NSDictionary *)parameters jsonSuccessHandler:(XHJSONSuccessHandler)jsonSuccessHandler
    failureHandler:(XHHTTPFailureHandler)failureHandler {
    XHOperationNetworkKit *operation = [[XHOperationNetworkKit alloc] initWithRequest:[self requestWithURLString:urlString HTTPMethod:@"POST" parameters:parameters] jsonSuccessHandler:jsonSuccessHandler failureHandler:failureHandler];
    [operation startRequest];
}

+ (NSMutableURLRequest *)requestWithURLString:(NSString *)urlString HTTPMethod:(NSString *)method parameters:(NSDictionary *)parameters {
    //this is for string like this:
    //http://www.tiantianxinche.com/Login.action?login&phoneNumber=13761031423&password=123321
    NSMutableString *body = [NSMutableString string];
    [body appendString:urlString];
    for (NSString *key in parameters) {
        NSString *val = [parameters objectForKey:key];
        [body appendString:@"&"];
        [body appendFormat:@"%@=%@", [[key description] urlEncodedUTF8String],
         [[val description] urlEncodedUTF8String]];
    }
    NSLog(@"url: %@",[body description]);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[body description]]];
    [request setHTTPMethod:method];
    [request setTimeoutInterval:XHHTTPClientTimeoutInterval];
    //[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

@end

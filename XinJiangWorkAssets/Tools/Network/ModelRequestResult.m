//
//  ModelRequestResult.m
//  NetWorkDemo
//
//  Created by csip on 15/9/23.
//  Copyright (c) 2015年 com.hn3l. All rights reserved.
//

#import "ModelRequestResult.h"

@implementation ModelRequestResult
@synthesize succ = _succ;
@synthesize errorCode = _errorCode;
@synthesize errorMsg = _errorMsg;
@synthesize responseData = _responseData;
@synthesize responseString = _responseString;
@synthesize responseObject = _responseObject;

-(void)desrition{
    NSLog(@"succ:%d",_succ);
    NSLog(@"errorCode:%li",(long)_errorCode);
    NSLog(@"errorMessage :%@",_errorMsg);
    NSLog(@"responeData:%@",_responseData);
    NSLog(@"responeString:%@",_responseString);
    NSLog(@"responeObject:%@",_responseObject);
}

+ (ModelRequestResult *)shareDataRequest
{
    static ModelRequestResult *dataRequest = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataRequest = [[self alloc] init];
    });
    return dataRequest;
}


@end

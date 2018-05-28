//
//  SUNBLogSystemOut.h
//  
//
//  Created by 孙波 on 16/1/23.
//  Copyright © 2016年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUNBSystemMacrocDefine.h"

#define LogSystemAppInfo [SUNBLogSystemOut systemAppInfo]

@interface SUNBLogSystemOut : NSObject

+ (void)systemAppInfo;

@end

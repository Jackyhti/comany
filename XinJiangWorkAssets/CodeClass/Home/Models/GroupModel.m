//
//  GroupModel.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/15.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"child" : @"GroupPerModel",
             };
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    self.isOpen = @"0";
}


@end

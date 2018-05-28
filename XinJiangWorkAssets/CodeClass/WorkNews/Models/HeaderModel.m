//
//  HeaderModel.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "HeaderModel.h"

@implementation HeaderModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没找到%@",key);
}

@end

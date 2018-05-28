//
//  BaseModel.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/15.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没找到%@",key);
}

@end

//
//  photoModel.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "photoModel.h"

@implementation photoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没找到%@",key);
}
@end

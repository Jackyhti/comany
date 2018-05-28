//
//  UIImage+Color.m
//  wangdai
//
//  Created by 抬头看见柠檬树 on 2017/4/10.
//  Copyright © 2017年 孙波. All rights reserved.
//

#import "UIImage+Color.h"

/**
    根据颜色生成纯色图片，用于设置navigationBar的背景色
 */

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

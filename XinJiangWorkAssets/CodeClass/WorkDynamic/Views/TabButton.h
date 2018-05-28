//
//  TabButton.h
//  撸一撸
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 ji ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height



typedef void (^ButtonBlock)(UIButton *);
@interface TabButton : UIButton
{
    CGRect _frame;
}

@property(nonatomic,copy)ButtonBlock block;



- (instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title imageStr:(NSString *)imageStr  imgFrame:(CGRect)imgFrame titleFrame:(CGRect)titleF;


- (void)addTapBlock:(ButtonBlock)block;

@end

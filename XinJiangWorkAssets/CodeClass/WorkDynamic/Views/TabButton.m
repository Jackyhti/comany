//
//  TabButton.m
//  撸一撸
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 ji ke. All rights reserved.
//

#import "TabButton.h"

#import <objc/runtime.h>
static char *btnKey;

@implementation TabButton
{
    CGRect _imFrame;
    CGRect _titleFrame;
}
- (instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title imageStr:(NSString *)imageStr  imgFrame:(CGRect)imgFrame titleFrame:(CGRect)titleF{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        _imFrame = imgFrame;
        _titleFrame = titleF;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor colorWithRed:20/255.0 green:40/255.0 blue:150/255.0 alpha:1.0] forState:UIControlStateHighlighted];
//        self.backgroundColor = [UIColor redColor];
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];

//        self.layer.borderColor = [UIColor colorWithWhite:0.85 alpha:1].CGColor;
//        self.layer.borderWidth = 1;
    }
    return self;
}




- (void)addTapBlock:(ButtonBlock)block {
    self.block = block;
}

// 点击事件中执行动态关联的block，实现 动态增加方法
- (void)action:(UIButton *)sender {
    if(self.block) {
        self.block(self);
    }
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
        return _imFrame;
   
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
        return _titleFrame;;
   
}

@end

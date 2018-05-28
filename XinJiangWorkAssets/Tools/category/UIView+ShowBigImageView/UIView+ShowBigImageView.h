//
//  UIView+ShowBigImageView.h
//  yyyy
//
//  Created by mac on 2016/12/1.
//  Copyright © 2016年 闫金泉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShowBigImageView)
//传入fream
- (void)showBigImage:(UIImage *)image toFrame:(CGRect)frame;
//传入size，中心点是屏幕中央
- (void)showBigImage:(UIImage *)image toSize:(CGSize)size;
@end

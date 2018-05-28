//
//  BaseNavigationContrller.h
//  CityTravel
//
//  Created by 成龙 on 17/3/23.
//  Copyright © 2017年 3L-LY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationContrller : UINavigationController

/**
 全屏返回手势
 
 @param isForBidden 是否禁止
 */
- (void)setupBackPanGestureIsForbidden:(BOOL) isForBidden;

@end

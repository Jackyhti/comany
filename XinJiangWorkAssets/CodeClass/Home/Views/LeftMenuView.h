//
//  LeftMenuView.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/8.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMenuViewDelegate <NSObject>

-(void)LeftMenuViewClick:(NSDictionary*)dic;

-(void)LeftMenuViewSectionClick:(NSDictionary*)dic;

@end


@interface LeftMenuView : UIView

@property (nonatomic ,weak)id <HomeMenuViewDelegate> customDelegate;


@end

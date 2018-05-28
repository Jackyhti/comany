//
//  OnWorkHeaderView.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/9.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnworkHeaderModel.h"

@interface OnWorkHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIView *lineView;



@property(nonatomic,copy)void(^tapBlack)(NSInteger sec);


@property (nonatomic, assign) NSInteger section;


@property (nonatomic, retain) OnworkHeaderModel *model;

@end

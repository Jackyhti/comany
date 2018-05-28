//
//  HomeTableViewCellOne.h
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupInfoMoel.h"

@protocol HomeTableViewCellOneDelegate <NSObject>



//跳转个人中心

- (void)pushToPersonalCenterVC;

//请假审批中
- (void)pushToqingjiaVC;

//签到地图界面界面
- (void)pushSignMapVC;

//cell状态的跳转
- (void)tapCell:(int)Tag;


@end


@interface HomeTableViewCellOne : UITableViewCell

@property(nonatomic,retain)GroupInfoMoel *model;

@property (nonatomic, assign)id<HomeTableViewCellOneDelegate>delegate;

@property(nonatomic,strong)NSString *state;

@end

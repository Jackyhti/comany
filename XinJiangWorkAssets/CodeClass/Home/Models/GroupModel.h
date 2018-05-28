//
//  GroupModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/15.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseModel.h"

@interface GroupModel : BaseModel
@property(nonatomic,strong)NSString *GroupID;

@property(nonatomic,strong)NSString *GroupName;

@property(nonatomic,strong)NSArray *LeaderList;
//展开房间
@property (nonatomic, retain)NSArray *child;

//是否展开
@property (nonatomic, copy)NSString *isOpen;

@end

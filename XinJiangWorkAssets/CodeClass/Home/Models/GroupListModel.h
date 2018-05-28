//
//  GroupListModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/22.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseModel.h"

@interface GroupListModel : BaseModel

@property(nonatomic,strong)NSString *ID;

@property(nonatomic,strong)NSString *Name;

@property(nonatomic,strong)NSString *state;

@property(nonatomic,strong)NSArray *leaderlist;

@end

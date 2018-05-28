//
//  NoticeModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/22.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseModel.h"

@interface NoticeModel : BaseModel

@property(nonatomic,strong)NSString *ID;

@property(nonatomic,strong)NSString *NoticeUrl;

@property(nonatomic,strong)NSString *Title;

@property(nonatomic,strong)NSString *PubTime;

@end

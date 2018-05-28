//
//  NotifiationListModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/17.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseModel.h"

@interface NotifiationListModel : BaseModel

@property(nonatomic,strong)NSString *ID;

@property(nonatomic,strong)NSString *needReply;

@property(nonatomic,strong)NSString *replytype;

@property(nonatomic,strong)NSString *Title;

@property(nonatomic,strong)NSString *PubTime;

@property(nonatomic,strong)NSString *IsRead;





@end

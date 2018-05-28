//
//  ReplyFrameModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/8.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReplyModel.h"
@interface ReplyFrameModel : NSObject

@property(nonatomic,strong)ReplyModel *model;

-(instancetype)initWithModel:(ReplyModel *)model;


@end

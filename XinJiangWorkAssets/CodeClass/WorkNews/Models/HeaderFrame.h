//
//  HeaderFrame.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderModel.h"
@interface HeaderFrame : NSObject

@property(nonatomic,strong)HeaderModel *headerModel;

-(instancetype)initWithModel:(HeaderModel *)model;

@property(nonatomic,readwrite,assign)CGFloat headerHight;


@end

//
//  MyArrangeModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/26.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseModel.h"



@interface MyArrangeModel : BaseModel

@property(nonatomic,strong)NSString *ArrangeID;

@property(nonatomic,strong)NSDictionary *Result;

@property(nonatomic,strong)NSArray *Memo;

@property(nonatomic,strong)NSString *Weight;

@property(nonatomic,strong)NSString *Status;

@property(nonatomic,strong)NSString *EditStatus;

@property(nonatomic,strong)NSString *No;

@property(nonatomic,strong)NSDictionary *Arrange;

@property(nonatomic,strong)NSArray *Judge;

@property(nonatomic,strong)NSString *MemoNum;

@property(nonatomic,strong)NSString *IsZanNames;

@end

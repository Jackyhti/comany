//
//  WorkPersonModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/9.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "BaseModel.h"
#import "MyArrangeModel.h"
@interface WorkPersonModel : BaseModel

@property(nonatomic,strong)NSString *ImgUrl;

@property(nonatomic,strong)NSString *WorkType;

@property(nonatomic,strong)NSString *allNo;

@property(nonatomic,strong)NSArray <MyArrangeModel*>*ArrangeList;

@property(nonatomic,strong)NSString *Tel;

@property(nonatomic,strong)NSString *PostName;

@property(nonatomic,strong)NSString *LeaderID;

@property(nonatomic,strong)NSString *Name;

@property(nonatomic,strong)NSString *DeptName;

@end

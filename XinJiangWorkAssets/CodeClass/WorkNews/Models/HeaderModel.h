//
//  HeaderModel.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "photoModel.h"
#import "ReplyModel.h"
@interface HeaderModel : NSObject

@property(nonatomic,strong)NSString *Content;

@property(nonatomic,strong)NSString *leaderid;

@property(nonatomic,strong)NSString *Position;

@property(nonatomic,strong)NSString *Name;

@property(nonatomic,strong)NSString *ID;

@property(nonatomic,strong)NSString *Source;

@property(nonatomic,strong)NSString *RowNum;

@property(nonatomic,strong)NSArray <ReplyModel*>*comments;

@property(nonatomic,strong)NSString *PubTime;

@property(nonatomic,strong)NSString *Type;

@property(nonatomic,strong)NSString *Title;

@property(nonatomic,strong)NSString *SeeNum;

@property(nonatomic,strong)NSString *IsChecked;

@property(nonatomic,strong)NSString *ReasonNote;

@property(nonatomic,strong)NSArray <photoModel*>*imgUrls;

@end

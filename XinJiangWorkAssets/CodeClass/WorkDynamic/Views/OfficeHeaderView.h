//
//  OfficeHeaderView.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/1.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkTypeModel.h"

@interface OfficeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (nonatomic, copy) void (^networkBlock)(NSString *date);

@property(nonatomic,strong)NSDictionary *dic;

@end

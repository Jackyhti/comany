//
//  MenuHeaderView.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/15.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
@interface MenuHeaderView : UIView


//@property(nonatomic,assign)BOOL isOpen;

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,assign)NSInteger sec;

@property(nonatomic,copy)void(^tapBlack)(NSInteger sec);

@property (weak, nonatomic) IBOutlet UILabel *conLab;

@property (nonatomic, retain)GroupModel *groupModel;


@end

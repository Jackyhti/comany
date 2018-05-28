//
//  ReleaseTableView.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/19.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseTableView : UIView
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property(nonatomic,copy)void(^send)(NSString *arr ,NSString *stateBtn);

@end

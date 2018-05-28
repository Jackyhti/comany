//
//  testTableViewCell.h
//  test
//
//  Created by cisp on 16/7/8.
//  Copyright © 2016年 hn3L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JudgeModel.h"

@interface testTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *boomView;

@property(nonatomic,assign)NSInteger row;

@property(nonatomic,strong)NSArray *arr;

@end

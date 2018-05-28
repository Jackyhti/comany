//
//  PersonDataTableViewCell.h
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/7.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonDataTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *nameLab;

@property (strong, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UITextField *editTF;

@end

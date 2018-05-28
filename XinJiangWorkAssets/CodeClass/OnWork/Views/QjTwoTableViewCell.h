//
//  QjTwoTableViewCell.h
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/26.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QjTwoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;


-(void)setDataArr:(NSArray*)dataArr Row:(int)row;


@end

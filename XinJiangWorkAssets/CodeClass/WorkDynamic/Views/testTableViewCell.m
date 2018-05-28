//
//  testTableViewCell.m
//  test
//
//  Created by cisp on 16/7/8.
//  Copyright © 2016年 hn3L. All rights reserved.
//

#import "testTableViewCell.h"


@interface testTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *commitLab;

@end

@implementation testTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



-(void)setArr:(NSArray *)arr{
    
    JudgeModel *model = [JudgeModel mj_objectWithKeyValues:arr[self.row]];
    self.contentLab.text = [NSString stringWithFormat:@"%@:%@",model.Name,model.Content];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

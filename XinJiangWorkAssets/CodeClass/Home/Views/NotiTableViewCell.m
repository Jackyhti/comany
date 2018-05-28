//
//  NotiTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "NotiTableViewCell.h"

@interface NotiTableViewCell()

//未读 已读

@property (weak, nonatomic) IBOutlet UIView *dotView;

//日期
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

//内容
@property (weak, nonatomic) IBOutlet UILabel *conLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end


@implementation NotiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.dateLab.font = [UIFont systemFontOfSize:SCALE(40)];
    self.conLabel.font = [UIFont systemFontOfSize:SCALE(50)];
}

-(void)setModel:(NotifiationListModel *)model{
    self.dateLab.text = @"";
    if (model) {
        
        if ([model.IsRead isEqualToString:@"0"]) {
            self.dotView.backgroundColor = kColor(0, 165, 15, 1);
        }
        
        
        if([model.IsRead isEqualToString:@"1"]){
                self.dotView.backgroundColor = kColor(151, 152, 153, 1);
            }
        
        if ([model.needReply isEqualToString:@"1"]) {
                self.dateLab.text = [self.dateLab.text stringByAppendingString:@"[需回复]"];
            self.dateLab.textColor = [UIColor orangeColor];
            if ([model.replytype isEqualToString:@"0"]) {
            }else if([model.replytype isEqualToString:@"1"] ){
                self.dateLab.text = [self.dateLab.text  stringByReplacingOccurrencesOfString:@"[需回复]" withString:@""];

                self.dateLab.text = [self.dateLab.text stringByAppendingString:@"[参加]"];
                self.dateLab.textColor = kColor(0, 165, 15, 1);
            }else{
                self.dateLab.text = [self.dateLab.text  stringByReplacingOccurrencesOfString:@"[需回复]" withString:@""];

             self.dateLab.text = [self.dateLab.text stringByAppendingString:@"[不参加]"];
                self.dateLab.textColor = [UIColor grayColor];
            }
            
            }else{
               
        }
        
        
       
        self.timeLab.text = [NSString stringWithFormat:@"%@",model.PubTime];


        self.conLabel.text = [NSString stringWithFormat:@"%@",model.Title];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

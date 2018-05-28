//
//  ReplyFooterView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/15.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ReplyFooterView.h"

@interface ReplyFooterView()


@end

@implementation ReplyFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    
}


- (IBAction)acReply:(id)sender {
    
    self.passValue(_replyTextView.text);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

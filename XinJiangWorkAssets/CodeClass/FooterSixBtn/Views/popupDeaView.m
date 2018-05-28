//
//  popupDeaView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/16.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "popupDeaView.h"
#import "DeaTableViewCell.h"
#import "DeaHeaderView.h"

@interface popupDeaView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation popupDeaView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"DeaTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.myTableView.estimatedRowHeight = 80;
    self.myTableView.autoHeight = UITableViewAutomaticDimension;
    
    
#pragma mark -header-
    DeaHeaderView *header = [[[NSBundle mainBundle]loadNibNamed:@"DeaHeaderView" owner:nil options:nil]firstObject];
    header.height = 210;
    self.myTableView.tableHeaderView = header;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (IBAction)closeAC:(id)sender {
    self.close();
}

@end

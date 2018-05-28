//
//  HomeTableViewCellTwo.m
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "HomeTableViewCellTwo.h"
#import "HomeClassTableViewCell.h"
#import "ArrangeModel.h"
#import "JudgeViewController.h"


@interface HomeTableViewCellTwo()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *twoTableView;

@end

@implementation HomeTableViewCellTwo {
    
    //底图
    UIView *_backGroundView;
    
    //topView
    UIView *_topView;
    
    
    //头像
    UIImageView *_avtorImgView;
    
    //用户名
    UILabel *_userLabel;
    
}

-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.backgroundColor = [UIColor whiteColor];
     
        //修改头像
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAfter) name:@"header" object:nil];
        //更改个人信息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"change" object:nil];
        [self createTableView];
        
    }
    
    return self;
}

-(void)reloadAfter{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *str = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"][@"ImgUrl"];
        NSLog(@"%@",str);
        NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        _avtorImgView.image = [UIImage imageNamed:@"personZW"];
//        _avtorImgView.image = [UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]]]];
//        
        [_avtorImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]] placeholderImage:[UIImage imageNamed:@"personZW"]];
    });
    
}

-(void)reload{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *dic = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"];
        _userLabel.text = [NSString stringWithFormat:@"%@ %@",dic[@"Name"],dic[@"PostName"]];
    });
}



- (void)createTableView {
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.cornerRadius = 10;
    _backGroundView.layer.masksToBounds = YES;
    _backGroundView.layer.borderWidth = 1.0;
    _backGroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    _topView = [UIView new];
    _topView.backgroundColor = kColor(200, 208, 226, 1.0);
    _avtorImgView = [UIImageView new];
    
    NSString *str = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"][@"ImgUrl"];
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    _avtorImgView.image = [UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]]]];
    
      [_avtorImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]] placeholderImage:[UIImage imageNamed:@"personZW"]];
    //user
    _userLabel = [UILabel new];
    NSDictionary *dic = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"];
    _userLabel.text = [NSString stringWithFormat:@"%@ %@",dic[@"Name"],dic[@"PostName"]];
    _userLabel.font = [UIFont systemFontOfSize:SCALE(55)];
    _userLabel.textColor = RGB(23, 23, 23);
    
    _twoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCALE(60), width, height-SCALE(60)) style:UITableViewStylePlain];

    _twoTableView.backgroundColor = [UIColor whiteColor];
    _twoTableView.separatorInset = UIEdgeInsetsZero;
    _twoTableView.layoutMargins = UIEdgeInsetsZero;
    _twoTableView.tableFooterView = [UIView new];
    _twoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.twoTableView.delegate = self;
    self.twoTableView.dataSource = self;
    
    [self.contentView addSubview:_backGroundView];
    [_backGroundView addSubview:_topView];
    [_backGroundView addSubview:_twoTableView];
    [_topView addSubview:_avtorImgView];
    [_topView addSubview:_userLabel];
    
    
    [_twoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_twoTableView registerNib:[UINib nibWithNibName:@"HomeClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeClassTableViewCell"];
    
    
//    [_twoTableView reloadData];
}

- (void)layoutSubviews {
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    _backGroundView.frame = CGRectMake(15, 4, screen_width-30, height-12);
    _topView.frame = CGRectMake(0, 0, _backGroundView.frame.size.width, SCALE(120));
    _twoTableView.frame = CGRectMake(0, _topView.frame.origin.x+_topView.frame.size.height, _backGroundView.frame.size.width, _backGroundView.frame.size.height-(_topView.frame.origin.x+_topView.frame.size.height));
    
    _avtorImgView.frame = CGRectMake(15, _topView.frame.size.height*0.2, 20, _topView.frame.size.height*0.6);
    _userLabel.frame = CGRectMake(_avtorImgView.frame.origin.x+_avtorImgView.frame.size.width + 8, 0, _topView.frame.size.width-_avtorImgView.frame.origin.x-_avtorImgView.frame.size.width-8, _topView.frame.size.height);
}



-(void)setModel:(GroupInfoMoel *)model{
    if (model) {
        self.dataArray = [NSMutableArray array];
        NSDictionary *dic = model.list[0];
        for (NSDictionary *dics in dic[@"Arrange"]) {
            ArrangeModel *arrModel = [ArrangeModel mj_objectWithKeyValues:dics];
            [self.dataArray  addObject:arrModel];
        }
        self.dataArray = (NSMutableArray*)[[self.dataArray reverseObjectEnumerator]allObjects];
        [self.twoTableView reloadData];

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeClassTableViewCell" forIndexPath:indexPath];
    ArrangeModel *model = [[ArrangeModel alloc]init];
    model = self.dataArray[indexPath.row];
    cell.leftLab.text = [NSString stringWithFormat:@"(%ld)%@",indexPath.row+1,model.Content];
   
//    1是进行中 2已完成 3已取消 4未完成 5继续做
    NSString *sta;
    if ([model.Status isEqualToString:@"1"]) {
        sta = @"进行中";
    }else if ([model.Status isEqualToString:@"2"]){
        sta = @"已完成";
    }else if ([model.Status isEqualToString:@"3"]){
        sta = @"已取消";
    }else if ([model.Status isEqualToString:@"4"]){
    sta = @"未完成";
    }else if ([model.Status isEqualToString:@"5"]){
    sta = @"继续做";
    }
    
    cell.startLab.text = [NSString stringWithFormat:@"%@",sta];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCALE(400) - SCALE(120) - 12 - 12)/2;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.homeTableViewCellTwoDidSelectItemDelegate  respondsToSelector:@selector(homeTableViewCellTwoDidSelectItemAtIndexPath:)]) {
        
        [self.homeTableViewCellTwoDidSelectItemDelegate homeTableViewCellTwoDidSelectItemAtIndexPath:indexPath];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

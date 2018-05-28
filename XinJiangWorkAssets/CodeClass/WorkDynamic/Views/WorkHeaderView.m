//
//  WorkHeaderView.m
//  NetWorkNoteBook
//
//  Created by zhenzhen on 16/7/11.
//  Copyright © 2016年 csip. All rights reserved.
//

#import "WorkHeaderView.h"

@interface WorkHeaderView()
{
    NSString *_phoneNum;
    NSString *_myTelNum;
    NSString *_dateStr;
}


@property (weak, nonatomic) IBOutlet UIButton *tomButton;

@property (weak, nonatomic) IBOutlet UIImageView *avtorImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UILabel *nameLab3;

//手机
@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;

//办电

@property (strong, nonatomic) IBOutlet UIButton *telBtn;

//修改

@property (strong, nonatomic) IBOutlet UIButton *changeBtn;

@property(nonatomic,strong)NSString *Type;
@end

@implementation WorkHeaderView
{
    CGFloat  _width;
    
    long      _day;
    long      _yesDay;
    long      _tomDay;
    
    long     _isLeft;
    long     _isRight;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    _day = 1;
    _yesDay = 0;
    _tomDay = 0;
    _isLeft = 0;
    _isRight = 0;
    
    _width = Kscreen_width;
    [self setup];
    
    //修改状态后回掉
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ac:) name:@"ty" object:_Type];
    
    //修改头像
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAfter) name:@"header" object:nil];
    
    
}

-(void)ac:(NSNotification*)no{
    if ([no.userInfo[@"type"]isEqualToString:@"0"]) {
        _nameLab3.text = @"在岗";
    }else if ([no.userInfo[@"type"]isEqualToString:@"1"]){
        _nameLab3.text = @"请假";
        
    }else if ([no.userInfo[@"type"]isEqualToString:@"2"]){
        _nameLab3.text = @"单位内开会/办事";
        
    }else if ([no.userInfo[@"type"]isEqualToString:@"3"]){
        _nameLab3.text = @"单位外开会/办事";
        
    }else if ([no.userInfo[@"type"]isEqualToString:@"4"]){
        _nameLab3.text = @"出差";
        
    }else if ([no.userInfo[@"type"]isEqualToString:@"5"]){
        _nameLab3.text = @"其他";
    }
}



- (void)setup {
    
    
    _dateStr = [[UserInfoManager shareGlobalSettingInstance]getCurrentDateWithDay:1][@"now"];
    
    _timeLab.text = [[NSString stringWithFormat:@"%@ 今天",[self getCurrentDateWithDay:1 current:_dateStr][@"now"]] substringFromIndex:5];
    
    
}

- (IBAction)tomButton:(id)sender {
    _tomDay++;
  
    _day = _tomDay-_yesDay;

   
    NSString *str = [self getCurrentDateWithDay:_day current:_dateStr][@"tommorrow"];
    
    [self blockValue:str date:_dateStr];
  
}

- (IBAction)yesButton:(id)sender {
    _yesDay++;
  
    _day = _yesDay-_tomDay;

    NSString *str = [self getCurrentDateWithDay:_day current:_dateStr][@"yes"];
    [self blockValue:str date:_dateStr];

    
}

//手机
- (IBAction)phoneAction:(id)sender {
    self.phoneBlock(_phoneNum);

}
//办电

- (IBAction)telAction:(id)sender {
    self.phoneBlock(_myTelNum);

}

- (IBAction)changeAc:(id)sender {
    self.change(@"1");
}

- (void)blockValue:(NSString *)str  date:(NSString *)dateStr{
    _timeLab.text = [str substringFromIndex:5];
    _timeLab.text = [self returnDateWithStr:_timeLab.text date:_dateStr];
    
    [self setLabel];
    NSLog(@"日期%@",str);
    if(self.networkBlock) {
        self.networkBlock(str);
    }
}

- (void)setLabel {
    NSString *str = [self getCurrentDateWithDay:0 current:_dateStr][@"now"];
    if([_timeLab.text isEqualToString:[str substringFromIndex:5]]) {
        _timeLab.text = [_timeLab.text stringByAppendingString:@"今天"];
    }
    
    NSString *yesStr = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"yes"];
    if([_timeLab.text isEqualToString:[[yesStr substringFromIndex:5] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]]) {
        _timeLab.text = [_timeLab.text stringByAppendingString:@"昨天"];
    }
    
    
    NSString *tommorrowStr = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"tommorrow"];
    if([_timeLab.text isEqualToString:[[tommorrowStr substringFromIndex:5] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]]) {
        _timeLab.text = [_timeLab.text stringByAppendingString:@"明天"];
    }
    
}


- (NSString *)returnDateWithStr:(NSString *)str date:(NSString *)dateStr {
    NSString *now = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"now"] ;
    NSString *yes = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"yes"] ;
    NSString *tom = [[UserInfoManager shareGlobalSettingInstance] getCurrentDateWithDay:1][@"tommorrow"] ;


    if([str isEqualToString:[now substringFromIndex:5]]) {
        return [str stringByAppendingString:@"今天"];
    }else if([str isEqualToString:[yes substringFromIndex:5]]) {
        return [str stringByAppendingString:@"昨天"];

    }else if([str isEqualToString:[tom substringFromIndex:5]]){
        return [str stringByAppendingString:@"明天"];

    }else {
        return str;
    }
}

- (void)setHeaderDic:(NSDictionary *)headerDic {
    
    _headerDic = headerDic;
    _phoneNum = headerDic[@"Phone"];
    _myTelNum = headerDic[@"Tel"];
    self.nameLab1.text = headerDic[@"Name"];
    self.nameLab2.text = headerDic[@"PostName"];
    self.nameLab3.text = headerDic[@"State"];
    
    NSString *str = headerDic[@"ImgUrl"];
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.avtorImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"personZW"]];
}




-(void)reloadAfter{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *str = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"][@"ImgUrl"];
        NSLog(@"%@",str);
        NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _avtorImgView.image = [UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",KBASE_ImageURL,url]]]];
    });
    
}
- (void)layoutSubviews {
    self.changeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0,1, (Kscreen_width-310));
}


//获取当前日期
- (NSDictionary *)getCurrentDateWithDay:(long)day current:(NSString *)currentStr{
    
    NSDateFormatter *strFor = [[NSDateFormatter alloc]init];
    [strFor setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [strFor dateFromString:currentStr];
    
    NSDate *yesDate = [NSDate dateWithTimeInterval:-(day * (24*60*60)) sinceDate:date];
//    NSDate *yesDate = [NSDate dateWithTimeIntervalSinceNow:-(day * (24*60*60))];
//    NSDate *tommorrowDate = [NSDate dateWithTimeIntervalSinceNow:+(day * (24*60*60))];

    NSDate *tommorrowDate = [NSDate dateWithTimeInterval:+(day * (24*60*60)) sinceDate:date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *now = [formatter stringFromDate:date];
    NSString *yes = [formatter stringFromDate:yesDate];
    NSString *tommorrow = [formatter stringFromDate:tommorrowDate];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:yes,@"yes",now,@"now",tommorrow,@"tommorrow", nil];
    
    return dic;
}

@end

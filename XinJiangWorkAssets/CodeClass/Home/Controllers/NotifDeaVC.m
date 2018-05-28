//
//  NotifDeaVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/29.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "NotifDeaVC.h"
#import "ReplyCell.h"
#import "NewsHeaderView.h"
#import "photoModel.h"
#import "HeaderFrame.h"
#import "HeaderModel.h"
#import "ReplyFooterView.h"
#import "ZanTableViewCell.h"
#import "LBPhotoBrowserManager.h"
#import <ImageIO/ImageIO.h>
#import "UIView+Frame.h"
#import "AuditFooterView.h"


@interface NotifDeaVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property(nonatomic,strong)NSArray *photoArr;

@property(nonatomic,strong)NSMutableArray *arr;

@property(nonatomic,strong)NSMutableArray *urlArr;

@property(nonatomic,strong)AuditFooterView *footerView;

@end

@implementation NotifDeaVC

{
    UILabel *titleLab;
    UILabel *conLab;
    UILabel *timeLab;
    UIView *xian;
    UIView *photoBC;
    NSDictionary *_allDic;
    NSString *jg;
}

-(NSArray*)photoArr{
    if (!_photoArr) {
        _photoArr = [NSArray array];
    }
    return _photoArr;
}

-(NSMutableArray*)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(NSMutableArray*)urlArr{
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
    }
    return _urlArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frame)];
    [self.mainScrollView addGestureRecognizer:tap];
    self.mainScrollView.userInteractionEnabled = YES;
    [self getData];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)getData{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    NSDictionary *dic = @{@"LeaderID":LeaderID,@"NoticeId":self.model.ID};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kNotDea successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [self hiddenLoadingMinView];
            _allDic = [NSDictionary dictionary];
            _allDic = responseBody.responseObject;
            [self initUI];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
}


-(void)sendData{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    NSDictionary *dic = @{@"LeaderID":LeaderID,@"NoticeId":self.model.ID,@"IsJoin":jg,@"Note":_footerView.textView.text};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kNoticeReply successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            [LToast showWithText:@"确认完成"];
            self.backReload(@"1");
            [self.navigationController popViewControllerAnimated:YES];
            [self hiddenLoadingMinView];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [self hiddenLoadingMinView];
        [LToast showWithText:error.errorMsg];
    }];
}

-(void)initUI{
    //标题
    titleLab = [[UILabel alloc]init];
    titleLab.text = [NSString stringWithFormat:@"%@",_allDic[@"noticecontent"][0][@"Title"]];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.numberOfLines = 0;
    
    //时间
    timeLab = [[UILabel alloc]init];
    timeLab.text = [_allDic[@"noticecontent"][0][@"PubTime"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    timeLab.font = [UIFont systemFontOfSize:14];

    //线
    xian = [[UIView alloc]init];
    xian.backgroundColor = [UIColor grayColor];
    
    //内容
    conLab = [[UILabel alloc]init];
    conLab.text = [NSString stringWithFormat:@"%@",_allDic[@"noticecontent"][0][@"Content"]];
    conLab.font = [UIFont systemFontOfSize:16];
    conLab.numberOfLines = 0;
    
    //图片背景图
    photoBC = [[UIView alloc]init];
    
    //参加/不参加
    _footerView = [[[NSBundle mainBundle] loadNibNamed:@"AuditFooterView" owner:self options:nil] firstObject];
    _footerView.textView.delegate = self;
    [_footerView.tgBtn setTitle:@"参加" forState:UIControlStateNormal];
    [_footerView.btgBtn setTitle:@"不参加" forState:UIControlStateNormal];
    __weak typeof(self)weakSelf = self;
    _footerView.sendResult = ^(NSString *str) {
    jg = str;
    [weakSelf sendData];
        
};
    
    
    self.photoArr = _allDic[@"Imgurllist"];
    [self.mainScrollView addSubview:titleLab];
    [self.mainScrollView addSubview:conLab];
    [self.mainScrollView addSubview:photoBC];
    [self.mainScrollView addSubview:timeLab];
    [self.mainScrollView addSubview:xian];
    [self.view addSubview:_footerView];
    
    [self upFrame];
}

-(void)upFrame{
    titleLab.frame = CGRectMake(10, 10, Kscreen_width-20, 60);
    [titleLab sizeToFit];
    
    timeLab.frame = CGRectMake(10, titleLab.origin.y+titleLab.frame.size.height+10, Kscreen_width-20, 50);
    
    xian.frame = CGRectMake(10, timeLab.origin.y+timeLab.frame.size.height, Kscreen_width-20, 1);
    
    conLab.frame = CGRectMake(10, timeLab.origin.y+timeLab.frame.size.height+10, Kscreen_width-20, 60);
    [conLab sizeToFit];
    photoBC.frame = CGRectMake(10, conLab.origin.y+conLab.size.height+20, Kscreen_width-20, 0);
    
    //图片宽高
    CGFloat photoHeight = (Kscreen_width-20-20)/3;
    for (int i = 0;i< _photoArr.count; i++) {
         if (_photoArr.count >=1 && _photoArr.count<=3){
            [photoBC setFrame:CGRectMake(10, conLab.origin.y+conLab.size.height+20, Kscreen_width-20, photoHeight+10)];

                UIImageView *photo = [[UIImageView alloc]initWithFrame:CGRectMake(10*i + (i*photoHeight), 0, photoHeight, photoHeight)];
             photo.userInteractionEnabled = YES;
             [photoBC addSubview:photo];
   NSString *url = [_photoArr[i][@"ImgUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBASE_YBURL,url]]];
             NSString *str = [NSString stringWithFormat:@"%@%@",KBASE_YBURL,url];
             [self.urlArr addObject:str];
             UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
             photo.tag = 1000+i;
             [photo addGestureRecognizer:tag];
             [self.arr addObject:photo];
        }else if (_photoArr.count >=3 && _photoArr.count<=6){
            [photoBC setFrame:CGRectMake(10, conLab.origin.y+conLab.size.height+20, Kscreen_width-20, (photoHeight+10)*2)];
            
                UIImageView *photo;
            photo.userInteractionEnabled = YES;
                if (i < 3) {
                   photo = [[UIImageView alloc]initWithFrame:CGRectMake(10*i + (i*photoHeight), 0, photoHeight, photoHeight)];
                    photo.backgroundColor = [UIColor redColor];
                    [photoBC addSubview:photo];
                }else{
                    photo = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i-3) + ((i-3)*photoHeight), photoHeight+10, photoHeight, photoHeight)];
                        photo.backgroundColor = [UIColor redColor];
                        [photoBC addSubview:photo];
                }
            NSString *url = [_photoArr[i][@"ImgUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBASE_YBURL,url]]];
            NSString *str = [NSString stringWithFormat:@"%@%@",KBASE_YBURL,url];
            [self.urlArr addObject:str];
            UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            photo.tag = 1000+i;
            [photo addGestureRecognizer:tag];
            [self.arr addObject:photo];

            
        }else if (_photoArr.count >=6 && _photoArr.count<=9){
            [photoBC setFrame:CGRectMake(10, conLab.origin.y+conLab.size.height+20, Kscreen_width-20, (photoHeight+10)*3)];
            UIImageView *photo;
            photo.userInteractionEnabled = YES;
            if (i < 3) {
                photo = [[UIImageView alloc]initWithFrame:CGRectMake(10*i + (i*photoHeight), 0, photoHeight, photoHeight)];
                photo.backgroundColor = [UIColor redColor];
                [photoBC addSubview:photo];
            }else if (i>=3 && i<6){
                photo = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i-3) + ((i-3)*photoHeight), photoHeight+10, photoHeight, photoHeight)];
                photo.backgroundColor = [UIColor redColor];
                [photoBC addSubview:photo];
            }else if(i>=6 && i<9){
                photo = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i-6) + ((i-6)*photoHeight), photoHeight*2+20, photoHeight, photoHeight)];
                photo.backgroundColor = [UIColor redColor];
                [photoBC addSubview:photo];
            }
            NSString *url = [_photoArr[i][@"ImgUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *str = [NSString stringWithFormat:@"%@%@",KBASE_YBURL,url];
            [self.urlArr addObject:str];
            [photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBASE_YBURL,url]]];
            UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            photo.tag = 1000+i;
            [photo addGestureRecognizer:tag];
            [self.arr addObject:photo];

        }
    }
    
    _footerView.frame = CGRectMake(0,Kscreen_height-200-64 , Kscreen_width, 200);
    
    CGFloat allHeight = photoBC.origin.y +photoBC.size.height;
    
    self.mainScrollView.contentSize = CGSizeMake(Kscreen_width, allHeight+200);
    
    NSNumber *type = _allDic[@"noticecontent"][0][@"NeedReply"];
    if ([type integerValue] == 0) {
        self.mainScrollView.contentSize = CGSizeMake(Kscreen_width, allHeight);
        [_footerView removeFromSuperview];
    }
}

-(void)tap:(UITapGestureRecognizer*)tap{
    
    [[LBPhotoBrowserManager defaultManager] showImageWithURLArray:self.urlArr fromImageViews: self.arr andSelectedIndex:(int)tap.view.tag-1000 andImageViewSuperView:self.arr[(int)tap.view.tag-1000]];
    
    // 给每张图片添加占位图
    [[LBPhotoBrowserManager defaultManager] addPlaceHoldImageCallBackBlock:^UIImage *(NSIndexPath *indexPath) {
        LBPhotoBrowserLog(@"%@",indexPath);
        return [UIImage imageNamed:@"LBLoading.png"];
    }].lowGifMemory = YES; // lowGifMemory 这个在真机上效果明显 模拟器用的是电脑的内存
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, -200-44, Kscreen_width, Kscreen_height);

    }];
}

-(void)frame{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 0+64, Kscreen_width, Kscreen_height);
        [self.view endEditing:YES];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

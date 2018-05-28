//
//  ReleaseViewController.m
//  XinJiangWorkAssets
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "ReleaseViewController.h"
#import "ReleaseTableView.h"
//默认最大输入字数为  kMaxTextCount  300
#define kMaxTextCount 300

#define StandardHeight 50


@interface ReleaseViewController ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    //备注文本View高度
    float noteTextHeight;
    
    //标题
    UITextField *_btTF;
    //线
    UIView *_xianOne;
   
    //线3
    UIView *_xianThree;
    
    
    //描述

    BOOL _isTextView;
    
    BOOL _isEdit;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property(nonatomic,strong)UIView *xianTwo;

@property(nonatomic,strong)ReleaseTableView *ListView;

@end

@implementation ReleaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _isTextView = NO;
    _isEdit = NO;
    //收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [_mainScrollView setDelegate:self];
    self.showInView = _mainScrollView;
    
    [self.mainScrollView setCanCancelContentTouches:YES];
    
    [self.mainScrollView setDelaysContentTouches:NO];
    
    self.mainScrollView.alwaysBounceVertical = NO;
    [self initPickerView];
    
    //布局
    [self initUI];
    
    [self addcenter];
}

-(void)addcenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upview:) name:@"count" object:nil];
}

-(void)upview:(NSNotification *)notify{
    NSLog(@"%@",notify.userInfo);
}

-(void)initUI{
    _btTF = [[UITextField alloc] init];
    _btTF.placeholder = @"标题";
    _btTF.delegate = self;
    _btTF.font = [UIFont systemFontOfSize:17.0];
    [self.mainScrollView addSubview:_btTF];
    
    //线
    _xianOne = [[UIView alloc]init];
    _xianOne.backgroundColor = kColor(242, 243, 243, 1);
    _xianOne.alpha = 0.6;
    [self.mainScrollView addSubview:_xianOne];
    
    
    _noteTextBackgroudView = [[UIView alloc]init];

    _noteTextBackgroudView.backgroundColor = [UIColor whiteColor];
    
    [_mainScrollView addSubview:_noteTextBackgroudView];
    //文本输入框
    _noteTextView = [[LPlaceHolderTextView alloc]init];
    _noteTextView.backgroundColor = [UIColor whiteColor];
    _noteTextView.placeholder = @"描述一下发布内容...";
    _noteTextView.placeholderLabelLeft = 1;
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont systemFontOfSize:17];
    _noteTextView.rightBottomWordCount = 300;
    _noteTextView.rightBootomLeftWordString = @"您还可以输入{s}个字";
    _noteTextView.rightBottomWordLabelFont = 17;

    _noteTextView.rightBottomWordLabelColor = [UIColor clearColor];
    _noteTextView.keyboardType = UIKeyboardTypeDefault;

    [self.mainScrollView addSubview:_noteTextView];
    
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor redColor];
    _textNumberLabel.backgroundColor = [UIColor clearColor];
    
    _textNumberLabel.text = [NSString stringWithFormat:@"0/%d    ",kMaxTextCount];
//    [self.noteTextBackgroudView addSubview:_textNumberLabel];
    
    
    //线2
//    _xianTwo = [[UIView alloc]init];
////    _xianTwo.backgroundColor = kColor(242, 243, 243, 1);
//    _xianTwo.backgroundColor = [UIColor redColor];
//    _xianTwo.alpha = 0.6;
//    [self.mainScrollView addSubview:_xianTwo];
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"ReleaseTableView" owner:nil options:nil];
    
    _ListView = [arr objectAtIndex:0];
    
    __weak typeof(self)weakSelf = self;
    _ListView.send = ^(NSString *arr,NSString *stateBtn) {
        
        if (_btTF.text.length == 0) {
            [LToast showWithText:@"请输入标题"];
        }else{
            if (_noteTextView.text.length == 0) {
                [LToast showWithText:@"请输入内容"];
            }else{
                if (arr.length == 0) {
                    [LToast showWithText:@"请选择接受人"];
                }else{
                    [weakSelf postData:arr Sta:stateBtn];
                }
            }
        }
    };
    
    [self.mainScrollView addSubview:_ListView];
    
    [self upFrame];
    
    
}

-(void)postData:(NSString*)arr Sta:(NSString*)sta{
    
    //大图数据
    NSArray *bigImageDataArray = [self getBigImageArray];
    
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    
    NSDictionary *dic = [NSDictionary dictionary];
    
    dic = @{
            @"Type":@"1",
            @"SendLeaderID":[NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]],
            @"Index":[NSString stringWithFormat:@"%lu",(unsigned long)bigImageDataArray.count],
            @"FileType":@"1",
            @"Title":_btTF.text,
            @"Content":_noteTextView.text,
            @"ReceiveGroupList":arr,
            @"NeedReply":sta,
            };
    
    if (bigImageDataArray.count == 0) {
        [[NetworkSingleton sharedManager]postDataToResult:dic url:kaddNotice successBlock:^(ModelRequestResult *responseBody) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"发布成功!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:actionCacel];
            [self presentViewController:alertController animated:YES completion:nil];
            NSNotification *not = [[NSNotification alloc]initWithName:@"fb" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:not];
            
        } failureBlock:^(ModelRequestResult *error) {
            
        }];
    }else{
        [[NetworkSingleton sharedManager]uploadPic:dic url:kaddNotice photosData:bigImageDataArray successBlock:^(ModelRequestResult *responseBody) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"发布成功!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            [alertController addAction:actionCacel];
            [self presentViewController:alertController animated:YES completion:nil];
            
            } faileureBlock:^(ModelRequestResult *error) {
        }];
    }
}



-(void)pickerViewFrameChanged{
    [self upFrame];

}

-(void)upFrame{
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
//    self.xianTwo.bounds = CGRectMake(0, 100+noteTextHeight+[self getPickerViewFrame].size.height+30, Kscreen_width, 3);
//     self.xianTwo.frame = CGRectMake(0, 100+noteTextHeight+[self getPickerViewFrame].size.height+30, Kscreen_width, 3);
    
    _ListView.frame = CGRectMake(0, 100+noteTextHeight+[self getPickerViewFrame].size.height, Kscreen_width, 400);
   NSLog(@"%f",Y(_xianTwo)) ;
    _btTF.frame = CGRectMake(20, 10, Kscreen_width-40, 50);
    _xianOne.frame = CGRectMake(20, 61, Kscreen_width-40, 1);
    _noteTextView.frame = CGRectMake(20, 75, Kscreen_width-40, noteTextHeight);
    _noteTextBackgroudView.frame = CGRectMake(0, 75, Kscreen_width, _noteTextView.frame.size.height+15);
    CGFloat allhight = 100 + noteTextHeight + [self getPickerViewFrame].size.height + 400;
    _mainScrollView.contentSize = CGSizeMake(Kscreen_width,allhight);

    
//    //文字个数提示Label
//    _textNumberLabel.frame = CGRectMake(0,_noteTextBackgroudView.frame.size.height-15, Kscreen_width-10, 15);
    //photoPicker
    [self updatePickerViewFrameY:100+noteTextHeight];
   
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        NSLog(@"新的值--%@",change[@"new"]);
        NSLog(@"以前的值--%@",change[@"old"]);
    }
}



/**
 *  取消输入
 */
- (void)viewTapped{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.mainScrollView.contentOffset = CGPointMake(0, 0);
//    }];
    [self.view endEditing:YES];
    _isTextView = NO;
    _isEdit = NO;
    
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
//    NSLog(@"当前输入框文字个数:%ld",(unsigned long)_noteTextView.text.length);
    
    //当前输入字数
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    
    
    
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
    
    [self textChanged];
    return YES;
}

//文本框每次输入文字都会调用  -> 更改文字个数提示框
- (void)textViewDidChangeSelection:(UITextView *)textView{
    
//    NSLog(@"当前输入框文字个数:%ld",_noteTextView.text.length);
    //
    
    
    
    _isEdit = YES;
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    
    
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    [self textChanged];
    
}



/**
 *  文本高度自适应
 */
-(void)textChanged{
    
    CGRect orgRect = self.noteTextView.frame;//获取原始UITextView的frame
    
    //获取尺寸
    CGSize size = [self.noteTextView sizeThatFits:CGSizeMake(self.noteTextView.frame.size.width, MAXFLOAT)];
    
    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    
    
    //如果文本框没字了恢复初始尺寸
    if (orgRect.size.height > 100) {
        noteTextHeight = orgRect.size.height;
    }else{
        noteTextHeight = 100;
    }
    
    [self upFrame];
}

#pragma maek - 检查输入
- (BOOL)checkInput{
    //文本框没字
    if (_noteTextView.text.length == 0) {
        NSLog(@"文本框没字");
        //MBhudText(self.view, @"请添加记录备注", 1);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入文字" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    //文本框字数超过300
    if (_noteTextView.text.length > kMaxTextCount) {
        NSLog(@"文本框字数超过300");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"超出文字限制" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
        //移除观察者
   [[NSNotificationCenter defaultCenter]removeObserver:self name:@"count" object:nil];
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

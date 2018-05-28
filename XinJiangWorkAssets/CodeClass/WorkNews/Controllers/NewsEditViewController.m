//
//  NewsEditViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/9.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "NewsEditViewController.h"

//默认最大输入字数为  kMaxTextCount  300
#define kMaxTextCount 300

#define StandardHeight 50

@interface NewsEditViewController ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    
    //备注文本View高度
    float noteTextHeight;
    float pickerViewHeight;
    float allViewHeight;
    

    //线
    UIView *_lineOne;
    //日期label
    UILabel *_dLab;
    //线2
    UIView *_lineTwo;
    //titlelabel
    UILabel *_titleLab;
    //线3
    UIView *_lineThree;
    //内容
    UILabel *_contentLab;
    //线4
    UIView *_lineFour;
    //日期图片
    UIImageView *_dateImgView;
    
    BOOL _isTextView;
    
    BOOL _isEdit;
    
    //日期要传入请求的
    UILabel *_dateLabel;
    
    //标题输入
    UITextField *_inputTextField;
}

//主视图
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

//部门动态底部视图
@property (nonatomic, retain)UIView *dynamicBackgroundView;

@property (nonatomic, retain)QRadioButton *dyBtn;
//院动态
@property (nonatomic, retain)QRadioButton *yBtn;

//日期view
@property (nonatomic, retain)UIView *dateView;

//标题view
@property (nonatomic, retain)UIView *titleView;

@property(nonatomic,strong)UIActivityIndicatorView *actViewMin;

@end

@implementation NewsEditViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.isEdit = NO;
//    self.imageArray = [@[[UIImage imageNamed:@"qdy_0"],[UIImage imageNamed:@"qdy_1"]] mutableCopy];
//    self.arrSelected  = self.imageArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _isTextView = NO;
    _isEdit = NO;
    //收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [_mainScrollView setDelegate:self];
    self.showInView = _mainScrollView;
    
    [self initPickerView];
    
    [self initViews];
    
    [self.noteTextView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    _actViewMin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_actViewMin setFrame:CGRectMake((Kscreen_width - 30) /2, (Kscreen_height - 64 - 49)/2, 30, 30)];
    
    [self.view bringSubviewToFront:_actViewMin];
    _actViewMin.layer.zPosition = 10;
    [self.view addSubview:_actViewMin];
    
}


/**
 *  监听属性值发生改变时回调
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"frame"]) {
       
        if(_isEdit) {
//            self.mainScrollView.contentOffset = CGPointMake(0, [self getPickerViewFrame].origin.y-noteTextHeight);

        }

    }
    
}




/**
 *  取消输入
 */
- (void)viewTapped{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(0, 0);
    }];
    [self.view endEditing:YES];
    _isTextView = NO;
    _isEdit = NO;
    
}


/**
 *  初始化视图
 */
- (void)initViews{
    _dynamicBackgroundView = [[UIView alloc]init];
    _dynamicBackgroundView.backgroundColor = [UIColor whiteColor];
    
    
    NSString *dyStr = @"部门动态";
    _dyBtn = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    [_dyBtn setTitle:dyStr forState:UIControlStateNormal];
    [_dyBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [_dyBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
//    _dyBtn.backgroundColor  = [UIColor redColor];
    
//    NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] initWithString:dyStr];
//    [attrstr addAttribute:NSForegroundColorAttributeName
//                        value:[UIColor lightGrayColor]
//                        range:NSMakeRange(4, dyStr.length-4)];
//    [attrstr addAttribute:NSForegroundColorAttributeName
//                    value:[[UIColor blackColor] colorWithAlphaComponent:0.7]
//                    range:NSMakeRange(0,4)];
//    [_dyBtn setAttributedTitle:attrstr forState:UIControlStateNormal];
//    

    
    _yBtn = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    [_yBtn setTitle:@"中心动态" forState:UIControlStateNormal];
    [_yBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [_yBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
//    _yBtn.backgroundColor  = [UIColor yellowColor];
    
    _lineOne = [[UIView alloc] init];
    _lineOne.backgroundColor = kColor(245, 245, 245, 1.0);
    
    _dateView = [[UIView alloc] init];
    _dateView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateTapAction:)];
    [_dateView addGestureRecognizer:dateTap];
    
    _dLab = [[UILabel alloc] init];
    _dLab.text = @"日期";
    _dLab.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _dLab.font = [UIFont systemFontOfSize:15.0];
    
    _dateImgView = [[UIImageView alloc] init];
    _dateImgView.image = [UIImage imageNamed:@"date_gray"];
    
    
   
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = [[UserInfoManager shareGlobalSettingInstance]getTodayDate];
    _dateLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _dateLabel.font = [UIFont systemFontOfSize:15.0];
    
    
    _lineTwo = [[UIView alloc] init];
    _lineTwo.backgroundColor = kColor(245, 245, 245, 1.0);
    
    _titleView = [[UIView alloc] init];
    _titleView.backgroundColor = [UIColor whiteColor];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.text = @"标题";
    _titleLab.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _titleLab.font = [UIFont systemFontOfSize:15.0];
    
    
    _inputTextField = [[UITextField alloc] init];
    _inputTextField.placeholder = @"请输入标题";
    _inputTextField.delegate = self;
    _inputTextField.font = [UIFont systemFontOfSize:15.0];
    
    
    _lineThree = [[UIView alloc] init];
    _lineThree.backgroundColor = kColor(245, 245, 245, 1.0);
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.text = @"内容";
    _contentLab.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _contentLab.font = [UIFont systemFontOfSize:15.0];
    

    _noteTextBackgroudView = [[UIView alloc]init];
    //    _noteTextBackgroudView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    _noteTextBackgroudView.backgroundColor = [UIColor whiteColor];
    
    //文本输入框
    _noteTextView = [[LPlaceHolderTextView alloc]init];
    _noteTextView.backgroundColor = [UIColor whiteColor];
    _noteTextView.placeholder = @"请填写编辑内容";
    _noteTextView.placeholderLabelLeft = 1;
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont systemFontOfSize:15];
    _noteTextView.rightBottomWordCount = 300;
    _noteTextView.rightBootomLeftWordString = @"您还可以输入{s}个字";
    _noteTextView.rightBottomWordLabelFont = 10.5f;
//    _noteTextView.rightBottomWordLabelColor = RGB(180, 180, 180);
    _noteTextView.rightBottomWordLabelColor = [UIColor clearColor];
    
    
//    _noteTextView = [[UITextView alloc]init];
//    _noteTextView.text = [EditContent substringToIndex:7];
    _noteTextView.keyboardType = UIKeyboardTypeDefault;
    //文字样式
//    [_noteTextView setFont:[UIFont fontWithName:@"Heiti SC" size:15.5]];
    //    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
//    [_noteTextView setTextColor:[[UIColor redColor] colorWithAlphaComponent:0.7]];
//    _noteTextView.delegat e = self;
//    _noteTextView.font = [UIFont boldSystemFontOfSize:15.5];
//    _noteTextView.backgroundColor = [UIColor cyanColor];
    
    _lineFour = [[UIView alloc] init];
    _lineFour.backgroundColor = kColor(245, 245, 245, 1.0);
    
    
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor redColor];
    _textNumberLabel.backgroundColor = [UIColor clearColor];
    
    _textNumberLabel.text = [NSString stringWithFormat:@"0/%d    ",kMaxTextCount];
    
    _explainLabel = [[UILabel alloc]init];
    //    _explainLabel.text = @"添加图片不超过9张，文字备注不超过300字";
    _explainLabel.text = [NSString stringWithFormat:@"添加图片不超过9张，文字备注不超过%d字",kMaxTextCount];
    //发布按钮颜色
    _explainLabel.textColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    _explainLabel.font = [UIFont boldSystemFontOfSize:12];
    
    //发布按钮样式->可自定义!
    _submitBtn = [[UIButton alloc]init];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:kHomeColor];
    
    //圆角
    //设置圆角
    [_submitBtn.layer setCornerRadius:4.0f];
    [_submitBtn.layer setMasksToBounds:YES];
    [_submitBtn.layer setShouldRasterize:YES];
    [_submitBtn.layer setRasterizationScale:[UIScreen mainScreen].scale];
    
    [_submitBtn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainScrollView addSubview:_dynamicBackgroundView];
    [_mainScrollView addSubview:_noteTextBackgroudView];
    [_mainScrollView addSubview:_noteTextView];
    [_mainScrollView addSubview:_textNumberLabel];
//    [_mainScrollView addSubview:_explainLabel];
    [_mainScrollView addSubview:_submitBtn];
    [_mainScrollView addSubview:_dateView];
    
    [_dynamicBackgroundView addSubview:_dyBtn];
    [_dynamicBackgroundView addSubview:_yBtn];
    [_mainScrollView addSubview:_lineOne];
    [_dateView addSubview:_dLab];
    [_dateView addSubview:_dateImgView];
    [_dateView addSubview:_dateLabel];
    [_mainScrollView addSubview:_titleView];
    [_titleView addSubview:_titleLab];
    [_titleView addSubview:_inputTextField];
    [_mainScrollView addSubview:_lineThree];
    [_noteTextBackgroudView addSubview:_contentLab];
    

    [self updateViewsFrame];
}

/**
 *  界面布局 frame
 */
- (void)updateViewsFrame{
    
    if (!allViewHeight) {
        allViewHeight = 0;
    }
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
    _dynamicBackgroundView.frame = CGRectMake(0, 0, Kscreen_width, 80);
    CGFloat originY = _dynamicBackgroundView.frame.size.height;

    
    _dyBtn.frame = CGRectMake(20, 0, 210, originY);
    CGFloat yBtnWidth = Kscreen_width-_dyBtn.frame.size.width-_dyBtn.frame.origin.x;
    _yBtn.frame = CGRectMake(_dyBtn.frame.size.width+_dyBtn.frame.origin.x, 0, yBtnWidth, originY);
    
    
    _lineOne.frame = CGRectMake(0, originY, Kscreen_width, 1);
    originY = originY + 1;
    
    _dateView.frame = CGRectMake(0, originY, Kscreen_width, StandardHeight);
    
    _dLab.frame = CGRectMake(10, 0,40, StandardHeight);
    originY += StandardHeight;
    
    _dateImgView.frame = CGRectMake(_dLab.frame.origin.x+_dLab.frame.size.width+10, _dateView.frame.size.height/2-20/2, 20, 20);
    
    _dateLabel.frame = CGRectMake(_dateImgView.frame.origin.x+_dateImgView.frame.size.width+5, 0,150, StandardHeight);

    _lineTwo.frame = CGRectMake(0, originY, Kscreen_width, 1);

    originY += 1;
    
    _titleView.frame = CGRectMake(0, originY, Kscreen_width, StandardHeight);

    _titleLab.frame = CGRectMake(10, 0,40, StandardHeight);

    _inputTextField.frame = CGRectMake(_titleLab.frame.origin.x+_titleLab.frame.size.width+10, 0,Kscreen_width-(_titleLab.frame.origin.x+_titleLab.frame.size.width+10), StandardHeight);

    originY += StandardHeight;
    
    _lineThree.frame = CGRectMake(0, originY, Kscreen_width, 1);

    
    originY += 1;
    
    _noteTextBackgroudView.frame = CGRectMake(0, originY, Kscreen_width, noteTextHeight);
    
    _contentLab.frame = CGRectMake(10, 0,40,40);

    
    
    //文本编辑框
    _noteTextView.frame = CGRectMake(_contentLab
                                     .frame.origin.x+_contentLab.frame.size.width+10, originY, Kscreen_width - _contentLab
                                     .frame.origin.x-_contentLab.frame.size.width-10, noteTextHeight);
    
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, Kscreen_width-10, 15);
    
    
    _lineFour.frame = CGRectMake(0, originY, Kscreen_width, 1);
    originY += 1;
    //photoPicker
    [self updatePickerViewFrameY:originY+noteTextHeight];
    
    
    //说明文字
//    _explainLabel.frame = CGRectMake(0, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+20, Kscreen_width, 20);
//    _explainLabel.backgroundColor = [UIColor blueColor];
    
    
    //发布按钮
//    _submitBtn.bounds = CGRectMake(10, _explainLabel.frame.origin.y+_explainLabel.frame.size.height +30+originY, Kscreen_width -20, 40);
//    _submitBtn.frame = CGRectMake(10, _explainLabel.frame.origin.y+_explainLabel.frame.size.height +30, Kscreen_width -20, 40);
    _submitBtn.bounds = CGRectMake(10, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+30, Kscreen_width -20, StandardHeight);
    _submitBtn.frame = CGRectMake(10, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+30, Kscreen_width -20, StandardHeight);
    
    
    allViewHeight = noteTextHeight + originY + [self getPickerViewFrame].size.height + 30 + 100;
    
    _mainScrollView.contentSize = self.mainScrollView.contentSize = CGSizeMake(0,allViewHeight);
}

/**
 *  恢复原始界面布局
 */
-(void)resumeOriginalFrame{
    _noteTextBackgroudView.frame = CGRectMake(0, 0, Kscreen_width, noteTextHeight);
    //文本编辑框
    _noteTextView.frame = CGRectMake(15, 0, Kscreen_width - 30, noteTextHeight);
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, Kscreen_width-10, 15);
}

- (void)pickerViewFrameChanged{
    [self updateViewsFrame];
}

#pragma mark dateClick
- (void)dateTapAction:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"M月dd日"];
        NSString *start = [startDate stringWithFormat:@"YYYY-MM-dd"];
        _dateLabel.text = start;
        NSLog(@"时间： %@",start);
    }];
    datepicker.doneButtonColor = kHomeColor;//确定按钮的颜色
    [datepicker show];
}



#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"当前输入框文字个数:%ld",(unsigned long)_noteTextView.text.length);
    
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
    
    NSLog(@"当前输入框文字个数:%ld",_noteTextView.text.length);
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
    
    [self updateViewsFrame];
}

/**
 *  发布按钮点击事件
 */
- (void)submitBtnClicked{
    //检查输入
    if (![self checkInput]) {
        return;
    }
    
    
    if ([_inputTextField.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"标题不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    if (_yBtn.selected == YES ||_dyBtn.selected == YES) {
        //输入正确将数据上传服务器->
        [self submitToServer];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择部门或中心" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
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

#warning 在此处上传服务器->>
#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）
- (void)submitToServer{
    //大图数据
    NSArray *bigImageDataArray = [self getBigImageArray];
    
    NSMutableArray *photoData = [NSMutableArray array];

    
    //小图数组
    NSArray *smallImageArray = [NSArray array];
    smallImageArray = self.imageArray;
    
    //小图二进制数据
    NSMutableArray *smallImageDataArray = [NSMutableArray array];
    
    for (UIImage *smallImg in smallImageArray) {
        NSData *smallImgData = UIImagePNGRepresentation(smallImg);
        [smallImageDataArray addObject:smallImgData];
    }
    
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    //    self.dataSource = [NSMutableArray array];
    
    
    NSDictionary *dic = [NSDictionary dictionary];
    
    NSString *type;
    if (_yBtn.selected) {
        type = @"1";
    }
    if (_dyBtn.selected) {
        type = @"2";
    }
    
    
    dic = @{
        @"Type":type,
        @"GroupID":@"1",
        @"SendLeaderID":[NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]],
        @"Index":[NSString stringWithFormat:@"%lu",(unsigned long)bigImageDataArray.count],
        @"FileType":@"1",
        @"DynamicId":@"",
        @"Title":_inputTextField.text,
        @"Content":_noteTextView.text,
        @"Date":_dateLabel.text,
        @"isReedit":@"0"
            };
    [self showLoadingMinView];

    if (bigImageDataArray.count == 0) {
        [[NetworkSingleton sharedManager]postDataToResult:dic url:kaddDynamic successBlock:^(ModelRequestResult *responseBody) {
            [self hiddenLoadingMinView];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"发布成功!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                //上个页面刷新一下
                self.backReolad(1);
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:actionCacel];
            [self presentViewController:alertController animated:YES completion:nil];
            
        } failureBlock:^(ModelRequestResult *error) {
            
        }];
    }else{
       [[NetworkSingleton sharedManager]uploadPic:dic url:kaddDynamic photosData:bigImageDataArray successBlock:^(ModelRequestResult *responseBody) {
           [self hiddenLoadingMinView];
           
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"发布成功!" preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
               [self dismissViewControllerAnimated:YES completion:nil];
               //上个页面刷新一下
               self.backReolad(1);
               
               [self.navigationController popViewControllerAnimated:YES];
              
           }];
           [alertController addAction:actionCacel];
           [self presentViewController:alertController animated:YES completion:nil];
           
           
           
       } faileureBlock:^(ModelRequestResult *error) {
       }];
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _isTextView = YES;
    [_inputTextField becomeFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _isTextView = YES;
    

    

    [_noteTextView becomeFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(0, [self getPickerViewFrame].origin.y-noteTextHeight);
    }];
    
    NSString *numStr = [_textNumberLabel.text substringToIndex:_textNumberLabel.text.length-4-4];
    if([textView.text isEqualToString:[EditContent substringToIndex:7]] && [numStr isEqualToString:@"0"]) {
        _noteTextView.text = @"";
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"院部动态-编辑";
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
//用户向上偏移到顶端取消输入,增强用户体验
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //    NSLog(@"偏移量 scrollView.contentOffset.y:%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < ([self getPickerViewFrame].origin.y-noteTextHeight)) {
        if(_isTextView && _isEdit != YES) {
            [self viewTapped];
        }
    }

    //NSLog(@"scrollViewDidScroll");
}

-(void)dealloc // ARC模式下
{
    [self.noteTextView removeObserver:self forKeyPath:@"frame"];
}

/*!
 *  @brief 显示特小加载框
 */
- (void)showLoadingMinView
{
    [_actViewMin startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/*!
 *  @brief 隐藏特小加载框
 */
- (void)hiddenLoadingMinView
{
    [_actViewMin stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

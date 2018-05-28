//
//  ReplyYBVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/3/12.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ReplyYBVC.h"
#import "ReplyCell.h"
#import "NewsHeaderView.h"
#import "photoModel.h"
#import "HeaderFrame.h"
#import "HeaderModel.h"
#import "ReplyFooterView.h"
#import "ZanTableViewCell.h"
#import "NewsViewController.h"
#import "ReplyModel.h"


@interface ReplyYBVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)NSArray *replyArr;

@property(nonatomic,strong)UITapGestureRecognizer *tap;

@end

@implementation ReplyYBVC
{
    NSString *_replyStr;
    NSString *_tishiStr;
    NSString *_toPerson;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    
    [self setUI];
    _toPerson = @"";
}

-(void)setUI{
    
    self.myTableView.estimatedRowHeight = 30;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)hideJP{
    [self.view endEditing:YES];
}



-(void)initData{
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideJP)];
    
    _replyStr = @"";
    _tishiStr = @"回复信息";
    [self.myTableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ReplyCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZanTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZanTableViewCell class])];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HeaderFrame *FrameModel = [[HeaderFrame alloc]initWithModel:_model];
    return FrameModel.headerHight;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"NewsHeaderView" owner:self options:nil];
    NewsHeaderView *view = [arr  objectAtIndex:0];
    
    view.FrameModel = [[HeaderFrame alloc]initWithModel:_model];
    
    return view;
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
    return  _model.comments.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = _model.comments[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyModel *model = _model.comments[indexPath.row];

    UILabel *lab = [self.view viewWithTag:101];

    lab.text = [NSString stringWithFormat:@"回复:%@",model.CUserName];
    _toPerson = model.CUserId;
};


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ReplyFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ReplyFooterView class]) owner:self options:nil] firstObject];
    footerView.replyTextView.text = _replyStr;
    footerView.replyTextView.tag = 103;
    footerView.tishiLab.text = _tishiStr;
    footerView.replyTextView.delegate = self;
    footerView.tishiLab.tag = 101;
    
    footerView.passValue = ^(NSString *btn) {
        [self sendValue:btn];
    };
    return footerView;
}


-(void)sendValue:(NSString*)str{
        [self showLoadingMinView];
        NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
        NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    
    NSDictionary *dic = @{@"LeaderID":LeaderID,@"ID":_model.ID,@"Content":str,@"BeCommentLeaderId":_toPerson,@"CommentLeaderId":LeaderID,@"Type":_model.Type};
    
        [[NetworkSingleton sharedManager] postDataToResult:dic url:kPeplyDy successBlock:^(ModelRequestResult *responseBody) {
            if(responseBody.succWDJH) {
                [self hiddenLoadingMinView];
                [self.myTableView.mj_header endRefreshing];
                [LToast showWithText:@"回复成功"];
                self.backReolad(1);
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self.myTableView reloadData];
        } failureBlock:^(ModelRequestResult *error) {
            [self hiddenLoadingMinView];
            [LToast showWithText:error.errorMsg];
        }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 216;
}


- (void)keyboardWasShown:(NSNotification*)aNotification {
    //获取键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UITextView *tv = [self.view viewWithTag:103];
    CGRect tfRect = [tv.superview convertRect:tv.frame toView:self.view];
    CGFloat keyBoardMinY = Kscreen_height-keyBoardFrame.size.height;
    NSLog(@"键盘mixY%f 输入框maxY%f 屏幕高%f",keyBoardMinY+64,tfRect.origin.y+142,Kscreen_height);
    if (keyBoardMinY-64<tfRect.origin.y+142) {
        
        if (Kscreen_height-tfRect.origin.y-142<150) {
            //将视图上移计算好的偏移
            [UIView animateWithDuration:0.3 animations:^{
                self.view.frame = CGRectMake(0.0f, -keyBoardFrame.size.height+64, self.view.frame.size.width, self.myTableView.frame.size.height);
            }];
        }else{
           CGFloat cha = tfRect.origin.y+142 - (keyBoardMinY+64);
            
            //将视图上移计算好的偏移
            [UIView animateWithDuration:0.3 animations:^{
                self.view.frame = CGRectMake(0.0f, cha, self.view.frame.size.width, self.myTableView.frame.size.height);
                
            }];
        
        }
        
        
    }
    
   //在这里面写 避免跟collection的手势冲突
    [self.myTableView addGestureRecognizer:_tap];
 
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {

    // 键盘动画时间
    double duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.myTableView.frame.size.height);
    }];
    
    //键盘消息，被回复的人被重置
    _toPerson = @"";
    [self.myTableView  removeGestureRecognizer:_tap];
}

//防止被重用机制刷新没
- (void)textViewDidEndEditing:(UITextView *)textView{
    _replyStr = textView.text;
    if (textView.text.length >0 ) {
        _tishiStr = @"";
    }else{
        if (_toPerson == nil) {
            _tishiStr = @"回复信息";
        }
    }
    UILabel *lab = [self.view viewWithTag:101];
    lab.text = _tishiStr;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        UILabel *lab = [self.view viewWithTag:101];
        lab.text = @"";
    }
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

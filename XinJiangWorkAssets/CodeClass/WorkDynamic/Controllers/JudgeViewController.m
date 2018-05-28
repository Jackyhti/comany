//
//  JudgeViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/15.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "JudgeViewController.h"
#import "AppDelegate.h"
#import "JudgeView.h"


#define JudgeSpace   15
#define JudgeHeight  420
#define JudgeWidth   (Kscreen_width-JudgeSpace*2)

#define judgeBigHeight 500


@interface JudgeViewController ()



@end

@implementation JudgeViewController
{
    int _type;
}
- (void)showInView:(int)type {
    _type = type;
    if (type == 1) {
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [UIView animateWithDuration:0.5 animations:^{
            [app.window addSubview:self.view];
        }];
    }else if (type == 0){
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        _judge.frame = CGRectMake(JudgeSpace, Kscreen_height/2-judgeBigHeight/2,JudgeWidth,judgeBigHeight);

        [UIView animateWithDuration:0.5 animations:^{
            [app.window addSubview:self.view];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initJudgeView];
    
    [self keyBoardNosnotification];

}


- (void)initJudgeView {

    JudgeView *judgeView = [[JudgeView alloc] initWithFrame:CGRectMake(JudgeSpace, Kscreen_height/2-JudgeHeight/2,JudgeWidth,JudgeHeight)];
    self.judge = judgeView;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(arrangeTap:)];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:judgeView];
    //取消
    [judgeView setCancleButtonClickedBlock:^(UIView *arrView) {
        [self.view endEditing:YES];
        [self.view removeFromSuperview];
    }];
    //评价
    [judgeView setJudgeButtonClickedBlock:^(NSDictionary *dataDic) {
        
        [self sendData:dataDic];
    }];
}

-(void)sendData:(NSDictionary*)dic{
//    NSLog(@"%@",dic);
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kchangeArrange successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
//            NSDictionary *responDic = responseBody.responseObject;
            [self.view removeFromSuperview];
            [LToast showWithText:@"修改成功"];
            
            NSNotification  *not = [[NSNotification alloc]initWithName:@"close" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:not];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [LToast showWithText:error.errorMsg];
        NSLog(@"%@",error.errorMsg);
    }];

}




- (void)keyBoardNosnotification {
    //监听键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    //    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGRect keyboardRect = [aValue CGRectValue];
    //    CGRect keyboardFrame = [self.view convertRect:keyboardRect fromView:[[UIApplication sharedApplication] keyWindow]];
    //    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    
    
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    
    
    if(self.judge.frame.origin.y + self.judge.frame.size.height + kbSize.height > Kscreen_height) {
        CGFloat partHe = self.judge.frame.size.height - (Kscreen_height - kbSize.height - self.judge.frame.origin.y);
        [UIView animateWithDuration:0.2 animations:^{
            if (_type == 0) {
                self.judge.frame = CGRectMake(JudgeSpace, self.judge.frame.origin.y - partHe, JudgeWidth, judgeBigHeight);

            }else{
                
            self.judge.frame = CGRectMake(JudgeSpace, self.judge.frame.origin.y - partHe, JudgeWidth, JudgeHeight);
            }
        }];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
   
    if (_type == 0) {
        [UIView animateWithDuration:0.1 animations:^{
            _judge.frame = CGRectMake(JudgeSpace, Kscreen_height/2-judgeBigHeight/2,JudgeWidth,judgeBigHeight);
        }];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.judge.frame = CGRectMake(JudgeSpace,Kscreen_height/2-JudgeHeight/2, JudgeWidth, JudgeHeight);
            
        }];
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

}


- (void)arrangeTap:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
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

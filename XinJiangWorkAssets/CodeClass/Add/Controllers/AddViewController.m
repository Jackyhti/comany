//
//  AddViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/14.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "AddViewController.h"
#import "arrangeView.h"
#import "AppDelegate.h"
#import "DynamicViewController.h"
#define ArrangeSpace   15
#define ArrangeHeight  385
#define ArrangeWidth   (Kscreen_width-ArrangeSpace*2)

@interface AddViewController ()

@property (nonatomic, retain)arrangeView *arrange;


@end

@implementation AddViewController


- (void)showInView {
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [UIView animateWithDuration:0.5 animations:^{
        [app.window addSubview:self.view];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArrangeView];
    [self keyBoardNosnotification];
}

- (void)initArrangeView {
    arrangeView *arrange = [[arrangeView alloc] initWithFrame:CGRectMake(ArrangeSpace, Kscreen_height/2-ArrangeHeight/2, ArrangeWidth,ArrangeHeight)];
    
    self.arrange = arrange;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(arrangeTap:)];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:arrange];
    
    [arrange setCancleButtonClickedBlock:^(UIView *arrView) {
        [self viewHide];
    }];
    [arrange setCommitButtonClickedBlock:^(NSDictionary *dic) {
        //添加新安排
        [self commitArrangeWithDic:dic];
    }];
}

//提交
- (void)commitArrangeWithDic:(NSDictionary *)dic {
        [[NetworkSingleton sharedManager] postDataToResult:dic url:kaddmyarrange successBlock:^(ModelRequestResult *responseBody) {
            if(responseBody.succWDJH) {
                NSDictionary *responDic = responseBody.responseObject;
                NSLog(@"%@",responDic);
                [LToast showWithText:@"添加成功"];
                NSNotification *not = [[NSNotification alloc]initWithName:@"tj" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:not];
                [self viewHide];
                          }
        } failureBlock:^(ModelRequestResult *error) {
            [LToast showWithText:error.errorMsg];
        }];
}


- (void)viewHide {
    [UIView animateWithDuration:0.5 animations:^{
        [self.view endEditing:YES];
        self.view.hidden = YES;
    }];
}


#pragma mark Notification

- (void)arrangeTap:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self keyBoardNosnotification];
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
    if(self.arrange.frame.origin.y + self.arrange.frame.size.height + kbSize.height > Kscreen_height) {
        CGFloat partHe = self.arrange.frame.size.height - (Kscreen_height - kbSize.height - self.arrange.frame.origin.y);
        [UIView animateWithDuration:0.2 animations:^{
            self.arrange.frame = CGRectMake(ArrangeSpace, self.arrange.frame.origin.y - partHe, ArrangeWidth, ArrangeHeight);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    [UIView animateWithDuration:0.1 animations:^{
        self.arrange.frame = CGRectMake(ArrangeSpace,Kscreen_height/2-ArrangeHeight/2, ArrangeWidth, ArrangeHeight);
        
    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
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

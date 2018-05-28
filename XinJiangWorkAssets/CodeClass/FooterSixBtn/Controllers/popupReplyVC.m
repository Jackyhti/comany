//
//  popupReplyVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/28.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "popupReplyVC.h"
#import "AppDelegate.h"

@interface popupReplyVC ()

@end

@implementation popupReplyVC

-(void)showView{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [UIView animateWithDuration:0.5 animations:^{
        [app.window addSubview:self.view];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [self keyBoardNosnotification];

}

-(void)initView{
    
    popupReplyView *view = [[[NSBundle mainBundle]loadNibNamed:@"popupReplyView" owner:nil options:nil] firstObject];
  
    view.close = ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.view.hidden = YES;
            [self.view endEditing:YES];
        }];
    };
    view.frame = CGRectMake(20, Kscreen_height/2-381/2, Kscreen_width-40, 381);
    self.popView = view;
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(arrangeTap:)];
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:view];
    
}

- (void)keyBoardNosnotification {
    //监听键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark Notification

- (void)arrangeTap:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    //    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGRect keyboardRect = [aValue CGRectValue];
    //    CGRect keyboardFrame = [self.view convertRect:keyboardRect fromView:[[UIApplication sharedApplication] keyWindow]];
    //    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    if(self.popView.frame.origin.y + self.popView.frame.size.height + kbSize.height > Kscreen_height) {
        CGFloat partHe = self.popView.frame.size.height - (Kscreen_height - kbSize.height - self.popView.frame.origin.y);
        [UIView animateWithDuration:0.2 animations:^{
            self.popView.frame = CGRectMake(20, self.popView.frame.origin.y - partHe, Kscreen_width-40, 381);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    [UIView animateWithDuration:0.1 animations:^{
        self.popView.frame = CGRectMake(20,Kscreen_height/2-381/2, Kscreen_width-40, 381);
        
    }];
    
    
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

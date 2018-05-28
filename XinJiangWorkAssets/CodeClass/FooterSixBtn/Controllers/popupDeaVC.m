//
//  popupDeaVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/16.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "popupDeaVC.h"
#import "AppDelegate.h"
@interface popupDeaVC ()

@end

@implementation popupDeaVC


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
}

-(void)initView{
   
    popupDeaView *view = [[[NSBundle mainBundle]loadNibNamed:@"popupDeaView" owner:nil options:nil] firstObject];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.close = ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.view.hidden = YES;
        }];
    };
    view.frame = CGRectMake(10, 30, Kscreen_width-20, Kscreen_height-50);
    self.popView = view;
    [self.view addSubview:view];
    
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

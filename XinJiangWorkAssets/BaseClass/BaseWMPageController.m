//
//  BaseWMPageController.m
//  wirelessLuoYang
//
//  Created by csip on 16/4/26.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "BaseWMPageController.h"


@interface BaseWMPageController ()

@end


@implementation BaseWMPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.isHidenBackBtn4Present) {
        [self setNavLeftBarButtonItem];
    }
}

- (void)setNavLeftBarButtonItem
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 2, 60, 40);
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
    [backBtn setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)leftItemAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

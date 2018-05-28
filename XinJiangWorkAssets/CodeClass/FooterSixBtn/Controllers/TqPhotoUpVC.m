//
//  TqPhotoUpVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "TqPhotoUpVC.h"
#import "UITextView+Placeholder.h"
@interface TqPhotoUpVC ()

@end

@implementation TqPhotoUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
}

-(void)setUI{
    self.title = @"报告新特情";
    self.myTextView.placeholder = @"填写新特情";
    
    [self initPickerView];
    self.maxCount = 3;
    [self updatePickerViewFrameY:165];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ac)];
    [self.view addGestureRecognizer:tap];
}

-(void)ac{
    [self.myTextView resignFirstResponder];
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

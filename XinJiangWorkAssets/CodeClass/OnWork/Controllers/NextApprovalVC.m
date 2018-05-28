//
//  NextApprovalVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/23.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "NextApprovalVC.h"

@interface NextApprovalVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consizeY;
@property (weak, nonatomic) IBOutlet UILabel *conLab;
@property (strong, nonatomic) IBOutlet UIView *conView;

@end

@implementation NextApprovalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *labStr = @"打算百度打算百度打算百度打算百度打算百";
   
    self.conLab.text = labStr;
    //获取尺寸
    CGSize size = [self.conLab sizeThatFits:CGSizeMake(Kscreen_width-20-8-69.5, MAXFLOAT)];
    CGFloat labheight = size.height;
    
    NSLog(@"%f",labheight);
    
    NSLog(@"页面高%f",self.conView.size.height);
    
    self.consizeY.constant =  self.conView.size.height - 60 + labheight+15+25 - Kscreen_height - labheight/21*9;

    NSLog(@"%f",self.consizeY.constant);

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

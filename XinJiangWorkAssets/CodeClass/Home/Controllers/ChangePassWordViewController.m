//
//  ChangePassWordViewController.m
//  LiveShow
//
//  Created by 成龙 on 17/4/20.
//  Copyright © 2017年 3L-LY. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "LoginViewController.h"
@interface ChangePassWordViewController ()

@property (weak, nonatomic) IBOutlet UIButton *conformButton;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self configUI];
}

//确认修改密码
- (IBAction)conformAction:(id)sender {
//    [LToast showWithText:@"确认修改"];
    [self.view endEditing:YES];
    
    if (self.oldPassWord.text .length> 0&&self.xinPassWord.text.length > 0 &&self.queDingPassWord.text.length > 0) {
        if ([self.xinPassWord.text isEqualToString:self.queDingPassWord.text]) {

            NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
            NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
            //    NSLog(@"%@",userDic);
            NSDictionary *dic = @{@"LeaderID":LeaderID,@"NewPassword":_queDingPassWord.text,@"Password":_oldPassWord.text};
                [[NetworkSingleton sharedManager] postDataToResult:dic url:kchangePassWord successBlock:^(ModelRequestResult *responseBody) {
                    if(responseBody.succWDJH) {
                        [LToast showWithText:@"修改成功,请重新登录"];
                        LoginViewController *vc =[[LoginViewController alloc]init];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.view.window.rootViewController = vc;

                        });
                    }
                } failureBlock:^(ModelRequestResult *error) {
                    [LToast showWithText:error.errorMsg];
                }];
        }else{
            [LToast showWithText:@"确认密码不一致与新密码不一致"];
        }
        
    }else{
        [LToast showWithText:@"不能为空"];
    
    }
    
    
    
    
}

- (void)configUI {
    self.conformButton.layer.cornerRadius = 3;
    self.conformButton.layer.masksToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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

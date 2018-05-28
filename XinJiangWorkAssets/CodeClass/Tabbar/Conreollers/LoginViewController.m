//
//  LoginViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/14.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseTabBarViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgWid;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgWid1;

//图片height
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgTopHeight;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUIConstant];
    
}

-(void)reload{
    [self setUser];
}

- (void)setUIConstant {
    self.bgWid.constant = SCALE(800);
    self.bgWid1.constant = SCALE(800) * 0.78;
    
    UIImage *img = [UIImage imageNamed:@"login-title"];
    
    self.imgTopHeight.constant = SCALE(180);
    self.imgHeight.constant = (screen_width-37*2) * img.size.height / img.size.width;
    
    self.userTF.keyboardType = UIKeyboardTypeNumberPad;
    
}


#pragma mark 登录

- (IBAction)loginAction:(id)sender {
    [self.view endEditing:YES];

//    [LToast showWithText:@"登录"];
    
    [self showLoadingMinView];
    NSDictionary *dic = @{@"phone":_userTF.text,@"password":_passWordTF.text};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kLoginURL successBlock:^(ModelRequestResult *responseBody) {
        [self hiddenLoadingMinView];
        if(responseBody.succWDJH) {
            
            [self.view endEditing:YES];
            
            NSDictionary *responDic = responseBody.responseObject;
            [[UserInfoManager shareGlobalSettingInstance] setUserInfo:responDic];
            [self setUser];

        }
    } failureBlock:^(ModelRequestResult *error) {
        [LToast showWithText:error.errorMsg];
        NSLog(@"%@",error.errorMsg);
        [self hiddenLoadingMinView];
    }];
    
//    BaseTabBarViewController *tabBarVC = [[BaseTabBarViewController alloc] init];
//    [self presentViewController:tabBarVC animated:YES completion:nil];
                          }




-(void)setUser{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    NSDictionary *dic = @{@"LeaderID":LeaderID};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:kGetUser successBlock:^(ModelRequestResult *responseBody) {
        [self hiddenLoadingMinView];
        if(responseBody.succWDJH) {
            [self.view endEditing:YES];
            
            NSDictionary *responDic = responseBody.responseObject;
//            NSLog(@"登录成功后数据%@",responDic);
            [[UserInfoManager shareGlobalSettingInstance] setUser:responDic];
            
            BaseTabBarViewController *tabBarVC = [[BaseTabBarViewController alloc] init];
            [self presentViewController:tabBarVC animated:YES completion:nil];
        }
    } failureBlock:^(ModelRequestResult *error) {
        [LToast showWithText:error.errorMsg];
        NSLog(@"%@",error.errorMsg);
        [self hiddenLoadingMinView];
    }];
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

//
//  BaseViewController.m
//  PeachStore
//
//  Created by Jacky on 16/5/28.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@property(nonatomic,strong)UIActivityIndicatorView *actViewMin;
@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.automaticallyAdjustsScrollViewInsets = NO;
    //只保留按钮 隐藏右边文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor  = [UIColor whiteColor];
    
    
    _actViewMin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_actViewMin setFrame:CGRectMake((Kscreen_width - 30) /2, (Kscreen_height - 64 - 49)/2, 30, 30)];

    [self.view bringSubviewToFront:_actViewMin];
    _actViewMin.layer.zPosition = 10;
    [self.view addSubview:_actViewMin];
    
    if(self.isHiddenBackBtn == NO) {
        [self isShowBackBtnVoid];
    }
    // Do any additional setup after loading the view.
}

-(void)LeftItemAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)RightItemAction:(UIButton *)sender {
    
}

- (void)isShowBackBtnVoid
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 2, 60, 40);
    //    backBtn.backgroundColor = separaterColor;
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
    
    [backBtn setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(LeftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn_bg"] style:UIBarButtonItemStylePlain target:self action:@selector(LeftItemAction:)];
    //    [leftItem setImageInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    //        self.navigationItem.backBarButtonItem = leftItem;
    
    //    //自定义返回按钮
    //    UIImage *backButtonImage = [[UIImage imageNamed:@"back_btn_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
}


/*!
 *  @brief 显示加载动画
 */

- (void)showWaitingPicView
{
    UIView *loadV = [[UIView alloc]initWithFrame:CGRectMake((Kscreen_width - 100)/2, (Kscreen_height - 125)/2 - 30, 100, (250/2.0) + 30)];
    loadV.tag = 9000;
    loadV.hidden = NO;
    [self.view addSubview:loadV];
    
    UILabel *loadText = [[UILabel alloc]initWithFrame:CGRectMake(0, H(loadV) - 30, W(loadV), 30)];
    loadText.text = @"等我召唤数据来…";
    loadText.textColor = kColor(90, 90, 90, 1);
    loadText.textAlignment = NSTextAlignmentCenter;
    loadText.hidden = NO;
    loadText.adjustsFontSizeToFitWidth = YES;
    [loadV addSubview:loadText];
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 250/2.0)];
    
    NSMutableArray *gifMuArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 17; i++) {
        NSString *picName = [NSString stringWithFormat:@"load－%i.tiff",i];
        UIImage *image = [UIImage imageNamed:picName];
        [gifMuArray addObject:image];
    }
    
    gifImageView.animationImages = gifMuArray; //动画图片数组
    gifImageView.animationDuration = 1.5f; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 0;  //动画重复次数
    [gifImageView startAnimating];
    [loadV addSubview:gifImageView];
    
    double delayInSeconds = 0.3;
    //    __block BaseViewController *self = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,
                                            (int64_t)(delayInSeconds * NSEC_PER_SEC)); dispatch_after(popTime,                                                                                                      dispatch_get_main_queue(), ^(void){                                                                                                          [self showLoadV];                                                                                                      });
}

- (void)showLoadV
{
    UIView *loadV = (UIView *)[self.view viewWithTag:9000];
    [loadV setHidden:NO];
}


- (void)showToastCenterText:(NSString *)text
{
    [LToast showWithText:text];
}

- (void)showToastBottomText:(NSString *)text
{
    [LToast showWithText:text bottomOffset:100];
}


/*!
 *  @brief 显示加载框
 */
- (void)showLoadingSVP
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}

/*!
 *  @brief 显示特小加载框
 */
- (void)showLoadingMinView
{
    [_actViewMin startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/*!
 *  @brief 显示加载框带文字
 *
 *  @param text 要显示的文字
 */
- (void)showLoadingSVPWithText:(NSString *)text
{
    [SVProgressHUD showWithStatus:text];
}

/*!
 *  @brief 显示加载框带文字
 */
- (void)showLoadingSVPText
{
    [SVProgressHUD showWithStatus:@"加载中，请稍后..."];
}

/*!
 *  @brief 隐藏加载框
 */
- (void)hiddenLoadingSVP
{
    [SVProgressHUD dismiss];
}

/*!
 *  @brief 隐藏特小加载框
 */
- (void)hiddenLoadingMinView
{
    [_actViewMin stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*!
 *  @brief 隐藏加载动画
 */
- (void)hiddenWaitingPicView
{
    UIView *view = [self.view viewWithTag:9000];
    [view removeFromSuperview];
}

/*!
 *  @brief 加载失败的View显示
 */
- (void)errorWaitingPicView
{
    
}



// 根据图片url获取图片尺寸
-(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}


//  获取PNG图片的大小
-(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
-(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
-(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}


//缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
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

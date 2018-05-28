//
//  UIView+ShowBigImageView.m
//  yyyy
//
//  Created by mac on 2016/12/1.
//  Copyright © 2016年 闫金泉. All rights reserved.
//

#import "UIView+ShowBigImageView.h"
@interface ShowImageViewController: UIViewController
@property (nonatomic, assign) CGRect fromRect;
@property (nonatomic, assign) CGRect torect;
@property (nonatomic, strong)UIImageView *imageV;
@end


@implementation UIView (ShowBigImageView)

- (void)showBigImage:(UIImage *)image toSize:(CGSize)size{
    CGRect screenFream = [UIScreen mainScreen].bounds;
    CGPoint point = CGPointMake((screenFream.size.width - size.width) / 2, (screenFream.size.height - size.height) / 2);
    CGRect frame;
    frame.origin = point;
    frame.size = size;
    [self showBigImage:image toFrame:frame];
}
- (void)showBigImage:(UIImage *)image toFrame:(CGRect)frame{
    CGRect rect = self.fremeInWindow;
    ShowImageViewController *showVc = [[ShowImageViewController alloc]init];
    showVc.fromRect = rect;
    showVc.torect = frame;
    showVc.imageV.image = image;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVc animated:NO completion:nil];
}
- (CGRect)fremeInWindow{
    CGRect rect;
    rect.origin = [self viewScreenPoint];
    rect.size = self.frame.size;
    return rect;
}
- (CGPoint)viewScreenPoint{
    if (self.superview != nil) {
        CGPoint superOrin = [self.superview viewScreenPoint];
        if ([self.superview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroolV = (UIScrollView *)self.superview;
            superOrin.x = superOrin.x + scroolV.contentInset.left - scroolV.contentOffset.x;
            superOrin.y = superOrin.y + scroolV.contentInset.top - scroolV.contentOffset.y;
            
        }
        return CGPointMake(self.frame.origin.x + superOrin.x, self.frame.origin.y + superOrin.y);
    }else{
        return self.frame.origin;
    }
}

@end
@implementation ShowImageViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imageV];
    self.imageV.frame = _fromRect;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /**
     颜色
     */
//    self.view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    self.view.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.imageV.frame = _torect;
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self.view addGestureRecognizer:tap];
    }];
}
- (void)tap:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageV.frame = _fromRect;
    } completion:^(BOOL finished) {
      [self dismissViewControllerAnimated:NO completion:nil];;
    }];
    
}
- (UIImageView *)imageV{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc]init];
    }
    return _imageV;
}

@end

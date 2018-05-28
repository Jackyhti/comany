//
//  MenuView.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/8.
//  Copyright © 2017年 yyz. All rights reserved.
//

#define CoverViewAlpha                  0.7
#define CoverViewBackGround [UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1.0]


#import "MenuView.h"

@interface MenuView ()

@property (nonatomic ,assign)CGRect         menuViewframe;
@property (nonatomic ,assign)CGRect         coverViewframe;
@property (nonatomic ,strong)UIView         *coverView;
@property (nonatomic ,strong)UIView         *leftMenuView;
@property (nonatomic ,assign)BOOL           isShowCoverView;

@end


@implementation MenuView

+(instancetype)MenuViewWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover{
    
    MenuView *menu = [[MenuView alloc]initWithDependencyView:dependencyView MenuView:leftmenuView isShowCoverView:isCover];
    
    return menu;
}


-(instancetype)initWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover{
    
    if(self = [super init]){
        self.isShowCoverView = isCover;
        
        [self addPanGestureAtDependencyView:dependencyView];
        self.leftMenuView = leftmenuView;
        //      if((CGRectEqualToRect(_coverViewframe, CGRectZero)) == NO){
        self.menuViewframe = leftmenuView.frame;
        //      }else{
        //      }
//        self.coverViewframe = CGRectMake(0,0, Kscreen_width, self.menuViewframe.size.height);
        self.coverViewframe = CGRectMake(0,0, Kscreen_width,Kscreen_height);
    }
    return self;
}

-(void)setIsShowCoverView:(BOOL)isShowCoverView
{
    _isShowCoverView = isShowCoverView;
    
    if(self.isShowCoverView){
        self.coverView.backgroundColor = CoverViewBackGround ;
    }else{
        self.coverView.backgroundColor = [UIColor clearColor];
    }
    
}

-(void)addPanGestureAtDependencyView:(UIView *)dependencyView{
    
    // 屏幕边缘pan手势(优先级高于其他手势)
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = \
    [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleLeftEdgeGesture:)];
    leftEdgeGesture.edges                             = UIRectEdgeLeft;// 屏幕左侧边缘响应
    [dependencyView addGestureRecognizer:leftEdgeGesture]; //
}


//-(void)initView{

//    if(self.isShowCoverView){
//        self.coverView.backgroundColor = CoverViewBackGround;
//    }else{
//        self.coverView.backgroundColor = [UIColor clearColor];
//    }
//
//    [self setBackgroundColor:[UIColor clearColor]];
//    [self.leftMenuView setBackgroundColor:MenuViewBackgroundColor];
//}



-(void)show{
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.coverView];
    [window addSubview:self.leftMenuView];
    
    self.leftMenuView.frame = CGRectMake(Kscreen_width, self.menuViewframe.origin.y, self.menuViewframe.size.width, self.menuViewframe.size.height);
    self.coverView.frame = CGRectMake(0, 0, Kscreen_width, self.menuViewframe.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.leftMenuView.frame = self.menuViewframe;
        self.coverView.frame    = self.coverViewframe;
        self.coverView.alpha = CoverViewAlpha;
    }];
}




-(void)hidenWithoutAnimation{
    
    [self removeCoverAndMenuView];
}
-(void)hidenWithAnimation{
    
    [self coverTap];
}


#pragma mark - 屏幕左侧菜单
-(UIView *)leftMenuView{
    
    if(_leftMenuView == nil){
        
        UIView *LeftView = [[UIView alloc]initWithFrame:self.menuViewframe];
        _leftMenuView    = LeftView;
        
    }
    return _leftMenuView;
}


#pragma mark - 遮盖
-(UIView *)coverView {
    
    if (_coverView == nil) {
        
        UIView *Cover = [[UIView alloc]initWithFrame:self.coverViewframe];
        Cover.backgroundColor                     = CoverViewBackGround;
        Cover.alpha                               = 0;
        UITapGestureRecognizer *Click             = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverTap)];
        [Cover addGestureRecognizer:Click];
        
        UIGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(handleftPan:)];
        
        [Cover addGestureRecognizer:panGestureRecognizer];
        [Click requireGestureRecognizerToFail:panGestureRecognizer];
        
        _coverView = Cover;
    }
    return _coverView;
}


#pragma mark - 屏幕往右滑处理
- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture{

}


#pragma mark - coverView往左滑隐藏
-(void)handleftPan:(UIPanGestureRecognizer*)recognizer{
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    static CGFloat BeganX;
    
    if(UIGestureRecognizerStateBegan == recognizer.state){
        BeganX = translation.x;
    }

    
    CGFloat Place = (translation.x) - (BeganX);
    if(translation.x > 0) {
        CGFloat x           = 0 ;

        if(UIGestureRecognizerStateBegan == recognizer.state ||
           UIGestureRecognizerStateChanged == recognizer.state){
            
            CGFloat y           = self.menuViewframe.origin.y;
            CGFloat w           = self.menuViewframe.size.width;
            CGFloat h           = self.menuViewframe.size.height;

            if(Place <= self.leftMenuView.frame.size.width && Place > 0){
                x  = self.leftMenuView.frame.size.width+Place;
                
                self.coverView.frame    = CGRectMake(self.leftMenuView.frame.size.width-Place, 0,Kscreen_width-self.leftMenuView.frame.size.width+Place, h);
                self.coverView.alpha    = CoverViewAlpha;
                
                
            }else if(Place > 0){
                
                x  = Kscreen_width;
                
                //            CGFloat y           = self.menuViewframe.origin.y;
                //            CGFloat w           = self.menuViewframe.size.width;
                //            CGFloat h           = self.menuViewframe.size.height;
                //            self.leftMenuView.frame = CGRectMake(x, y, w, h);//self.LeftViewFrame;
                self.coverView.frame    = CGRectMake(0, 0,Kscreen_width,h);
                self.coverView.alpha    = CoverViewAlpha;

            }else{
                x  = Kscreen_width;
                
                //            self.leftMenuView.frame = CGRectMake(x, y, w, h);
                
                self.coverView.frame    = CGRectMake(self.leftMenuView.frame.size.width, 0,Kscreen_width-self.leftMenuView.frame.size.width, h);
                self.coverView.alpha    = CoverViewAlpha;
                
                
            }
            
            self.leftMenuView.frame = CGRectMake(x, y, w, h);
            
            
        }else{
            
            //结束
            
            [self hidenWithAnimation];
        }

    }
    
}


-(void)openMenuView{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat x           = 0;
        CGFloat y           = self.menuViewframe.origin.y;
        CGFloat w           = self.menuViewframe.size.width;
        CGFloat h           = self.menuViewframe.size.height;
        self.leftMenuView.frame = CGRectMake(x, y, w, h);
        
        self.coverView.frame    = self.coverViewframe;
        self.coverView.alpha    = CoverViewAlpha;
    }];
}

-(void)closeMenuView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat x           = -self.menuViewframe.size.width;
        CGFloat y           = self.menuViewframe.origin.y;
        CGFloat w           = self.menuViewframe.size.width;
        CGFloat h           = self.menuViewframe.size.height;
        self.leftMenuView.frame = CGRectMake(x, y, w, h);//self.LeftViewFrame;
        self.coverView.frame    = CGRectMake(0, 0,Kscreen_width, self.menuViewframe.size.height);
        
    } completion:^(BOOL finished) {
        [self removeCoverAndMenuView];
    }];
}



#pragma mark - 点击遮盖移除
-(void)coverTap{
    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.leftMenuView.frame = CGRectMake(Kscreen_width,self.menuViewframe.origin.y, self.menuViewframe.size.width, self.menuViewframe.size.height);
        self.coverView.frame    = CGRectMake(Kscreen_width, 0,Kscreen_width, Kscreen_height);
        self.coverView.alpha    = 0.0;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.leftMenuView removeFromSuperview];
    }];
    
}





#pragma mark - 移除菜单和遮盖
-(void)removeCoverAndMenuView{

    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.leftMenuView.frame = CGRectMake(Kscreen_width,self.menuViewframe.origin.y, self.menuViewframe.size.width, self.menuViewframe.size.height);
        self.coverView.frame    = CGRectMake(Kscreen_width, 0,Kscreen_width, Kscreen_height);
        self.coverView.alpha    = 0.0;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.leftMenuView removeFromSuperview];
    }];

}


//
//-(CGRect)menuViewframe{
//
//    if((CGRectEqualToRect(_menuViewframe,CGRectZero)) == YES){
//
//        //设置左侧菜单
//        CGFloat w                   = kSCREEN_WIDTH * MenuView_scale_of_Screen;
//        CGFloat h                   = kSCREEN_HEIGHT;
//        CGFloat x                   = 0;
//        CGFloat y                   = 0;
//        _menuViewframe = CGRectMake(x , y , w , h);
//    }
//    return _menuViewframe;
//}
//
//
//
//-(CGRect)coverViewframe{
//
//     if((CGRectEqualToRect(_coverViewframe, CGRectZero)) == YES){
//
//        _coverViewframe = CGRectMake(self.menuViewframe.size.width, self.menuViewframe.origin.y, kSCREEN_WIDTH - self.menuViewframe.size.width, self.menuViewframe.size.height);
//    }
//    return _coverViewframe;
//}



@end

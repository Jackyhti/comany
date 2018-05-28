//
//  NewsHeaderView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "NewsHeaderView.h"
#import "HeaderPhotoCell.h"
#import "UIView+Frame.h"
#import "LBPhotoBrowserManager.h"
#import <ImageIO/ImageIO.h>

@interface NewsHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<photoModel *> *imageURLs;

@property (nonatomic , strong)NSMutableArray *urls;

@property (weak, nonatomic) IBOutlet UILabel *headerTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *headerConLab;

@property (weak, nonatomic) IBOutlet UICollectionView *HeaderCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic , strong)NSMutableArray *imageViews;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation NewsHeaderView



-(void)awakeFromNib{
    [super awakeFromNib];
    [self initData];
    
    [self.HeaderCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeaderPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HeaderPhotoCell class])];
    self.HeaderCollectionView.delegate = self;
    self.HeaderCollectionView.dataSource = self;
    self.HeaderCollectionView.contentInset = UIEdgeInsetsMake(0, 2, 0, 2);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.minimumLineSpacing = 10;
    CGFloat intemWH = (Kscreen_width-120)/3;
    self.flowLayout.itemSize = CGSizeMake(intemWH, intemWH);
    self.HeaderCollectionView.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    self.imageViews = [NSMutableArray array];
    self.urls = [NSMutableArray array];
}

-(void)setFrameModel:(HeaderFrame *)FrameModel{
    _FrameModel = FrameModel;

    HeaderModel *model = FrameModel.headerModel;
    NSString *str;
    if ([model.Type isEqualToString:@"1"]) {
        str = @"[中心动态]";
    }else if ([model.Type isEqualToString:@"2"]){
    str = @"[部门动态]";
    }
    self.headerTitleLab.text = [NSString stringWithFormat:@"%@%@",str,model.Title];
    self.headerConLab.text = [NSString stringWithFormat:@"%@",model.Content];
    self.imageURLs = model.imgUrls;
    self.timeLab.text = [NSString stringWithFormat:@"发布时间:%@",model.PubTime];
}





#pragma mark - collectionVeiwDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeaderPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeaderPhotoCell class]) forIndexPath:indexPath];
    photoModel *model = self.imageURLs[indexPath.row];
    
    
    NSString *url = [model.ImgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [cell.photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBASE_YBURL,url]] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
 
    cell.numLab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    [self.urls addObject:[NSString stringWithFormat:@"%@%@",KBASE_YBURL,url] ];
    [self.imageViews  addObject:cell.photo];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[LBPhotoBrowserManager defaultManager] showImageWithURLArray:self.urls fromImageViews: _imageViews andSelectedIndex:(int)indexPath.row andImageViewSuperView:_imageViews[(int)indexPath.row]];
    // 添加长按手势的效果
//    [[[LBPhotoBrowserManager defaultManager] addLongPressShowTitles:titleArr] addTitleClickCallbackBlock:^(UIImage *image, NSIndexPath *indexPath, NSString *title) {
//        LBPhotoBrowserLog(@"%@ %@ %@",image,indexPath,title);
//    }].style = LBMaximalImageViewOnDragDismmissStyleOne; // 默认的就是LBMaximalImageViewOnDragDismmissStyleOne
    
    // 给每张图片添加占位图
    [[LBPhotoBrowserManager defaultManager] addPlaceHoldImageCallBackBlock:^UIImage *(NSIndexPath *indexPath) {
        LBPhotoBrowserLog(@"%@",indexPath);
        return [UIImage imageNamed:@"LBLoading.png"];
    }].lowGifMemory = YES; // lowGifMemory 这个在真机上效果明显 模拟器用的是电脑的内存
  

}

//#pragma mark - Setter & Getter
//- (void)setImageURLs:(NSArray<NSString *> *)imageURLs
//{
//    _imageURLs = imageURLs;
//    /// 归位
//    self.optimalProductCollectionView.contentOffset = CGPointMake(-SUGlobalViewLeftOrRightMargin, 0);
//    [self.optimalProductCollectionView reloadData];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

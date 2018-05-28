//
//  HeaderFrame.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/5.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "HeaderFrame.h"
#import "HeaderModel.h"
@interface HeaderFrame()

//@property(nonatomic,strong)HeaderModel *headerModel;

@property(nonatomic,assign)CGRect titleFrame;

@property(nonatomic,assign)CGRect conFrame;

@property(nonatomic,assign)CGRect photoCollectionFrame;

//@property(nonatomic,assign)CGFloat headerHight;

@end

@implementation HeaderFrame


-(instancetype)initWithModel:(HeaderModel *)model{
    self = [super init];
    if (self) {
        self.headerModel = model;
        CGFloat titleHight = [self getHightWithStr:model.Title];
        self.titleFrame = CGRectMake(10, 10, Kscreen_width-20, titleHight);
        
        CGFloat conY = self.titleFrame.size.height + 10;
        CGFloat conHight = [self getHightWithStr:model.Content];
        self.conFrame = CGRectMake(10, conY, Kscreen_width - 20, conHight);
        
        CGFloat photoY = conY+conHight + 10;
        
        CGFloat photoViewHight;
        CGFloat spc = (Kscreen_width-120)/3+5;
        if (model.imgUrls.count == 0) {
            photoViewHight = 15;
        }else if (model.imgUrls.count > 0 && model.imgUrls.count<= 3){
            photoViewHight = spc+10;
        }else if (model.imgUrls.count >3 && model.imgUrls.count <= 6){
            photoViewHight = spc*2;
        }else if (model.imgUrls.count >6 && model.imgUrls.count <= 9){
            photoViewHight = spc*3 ;
        }else{
            photoViewHight = 0 ;
        }
        self.photoCollectionFrame = CGRectMake(10, photoY, Kscreen_width - 20, photoViewHight);
        
        self.headerHight = _titleFrame.size.height + _conFrame.size.height + _photoCollectionFrame.size.height+75;
        
    }
    return self;
}

- (float)getHightWithStr:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    
    CGSize size = CGSizeMake(Kscreen_width, 1000);
    
    CGSize contentactually = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
    return contentactually.height;
    
}

@end

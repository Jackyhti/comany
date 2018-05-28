//
//  QJThreeTableViewCell.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/2/27.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "QJThreeTableViewCell.h"
#import "PersonCollectionViewCell.h"
@interface QJThreeTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



@end

@implementation QJThreeTableViewCell
{
    NSMutableArray *selectArr;
    NSMutableArray *dataArr;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    selectArr = [NSMutableArray array];
    dataArr = [NSMutableArray array];
    [dataArr addObject:@"1"];
    [dataArr addObject:@"2"];
    self.selectView.dataSource = self;
    self.selectView.delegate = self;
    
    // Initialization code
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  dataArr.count + 1;
;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"PersonCollectionViewCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"PersonCollectionViewCell"];
    // Set up the reuse identifier
    PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"PersonCollectionViewCell" forIndexPath:indexPath];
    if (dataArr.count == 0) {
        cell.photoImage.image = [UIImage imageNamed:@"addBlue"];
        cell.conLab.text = @"";
    }else{
        if (indexPath.row == dataArr.count) {
            cell.photoImage.image = [UIImage imageNamed:@"tianjiaanpai"];
            cell.conLab.text = @"";
        }
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70,93);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 1, 8, 1);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  arrangeView.h
//  NetWorkNoteBook
//
//  Created by zhenzhen on 16/7/5.
//  Copyright © 2016年 csip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface arrangeView : UIView<UITextViewDelegate>



@property (nonatomic, copy) void (^cancleButtonClickedBlock)(UIView *arrView);
@property (nonatomic, copy) void (^commitButtonClickedBlock)(NSDictionary *dic);


@end

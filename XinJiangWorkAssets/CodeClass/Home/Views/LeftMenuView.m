//
//  LeftMenuView.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/8.
//  Copyright © 2017年 yyz. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200
#import "LeftMenuView.h"
#import "MenuHeaderView.h"
#import "GroupModel.h"
#import "GroupPerModel.h"
#import "GroupInfoMoel.h"
@interface LeftMenuView ()<UITableViewDataSource,UITableViewDelegate>
{
    CGRect _frame;
}

@property (nonatomic ,strong)UITableView    *contentTableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,assign)BOOL isopen;

@property(nonatomic,assign)NSInteger sec;

@property(nonatomic,strong)GroupInfoMoel *infoModel;

@property(nonatomic,weak)MenuHeaderView *headerView;

@end



@implementation LeftMenuView

-(NSMutableArray*)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        _frame = frame;
        [self getData];
        [self initView];
    }
    return  self;
}

-(void)getData{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *parId = [NSString stringWithFormat:@"%@",userDic[@"data"][@"ParentID"]];
//    NSLog(@"%@",userDic);
    NSDictionary *dic = @{@"ParentID":parId};
    [[NetworkSingleton sharedManager] postDataToResult:dic url:bumenListUrl successBlock:^(ModelRequestResult *responseBody) {
        if(responseBody.succWDJH) {
            NSDictionary *responDic = responseBody.responseObject;
            _infoModel = [GroupInfoMoel mj_objectWithKeyValues:responDic];
            for (NSDictionary *dic in responDic[@"list"]) {
                GroupModel *model = [GroupModel mj_objectWithKeyValues:dic];
                [self.dataSource addObject:model];
            }
            
        }
        [self.contentTableView reloadData];
    } failureBlock:^(ModelRequestResult *error) {
        [LToast showWithText:error.errorMsg];
    }];

}


-(void)initView{
    self.backgroundColor = [RGB(46, 64, 160) colorWithAlphaComponent:0.7];
    
    //中间tableview
    UITableView *contentTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0,0, _frame.size.width,_frame.size.height)
                                                                       style:UITableViewStylePlain];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:[RGB(46, 64, 160) colorWithAlphaComponent:0.7]];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleSingleLine;
    contentTableView.separatorColor = [UIColor clearColor];
    contentTableView.tableFooterView = [UIView new];
    contentTableView.separatorInset = UIEdgeInsetsZero;
    contentTableView.layoutMargins = UIEdgeInsetsZero;
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];

}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_infoModel) {
        return self.dataSource.count;
    }else
    {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(_infoModel) {
            GroupModel *model = _dataSource[section];
            NSArray *sectionArr = model.LeaderList;
            
            if([model.isOpen isEqualToString:@"1"]) {
                return sectionArr.count;
                NSLog(@"%ld",sectionArr.count);
            }else {
                return 0;
            }
    }else{
        return 0;
    }
}
    


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    //    [cell setCellModel:nil indexPath:indexPath];
    //    [cell setBackgroundColor:[UIColor colorWithHexString:ColorBackGround]];
    cell.hidden = NO;
    GroupModel *listModel =  _dataSource[indexPath.section];
    NSDictionary *dic  = listModel.LeaderList[indexPath.row];
    GroupPerModel *perModel = [[GroupPerModel alloc]init];
    perModel = [GroupPerModel mj_objectWithKeyValues:dic];

   [cell.textLabel setText: [NSString stringWithFormat:@"         %@",perModel.LeaderName]];
cell.textLabel.font = [UIFont systemFontOfSize:17];
    return cell;
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MenuHeaderView" owner:nil options:nil];
    _headerView =  [arr objectAtIndex:0];
    _headerView.sec = section;
//    GroupModel *model = [[GroupModel alloc]init];
    _headerView.groupModel =  self.dataSource[section];
//    _headerView.conLab.text = model.GroupName;
    

    __weak typeof(self)weakself = self;
    weakself.headerView.tapBlack = ^(NSInteger sec){
        GroupModel *listModel =  weakself.dataSource[section];
        NSString *group = listModel.GroupID;
        NSString *name = listModel.GroupName;
        NSDictionary *userDic = @{@"groupID":group,@"name":name};

//        [self.customDelegate LeftMenuViewClick:userDic];

        [self.customDelegate LeftMenuViewSectionClick:userDic];
        
        if([listModel.isOpen isEqualToString:@"0"]) {
            listModel.isOpen = @"1";
        }else {
            listModel.isOpen = @"0";
        }
        
        for (int i = 0 ; i<weakself.dataSource.count;i++ ) {
            GroupModel *listModel =  weakself.dataSource[i];
            if (i == section) {
                
            }else{
            listModel.isOpen = @"0";
            }
        }
        
            [weakself.contentTableView reloadData];
    };
    
    
    return self.headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        GroupModel *listModel =  _dataSource[indexPath.section];
        NSDictionary *dic  = listModel.LeaderList[indexPath.row];
        GroupPerModel *perModel = [[GroupPerModel alloc]init];
        perModel = [GroupPerModel mj_objectWithKeyValues:dic];
        NSString *leaderID = [NSString stringWithFormat:@"%@",perModel.LeaderID];
        NSString *section = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
        NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
        NSDictionary *userDic = @{@"leaderID":leaderID,@"section":section,@"row":row};
        
        [self.customDelegate LeftMenuViewClick:userDic];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}


@end

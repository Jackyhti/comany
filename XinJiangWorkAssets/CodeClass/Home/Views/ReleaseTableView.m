//
//  ReleaseTableView.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/1/19.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "ReleaseTableView.h"
#import "ReleaseTableViewCell.h"
#import "GroupListModel.h"
@interface ReleaseTableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *stats;
    NSInteger indexNum;
    int _selectnum;
    int _selnum; //记录选择的数组的个数
}

@property(nonatomic,strong)GroupListModel *model;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)NSMutableArray *btnStatusArr; //记录自己按钮状态

@property(nonatomic,strong)NSMutableArray *btnselectArr; //记录谁点击了按钮，和没点击按钮

@property(nonatomic,strong)NSMutableArray *rightDataSource; //右侧数据源

@property(nonatomic,strong)NSMutableArray *rightBtnSratusArr;  //记录右侧状态

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIButton *fb;

@end

@implementation ReleaseTableView

-(NSMutableArray*)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray*)btnStatusArr{
    if (!_btnStatusArr) {
        _btnStatusArr = [NSMutableArray array];
       
    }
    return _btnStatusArr;
}

-(NSMutableArray*)btnselectArr{
    if (!_btnselectArr) {
        _btnselectArr = [NSMutableArray array];
    }
    return _btnselectArr;
}

-(NSMutableArray*)rightDataSource{
    if (!_rightDataSource) {
        _rightDataSource = [NSMutableArray array];
    }
    return _rightDataSource;
}

-(NSMutableArray *)rightBtnSratusArr{
    if (!_rightBtnSratusArr) {
        _rightBtnSratusArr = [NSMutableArray array];
    }
    return _rightBtnSratusArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    self.fb.layer.masksToBounds = YES;
    self.fb.layer.cornerRadius = 5;
    
    stats = @"0";
    _selectnum = 0;
    indexNum = 0;

    [self getData];
    self.leftTableView.delegate = self;
    self.rightTableView.delegate =self;
    
    self.leftTableView.dataSource = self;
    self.rightTableView.dataSource = self;
    [self.leftTableView registerNib:[UINib nibWithNibName:@"ReleaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self.rightTableView registerNib:[UINib nibWithNibName:@"ReleaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [self.stateBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    
    [self.stateBtn setImage:[UIImage imageNamed:@"checkbox_click"] forState:UIControlStateSelected];
    
}

- (IBAction)stateAC:(id)sender {
    self.stateBtn.selected = !self.stateBtn.selected;
}

-(void)getData{
    
    
        NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
        NSString *parId = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
        NSDictionary *dic = @{@"LeaderID":parId,@"Type":[NSString stringWithFormat:@"%d",1]};
        [[NetworkSingleton sharedManager] postDataToResult:dic url:kgetGroup successBlock:^(ModelRequestResult *responseBody) {
            if(responseBody.succWDJH) {
                NSDictionary *responDic = responseBody.responseObject;
             
//                NSLog(@"%@",responDic);
                for (NSDictionary *dics in responDic[@"list"]) {
                    _model = [GroupListModel mj_objectWithKeyValues:dics];
                    [_dataSource addObject:_model];
                    [self.rightDataSource addObject:_model.leaderlist];
                }
            }
            
            for (int i = 0; i<_dataSource.count; i++) {
                [self.btnStatusArr addObject:@"0"];
                [self.btnselectArr addObject:@"0"];
            }
            
            
            for (int a = 0; a<self.rightDataSource.count; a++) {
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                [self.rightBtnSratusArr addObject:arr];
                NSMutableArray *arrs = self.rightDataSource[a];
                for (int b = 0; b<arrs.count; b++) {
                    [self.rightBtnSratusArr[a] addObject:@"0"];
                }
            }
                [self.leftTableView reloadData];
                [self.rightTableView reloadData];
        } failureBlock:^(ModelRequestResult *error) {
            [LToast showWithText:error.errorMsg];
        }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.dataSource.count;
    }else{
        NSArray *arr = _rightDataSource[indexNum];
        return arr.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        ReleaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //只走一次
//        if (_selectnum == 0) {
//            NSInteger selectedIndex = 0;
//            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
//            [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        }
        
        [cell.checkBtn setTag:1000+indexPath.row];
        [cell.checkBtn addTarget:self action:@selector(actbtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([_btnStatusArr[indexPath.row]isEqualToString:@"1"]) {
            cell.checkBtn.selected = YES;
        }else{
            cell.checkBtn.selected = NO;
        }
        if ([_btnselectArr[indexPath.row]isEqualToString:@"1"]) {
            cell.labCon.textColor = [UIColor blueColor];
        }else{
            cell.labCon.textColor = [UIColor blackColor];
        }
        cell.model = _dataSource[indexPath.row];
//        _selectnum ++;
        
        //总数
        NSArray *arrZong = _rightBtnSratusArr[indexPath.row];
        NSInteger zong = arrZong.count;
        
        int a = 0;
        for (int i = 0; i<arrZong.count; i++) {
            if ([arrZong[i]isEqualToString:@"1"]) {
                a++;
            }
        }
        cell.numLab.text = [NSString stringWithFormat:@"(%d/%ld)",a,(long)zong];

        return cell;

    }else if (tableView == self.rightTableView){

        ReleaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        cell.numLab.text = @"";
        cell.accessoryType = UITableViewCellAccessoryNone;

        cell.labCon.text = _rightDataSource[indexNum][indexPath.row][@"Name"];
        
        [cell.checkBtn setTag:10000+indexPath.row];
        [cell.checkBtn addTarget:self action:@selector(actbtnTwo:) forControlEvents:UIControlEventTouchUpInside];
        if ([_rightBtnSratusArr[indexNum][indexPath.row]isEqualToString:@"1"]) {
            cell.checkBtn.selected = YES;
        }else{
            cell.checkBtn.selected = NO;
        }
       
        return cell;

    }else{
        return nil;
    
    }
}

-(void)actbtn:(UIButton*)but{
    but.selected = !but.selected;
    _btnStatusArr[but.tag -1000] = [NSString stringWithFormat:@"%d",but.selected];
    NSMutableArray *a = [_rightBtnSratusArr[but.tag-1000] mutableCopy];

    //遍历左边  只保留一个选中状态
    for (int i = 0; i<_btnselectArr.count; i++) {
        if (i == but.tag-1000) {
    
           _btnselectArr[i] = @"1";
           //记录点的是哪个
            indexNum = i;
            
            //如果左边取消了，右边全取消
            if ([_btnStatusArr[i] isEqualToString:@"0"]) {
                for (int c = 0; c<a.count; c++) {
                    _rightBtnSratusArr[indexNum][c] = @"0";
                }
            }else{
                //如果左边是1，选中状态，右边就全选
                for (int b = 0; b<a.count; b++) {
                    _rightBtnSratusArr[indexNum][b] = @"1";
                }
            }
        }else{
          _btnselectArr[i] = @"0";
        }
    }
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];

}


-(void)actbtnTwo:(UIButton*)but{
    but.selected = !but.selected;
    int c = 0;

//    //选中的数组
   NSMutableArray *a = [_rightDataSource[indexNum] mutableCopy];
    a[but.tag-10000] = [NSString stringWithFormat:@"%d",but.selected];

    for (int i= 0; i< a.count; i++) {
        if (i == but.tag-10000) {
            if ([_rightBtnSratusArr[indexNum][i]isEqualToString:@"1"]) {
                _rightBtnSratusArr[indexNum][i] = @"0";
            }else{
                _rightBtnSratusArr[indexNum][i] = @"1";
    }
    }
        //如果右边有一个没选，左边就不打勾
        if (![_rightBtnSratusArr[indexNum][i]isEqualToString:@"1"]) {
            _btnStatusArr[indexNum] = @"0";
        }else{
            //如果右边全选了，左边打勾
            c++;
            if (c == a.count) {
                _btnStatusArr[indexNum] = @"1";
            }
        }
    }
   
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    GroupListModel *model = self.dataSource[indexPath.row];

    if (tableView == self.leftTableView) {
        for (int i = 0; i<_btnselectArr.count; i++) {
            if (i == indexPath.row) {
                _btnselectArr[i] = @"1";
            }else{
                _btnselectArr[i] = @"0";
            }
        }
        
        indexNum = indexPath.row;

        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    }else{
    }
}


- (IBAction)leftSeletAll:(id)sender {
        for (int i = 0; i<_btnStatusArr.count;i++) {
            _btnStatusArr[i] = @"1";
        }
    
    int a,b;
    
    //如果左边全选了，右边也全选
    for (a = 0 ; a<_rightBtnSratusArr.count; a++) {
        NSMutableArray *arr = _rightBtnSratusArr[a];
        for (b = 0; b <arr.count; b++) {
            arr[b] = @"1";
        }
    }
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    }

- (IBAction)leftReverse:(id)sender {
    
    for (int i = 0; i<_btnStatusArr.count;i++) {
        
        if ([_btnStatusArr[i]isEqualToString:@"0"]) {
            _btnStatusArr[i] =@"1";
        }else{
            _btnStatusArr[i] =@"0";
        }
        
        //控制右边 如果左边点了右边全选，反之，右边全部取消
        int a,b;
        for (a = 0 ; a<_btnStatusArr.count; a++) {
            NSMutableArray *arr = _rightBtnSratusArr[a];
            if ([_btnStatusArr[a]isEqualToString:@"1"]) {
                for (b = 0; b <arr.count; b++) {
                    arr[b] = @"1";
                }
            }else{
                for (b = 0; b <arr.count; b++) {
                    arr[b] = @"0";
                }
            }
        }
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    }
}


- (IBAction)rightSelectAll:(id)sender {
    NSMutableArray *a = [_rightDataSource[indexNum] mutableCopy];

    for (int i = 0; i<a.count;i++) {
        _rightBtnSratusArr[indexNum][i] = @"1";
    }
    _btnStatusArr[indexNum] = @"1";
    
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

- (IBAction)rightReaerse:(id)sender {
    int c = 0;
    NSMutableArray *a = [_rightDataSource[indexNum] mutableCopy];
    for (int i =0; i<a.count; i++) {
        if ([_rightBtnSratusArr[indexNum][i]isEqualToString:@"1"]) {
            _rightBtnSratusArr[indexNum][i] = @"0";
        }else{
            _rightBtnSratusArr[indexNum][i] = @"1";
        }
        
        
        //如果右边有一个没选，左边就不打勾
        if (![_rightBtnSratusArr[indexNum][i]isEqualToString:@"1"]) {
            _btnStatusArr[indexNum] = @"0";
        }else{
            //如果右边全选了，左边打勾
            c++;
            if (c == a.count) {
                _btnStatusArr[indexNum] = @"1";
            }
        }
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    
}

- (IBAction)sendData:(id)sender {
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i<_rightBtnSratusArr.count; i++) {
        NSArray *arr = _rightBtnSratusArr[i];
        for (int n = 0; n<arr.count; n++) {
            
            if ([arr[n]isEqualToString:@"1"]) {
        [data addObject:self.rightDataSource[i][n][@"ID"]];
            }
        }
    }
    NSArray *a  = [data mutableCopy];
    NSString *s = [a componentsJoinedByString:@","];
    
    NSString *sta;

    if (self.stateBtn.selected) {
        sta = @"1";
    }else{
    sta = @"0";
    }
    self.send(s,sta);
}




@end

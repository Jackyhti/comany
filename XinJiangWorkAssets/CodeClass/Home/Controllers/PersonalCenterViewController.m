//
//  PersonalCenterViewController.m
//  XinJiangWorkAssets
//
//  Created by 杨玉珍 on 17/6/7.
//  Copyright © 2017年 yyz. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalAvtorTableViewCell.h"
#import "PersonDataTableViewCell.h"
#import "ChangePassWordViewController.h"
#import "LoginViewController.h"

@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,PersonalAvtorTableViewCellDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UINavigationController *_imageNavigationController;
}
@property (strong, nonatomic) IBOutlet UITableView *personalTableView;


@property (nonatomic, retain)UIImagePickerController *imagePicker;


@property (nonatomic, retain)NSMutableArray *dataSource;

 - (void)hideKeyboard:(NSNotification *)noti;
 - (void)showKeyboard:(NSNotification *)noti;

@end

@implementation PersonalCenterViewController
{
    NSString *editType;
    NSArray *_dataArr;
    UITextField *_TF;
    UIBarButtonItem *_edit;
    NSMutableArray *_sourceArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _TF .delegate = self;
    self.title = @"个人中心";
    
  NSDictionary *dic = [[UserInfoManager shareGlobalSettingInstance] getUser][@"data"];
    
    _dataArr  =@[@"",dic[@"Name"],dic[@"PostName"],dic[@"DeptName"],dic[@"Tel"],dic[@"Phone"]];

    editType = @"0";
    self.dataSource = [@[@"",@"姓名",@"部门",@"岗位",@"办公",@"手机"] mutableCopy];
    [self configureTableView];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    
    [self setNav];
}


-(void)setNav{
    _edit = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:0 target:self action:@selector(editAct)];
    self.navigationItem.rightBarButtonItem = _edit;
}

-(void)editAct{
    
    if ([editType isEqualToString:@"0"]) {
        editType = @"1";
        _edit.title = @"保存";
    }else{
        _sourceArr = [NSMutableArray array];
        for (int i=1; i<6; i++) {
            UITextField *tf = [self.view viewWithTag:200+i];
            if ([tf.text isEqualToString:@""]) {
                [LToast showWithText:@"信息不能为空"];
            }else{
                [_sourceArr addObject:tf.text];}
    }
        
        [self changePerson];
    editType = @"0";
    _edit.title = @"编辑";
    }
    [self.personalTableView reloadData];

}

-(void)changePerson{
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    //    NSLog(@"%@",userDic);
    NSDictionary *dic = @{@"LeaderID":LeaderID,@"Name":_sourceArr[0],@"PostName":_sourceArr[1],@"DeptName":_sourceArr[2],@"Tel":_sourceArr[3],@"Phone":_sourceArr[4]};
        [[NetworkSingleton sharedManager] postDataToResult:dic url:kchangePerson successBlock:^(ModelRequestResult *responseBody) {
            if(responseBody.succWDJH) {
                [self hiddenLoadingMinView];
                [LToast showWithText:@"修改成功"];
 
                [_sourceArr insertObject:@"" atIndex:0];
                _dataArr = [_sourceArr mutableCopy];
                [self.personalTableView reloadData];
                NSNotification *not = [[NSNotification alloc]initWithName:@"change" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:not];
            }
        } failureBlock:^(ModelRequestResult *error) {
            [self hiddenLoadingMinView];
            [LToast showWithText:error.errorMsg];
        }];
}

- (void)textFieldBeginEditing:(NSNotification *)noti
{
    _TF = noti.object;
}


- (void)configureTableView {
    self.personalTableView.separatorInset = UIEdgeInsetsZero;
    self.personalTableView.layoutMargins = UIEdgeInsetsZero;
    [self.personalTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.personalTableView registerNib:[UINib nibWithNibName:@"PersonalAvtorTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersonalAvtorTableViewCell"];
    [self.personalTableView registerNib:[UINib nibWithNibName:@"PersonDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersonDataTableViewCell"];
    self.personalTableView.tableFooterView = [UIView new];
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taptab:)];
    tap.delegate = self;
    [_personalTableView addGestureRecognizer:tap];
}

-(void)taptab:(UITapGestureRecognizer*)tap{
    [self.personalTableView endEditing:YES];
}


#pragma mark TableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            PersonalAvtorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalAvtorTableViewCell" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
        else {
            
            PersonDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonDataTableViewCell" forIndexPath:indexPath];
            
            if (indexPath.row == 2 ||indexPath.row == 3) {
                cell.userInteractionEnabled = NO;
            }
            
            cell.nameLab.text = self.dataSource[indexPath.row];
            cell.infoLab.text = _dataArr[indexPath.row];
            
            if (indexPath.row == 5) {
                _TF = cell.editTF;
            }
            
            cell.editTF.text = _dataArr[indexPath.row];
            cell.editTF.tag = 200+indexPath.row;

            if ([editType isEqualToString:@"0"]) {
                cell.editTF.hidden = YES;
                cell.infoLab.hidden = NO;
            }else{
                cell.infoLab.hidden = YES;
                cell.editTF.hidden = NO;
            }
            
            return cell;
        }
    }else {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.text = @"修改密码";
            cell.textLabel.alpha = 0.8;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.text = @"注销当前账户";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.alpha = 0.8;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return self.dataSource.count;
    }else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            return 90;
        }else {
            return 60;
        }
    }else {
        return 60;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kscreen_width, 0)];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 8;
    }else {
        return 10;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        if (indexPath.row==0) {
            ChangePassWordViewController *psdVC = [[ChangePassWordViewController alloc] init];
            psdVC.title = @"修改密码";
            [self.navigationController pushViewController:psdVC animated:YES];
        }else{
            LoginViewController *login = [[LoginViewController alloc]init];
            self.view.window.rootViewController = login;
        }
    }
}

#pragma mark - AvtorCellDelegate
//头像点击事件
- (void)avtorClickAction {
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从本地图库选取", nil];
    [myActionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==actionSheet.cancelButtonIndex) {
        //            CLog(@"取消");
    }
    switch (buttonIndex) {
            case 0:////打开照相机拍照
            [self takePhoto];
            break;
            
            case 1:////打开本地相册
            [self LocalPhoto];
            break;
    }
}

////自定义打开照相机
-(void)takePhoto
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted)
        {
            [[[UIAlertView alloc] initWithTitle:nil message:@"本应用无访问相机的权限，如需访问，可在设置中修改" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
            return;
        }
    }else{
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
        {
            [[[UIAlertView alloc] initWithTitle:nil message:@"本应用无访问相机的权限，如需访问，可在设置中修改" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
            return;
        }
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
}
///打开本地图库
-(void)LocalPhoto{
    
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"本应用无访问相册的权限，如需访问，可在设置中修改" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertview show];
    }else if(authStatus ==AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"Granted access to %@", mediaType);
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
                    
                    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:self.imagePicker animated:YES completion:nil];
                }else{
                    NSLog(@"模拟器中无法使用照相机，请在真机中使用");
                }
            }
            else {
                NSLog(@"Not granted access to %@", mediaType);
            }
        }];
        
    }else if(authStatus ==AVAuthorizationStatusAuthorized) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
            
        }else{
            NSLog(@"模拟器中无法使用照相机，请在真机中使用");
        }
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
    _imageNavigationController = nil;
}

////把选中的图片放到这里
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        NSLog(@"-------------a-------------");
        UIImage *originImage=[info objectForKey:@"UIImagePickerControllerEditedImage"];
        if (originImage == nil) {
            originImage = info[UIImagePickerControllerOriginalImage];
        }
        //图片压缩，因为原图都是很大的，不必要传原图
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        NSData *imgData = UIImageJPEGRepresentation(scaleImage, 0.001);
        
        NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
        NSString *uid = userDic[@"ID"];
//        [self showLoadingSVP];
        
        NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *filePath = [docDir stringByAppendingPathComponent:@"headImg.png"];
        
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        [self changeHeader:imgData];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)changeHeader:(NSData*)data{
    [self showLoadingMinView];
    NSDictionary *userDic = [[UserInfoManager shareGlobalSettingInstance] getUserInfo];
    NSString *LeaderID = [NSString stringWithFormat:@"%@",userDic[@"data"][@"LeaderID"]];
    //    NSLog(@"%@",userDic);
    NSDictionary *dic = @{@"LeaderID":LeaderID};
//    [[NetworkSingleton sharedManager] postDataToResult:dic url:kAddHeadImg successBlock:^(ModelRequestResult *responseBody) {
//        if(responseBody.succWDJH) {
//            [self hiddenLoadingMinView];
//        }
//    } failureBlock:^(ModelRequestResult *error) {
//        [self hiddenLoadingMinView];
//        [LToast showWithText:error.errorMsg];
//    }];
    
    [[NetworkSingleton sharedManager] uploadPic:dic url:kAddHeadImg  fileData:data successBlock:^(ModelRequestResult *responseBody) {
        [self hiddenLoadingMinView];
        [self showLoadingSVP];
            NSNotification *not = [[NSNotification alloc]initWithName:@"header" object:self userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:not];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hiddenLoadingSVP];
            [LToast showWithText:@"更改成功"];
        });
        
    } faileureBlock:^(ModelRequestResult *error) {
        NSLog(@"%@",error.msgWDJH);
        [self hiddenLoadingMinView];
    }];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    _imageNavigationController = navigationController;
    if (viewController.navigationItem.leftBarButtonItem == nil && [navigationController.viewControllers count] > 1) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 2, 60, 40);
        //    backBtn.backgroundColor = separaterColor;
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
        
        [backBtn setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];

        viewController.navigationItem.leftBarButtonItem = backItem;
    }
}

- (void)LeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)backItemAction:(UIButton *)btn
{
    [_imageNavigationController popViewControllerAnimated:YES];
    _imageNavigationController = nil;
}



- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
 //       _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置image picker的来源，这里设置为摄像头
 //       _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//设置使用哪个摄像头，这里设置为后置摄像头
  //      _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        _imagePicker.allowsEditing=YES;//允许编辑
        _imagePicker.delegate=self;//设置代理，检测操作
    }
    return _imagePicker;
}

#pragma mark - 键盘躲避

- (void)showKeyboard:(NSNotification *)noti
{
    self.view.transform = CGAffineTransformIdentity;
    UIView *editView =  _TF;
    
    CGRect tfRect = [editView.superview convertRect:editView.frame toView:self.view];
    NSValue *value = noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
//    NSLog(@"%@", value);
    CGRect keyBoardF = [value CGRectValue];
    
    CGFloat animationTime = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGFloat _editMaxY = CGRectGetMaxY(tfRect);
    CGFloat _keyBoardMinY = CGRectGetMinY(keyBoardF);
//    NSLog(@"%f %f", _editMaxY, _keyBoardMinY);
    if (_keyBoardMinY < _editMaxY +64) {
        CGFloat moveDistance = _editMaxY+64 - _keyBoardMinY;
        [UIView animateWithDuration:animationTime animations:^{
            self.personalTableView.transform = CGAffineTransformTranslate(self.view.transform, 0, -moveDistance);
        }];
    }
}

- (void)hideKeyboard:(NSNotification *)noti
{
    //    NSLog(@"%@", noti);
    self.personalTableView.transform = CGAffineTransformIdentity;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    [self.personalTableView endEditing:YES];
    return NO;
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

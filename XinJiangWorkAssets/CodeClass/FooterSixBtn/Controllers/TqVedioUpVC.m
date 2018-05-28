//
//  TqVedioUpVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/24.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "TqVedioUpVC.h"
#import "UITextView+Placeholder.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface TqVedioUpVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIImageView *addPhoto;
@property (strong ,nonatomic)AVPlayer *player;//播放器，用于录制完视频后播放视频

@end

@implementation TqVedioUpVC
{
    UIImagePickerController *_imagePickerController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
//    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    [self setUI];
}


-(void)setUI{
    self.title = @"报告新特情";
    self.myTextView.placeholder = @"填写新特情";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ac)];
    [self.view addGestureRecognizer:tap];
    
    self.addPhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapPho = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAc)];
    [self.addPhoto addGestureRecognizer:tapPho];
    
}

-(void)addAc{
    UIAlertController *ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"来源选择" preferredStyle:1];
    UIAlertAction *A = [UIAlertAction actionWithTitle:@"相册" style:0 handler:^(UIAlertAction * _Nonnull action) {
                [self selectImageFromAlbum];
    }];
    UIAlertAction *B = [UIAlertAction actionWithTitle:@"录制" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];
    
    UIAlertAction *D = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ale addAction:A];
    [ale addAction:B];
    [ale addAction:D];
    [self presentViewController:ale animated:YES completion:nil];

}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];// 类型录制视频
    _imagePickerController.videoMaximumDuration = 30;

    [self presentViewController:_imagePickerController animated:YES completion:nil];
}


#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    _imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        self.addPhoto.image = info[UIImagePickerControllerEditedImage];
        //压缩图片
        NSData *fileData = UIImageJPEGRepresentation(self.addPhoto.image, 1.0);
        //保存图片至相册
        UIImageWriteToSavedPhotosAlbum(self.addPhoto.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //上传图片
        //        [self uploadImageWithData:fileData];
        
    }else{
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        //播放视频
        //        _moviePlayer.contentURL = url;
        //        [_moviePlayer play];
        //保存视频至相册（异步线程）
        NSString *urlStr = [url path];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
                
                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        });
        NSData *videoData = [NSData dataWithContentsOfURL:url];
        //视频上传
        //        [self uploadVideoWithData:videoData];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        [self.addPhoto.layer removeAllAnimations];
        //录制完之后自动播放LayerplayerLayerWithPlayer
        NSURL *url=[NSURL fileURLWithPath:videoPath];
        _player=[AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        [self.addPhoto.layer addSublayer:playerLayer];
        playerLayer.frame= CGRectMake(0, 0, 80, 80);
        playerLayer.backgroundColor = [UIColor grayColor].CGColor;
        [_player play];
        
    }
}

-(void)ac{
    [self.myTextView resignFirstResponder];
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

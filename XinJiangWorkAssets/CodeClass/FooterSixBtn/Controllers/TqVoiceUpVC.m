//
//  TqVoiceUpVC.m
//  XinJiangWorkAssets
//
//  Created by 成龙 on 2018/5/24.
//  Copyright © 2018年 yyz. All rights reserved.
//

#import "TqVoiceUpVC.h"
#import "UITextView+Placeholder.h"
#import <AVFoundation/AVFoundation.h>
@interface TqVoiceUpVC ()
@property (nonatomic, strong) AVAudioSession *session;


@property (nonatomic, strong) AVAudioRecorder *recorder;//录音器

@property (nonatomic, strong) AVAudioPlayer *player; //播放器
@property (nonatomic, strong) NSURL *recordFileUrl; //文件地址
@end

@implementation TqVoiceUpVC
{
    dispatch_source_t _timer;
    int _time;
    NSString *filePath;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"报告新特情";
    [self setUI];
}

-(void)setUI{
    _myTextView.placeholder = @"填写新特情";
    
    _soundBtn.hidden = YES;
    _TLabel.hidden = YES;
    
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 20)];
    //    [right setImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
    right.backgroundColor = [UIColor blueColor];
    [right setTitle:@"提交" forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ac)];
    [self.view addGestureRecognizer:tap];
    
    _startBtn.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *btnlong = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(btnLong:)];
    btnlong.minimumPressDuration =0.1;
    [self.startBtn addGestureRecognizer:btnlong];
    
}

-(void)btnLong:(UILongPressGestureRecognizer*)ges{
    
    if ([ges state] == UIGestureRecognizerStateBegan) {
        _TLabel.hidden = YES;
        [self countDown];
        self.startBtn.text = @"松开结束";
        AVAudioSession *session =[AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if (session == nil) {
            
            NSLog(@"Error creating session: %@",[sessionError description]);
            
        }else{
            [session setActive:YES error:nil];
            
        }
        
        self.session = session;
        
        
        //1.获取沙盒地址
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        filePath = [path stringByAppendingString:@"/RRecord.wav"];
        
        //2.获取文件路径
        self.recordFileUrl = [NSURL fileURLWithPath:filePath];
        
        //设置参数
        NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                       [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                       // 音频格式
                                       [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                       //采样位数  8、16、24、32 默认为16
                                       [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                       // 音频通道数 1 或 2
                                       [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                       //录音质量
                                       [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                       nil];
        
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
        
        if (_recorder) {
            
            _recorder.meteringEnabled = YES;
            [_recorder prepareToRecord];
            [_recorder record];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.recorder stop];
            });
        }else{
            NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
        }
    }else if ([ges state] == UIGestureRecognizerStateEnded){
        self.startBtn.text = @"重新录音";

        dispatch_source_cancel(_timer);
        _soundBtn.hidden = NO;
        _TLabel.hidden = NO;
        
        if ([self.recorder isRecording]) {
            [self.recorder stop];
        }
        
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:filePath]){
            
//            _TLabel.text = [NSString stringWithFormat:@"文件大小为 %.2fKb",[[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0];
            
        }else{
//            _noticeLabel.text = @"最多录60秒";
            
        }
    }
}

-(void)ac{
    [self.myTextView resignFirstResponder];
}

- (IBAction)soundAction:(id)sender {
    [self.recorder stop];
    
    if ([self.player isPlaying])return;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
    
    NSLog(@"%li",self.player.data.length/1024);
    
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
    
    
    NSArray *birdImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"v_anim1"],
                               [UIImage imageNamed:@"v_anim2"],
                               [UIImage imageNamed:@"v_anim3"],
                               nil];
    self.anim.animationImages = birdImageArray;
    self.anim.animationDuration = 0.7;//执行一次
    self.anim.animationRepeatCount = 0 ;//无限重复
    [self.anim startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.anim stopAnimating];
    });
    
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.player stop];
}

- (void)countDown {
    __block int timeout = 60;
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{ //计时器事件处理器
//        NSLog(@"Event Handler");
        if (timeout <= 0) {
            dispatch_source_cancel(_timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
            dispatch_async(mainQueue, ^{
                _timeLabel.text = @"01:00";
            });
        } else {
            timeout--;
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            dispatch_async(mainQueue, ^{
                _timeLabel.text = [NSString stringWithFormat:@"%d:%.2d",minutes,seconds];
                _TLabel.text = [NSString stringWithFormat:@"%d''",60-seconds];
                _time = 59-seconds;
            });
        }
    });
    dispatch_source_set_cancel_handler(_timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
//        NSLog(@"Cancel Handler");
    });
    dispatch_resume(_timer);  //恢复定时循环计时器；Dispatch Source 创建完后默认状态是挂起的，需要主动恢复，否则事件不会被传递，也不会被执行
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

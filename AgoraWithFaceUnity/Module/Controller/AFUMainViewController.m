//
//  AFUMainViewController.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/25.
//

#import "AFUMainViewController.h"

#import "AFUBottomSegmentView.h"
#import "AFURecognitionView.h"
#import "AFUSkinBeautyView.h"
#import "AFUFaceBeautyView.h"
#import "AFUFiltersView.h"
#import "AFUStickersView.h"
#import "AFUPortraitSegmentationView.h"
#import "FUSwitch.h"
#import "AFUInsetsLabel.h"

#import "AFUSegment.h"
#import "AFUPortraitSegmentationItem.h"
#import "AFUBeautyItem.h"
#import "AFUFilterItem.h"

#import <CoreMotion/CoreMotion.h>
#import <AgoraRtcKit/AgoraRtcKit.h>
#import <FaceUnityExtension/FUVideoFilterManager.h>
#import <YYModel.h>

static NSString * const kAFUAgoraRtcEngineAppID = @"fda6a89b2857451f8d3479a2fda2fbdf";

@interface AFUMainViewController ()<AFUBottomSegmentViewDelegate, AFURecognitionViewDelegate,  AFUSkinBeautyViewDelegate, AFUFaceBeautyViewDelegate, AFUFiltersViewDelegate, AFUStickersViewDelegate, AFUPortraitSegmentationViewDelegate, AgoraMediaFilterEventDelegate, AgoraRtcEngineDelegate>

@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) UIView *topTaskView;
/// 视频信息显示/隐藏
@property (nonatomic, strong) UIButton *buglyButton;
/// 切换前后摄像头按钮
@property (nonatomic, strong) UIButton *switchCameraButton;
/// 人体检测全身/半身开关
@property (nonatomic, strong) FUSwitch *bodySwitch;
/// 视频信息
@property (nonatomic, strong) AFUInsetsLabel *tipLabel;
/// 检测与识别信息
@property (nonatomic, strong) AFUInsetsLabel *recognitionTipLabel;
/// 未识别人体提示
@property (nonatomic, strong) UILabel *noBodyTipLabel;

@property (nonatomic, strong) AFUBottomSegmentView *segmentView;
@property (nonatomic, strong) AFURecognitionView *recognitionView;
@property (nonatomic, strong) AFUSkinBeautyView *skinBeautyView;
@property (nonatomic, strong) AFUFaceBeautyView *faceBeautyView;
@property (nonatomic, strong) AFUFiltersView *filterView;
@property (nonatomic, strong) AFUStickersView *stickerView;
@property (nonatomic, strong) AFUPortraitSegmentationView *portraitSegmentationView;

@property (nonatomic, strong) AgoraRtcEngineKit *agoraEngineKit;

@property (nonatomic, copy) NSArray<AFUSegment *> *segmentsArray;
@property (nonatomic, copy) NSArray<AFUPortraitSegmentationItem *> *portraitSegmentationItems;
@property (nonatomic, copy) NSArray<AFUBeautyItem *> *skinBeautyItems;
@property (nonatomic, copy) NSArray<AFUBeautyItem *> *faceBeautyItems;
@property (nonatomic, copy) NSArray<AFUFilterItem *> *filtersItems;

@property (nonatomic, strong) CMMotionManager *motionManager;
/// 当前屏幕方向
@property (nonatomic, assign) int orientation;
/// 是否前置摄像头
@property (nonatomic, assign) BOOL isFrontCamera;

@end

@implementation AFUMainViewController

#error - 请先在AgoraWithFaceUnity/Resources/authpack.json文件中设置正式证书，然后注释掉或删除此错误警告

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorFromHex:0x050F14 alpha:0.74];
    
    // 从plist文件中获取数据
    NSString *segmentsPath = [[NSBundle mainBundle] pathForResource:@"Segments" ofType:@"plist"];
    NSArray *segmentArray = [NSArray arrayWithContentsOfFile:segmentsPath];
    // 所有数据
    self.segmentsArray = [NSArray yy_modelArrayWithClass:[AFUSegment class] json:segmentArray];
    // 检测与识别数据
    self.portraitSegmentationItems = [NSArray yy_modelArrayWithClass:[AFUPortraitSegmentationItem class] json:self.segmentsArray[AFUSegmentTypeCheckAndDistinguish].items];
    // 美肤数据
    self.skinBeautyItems = [NSArray yy_modelArrayWithClass:[AFUBeautyItem class] json:self.segmentsArray[AFUSegmentTypeSkinBeauty].items];
    // 美型数据
    self.faceBeautyItems = [NSArray yy_modelArrayWithClass:[AFUBeautyItem class] json:self.segmentsArray[AFUSegmentTypeFaceBeauty].items];
    // 滤镜数据
    self.filtersItems = [NSArray yy_modelArrayWithClass:[AFUFilterItem class] json:self.segmentsArray[AFUSegmentTypeFilter].items];
    
    // 默认前置摄像头
    _isFrontCamera = YES;
    
    [self.view addSubview:self.videoView];
    [self.view addSubview:self.topTaskView];
    
    [self initializeAgora];
    [self setupVideo];
    
    [self configureUI];
}

#pragma mark - UI
- (void)configureUI {
    [self.view addSubview:self.segmentView];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.height.mas_offset(AFUDeviceIsiPhoneXStyle ? 83 : 49);
    }];
    
    [self.view addSubview:self.bodySwitch];
    [self.bodySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).mas_offset(16);
        make.bottom.equalTo(self.segmentView.mas_top).mas_offset(-150);
        make.size.mas_offset(CGSizeMake(70, 32));
    }];
    
    [self.view addSubview:self.recognitionView];
    [self.recognitionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.segmentView.mas_top);
        make.height.mas_offset(98);
    }];
    
    [self.view addSubview:self.skinBeautyView];
    [self.skinBeautyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.segmentView.mas_top);
        make.height.mas_offset(134);
    }];
    
    [self.view addSubview:self.faceBeautyView];
    [self.faceBeautyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.segmentView.mas_top);
        make.height.mas_offset(134);
    }];
    
    [self.view addSubview:self.filterView];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.segmentView.mas_top);
        make.height.mas_offset(144);
    }];
    
    [self.view addSubview:self.stickerView];
    [self.stickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.segmentView.mas_top);
        make.height.mas_offset(95);
    }];
    
    [self.view addSubview:self.portraitSegmentationView];
    [self.portraitSegmentationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.segmentView.mas_top);
        make.height.mas_offset(95);
    }];
    
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).mas_offset(16);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(60);
        } else {
            make.top.equalTo(self.view.mas_top).mas_offset(60);
        }
    }];
    
    [self.view addSubview:self.recognitionTipLabel];
    [self.recognitionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).mas_offset(16);
        make.top.equalTo(self.tipLabel.mas_top);
    }];
    
    [self.view addSubview:self.noBodyTipLabel];
    [self.noBodyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}


#pragma mark - Initializer
- (void)initializeAgora {
    AgoraRtcEngineConfig *config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = kAFUAgoraRtcEngineAppID;
    
    FUVideoFilterManager *provider = [FUVideoFilterManager sharedInstance];
    [provider loadPlugin];
    
    FUVideoExtensionObject *extensionObject = [provider mediaFilterExtension];
    config.mediaFilterExtensions = @[extensionObject];
    
    // 注册视频信息、人脸检测、人体检测、表情识别、手势识别代理
    config.eventDelegate = self;
    
    self.agoraEngineKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
}

- (void)setupVideo {
    [self.agoraEngineKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraEngineKit enableVideo];
    
    // 视频参数配置初始化
    AgoraVideoEncoderConfiguration *config = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:(NSInteger)CGRectGetWidth(self.videoView.frame)
                                                                                            height:(NSInteger)CGRectGetHeight(self.videoView.frame)
                                                                                         frameRate:AgoraVideoFrameRateFps30
                                                                                           bitrate:AgoraVideoBitrateStandard
                                                                                   orientationMode:AgoraVideoOutputOrientationModeAdaptative
                                                                                        mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraEngineKit setVideoEncoderConfiguration:config];
    
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    // 设置视频视图为自定义视图
    videoCanvas.view = self.videoView;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraEngineKit setupLocalVideo:videoCanvas];
    
    // 显示视频
    if ([self.agoraEngineKit startPreview] == 0) {
        
        // 设置分辨率
        [AFUHelper setupParameters:@{@"screen" : @{@"width" : @(CGRectGetWidth(self.videoView.frame)), @"height" : @(CGRectGetHeight(self.videoView.frame))}}];
        
        // 设置默认美肤参数
        [self skinBeautyViewDidChangeValue];

        // 设置默认美型参数
        [self faceBeautyViewDidChangeValue];
        
        // 默认前置摄像头
        [AFUHelper setupParameters:@{@"setParam" : @{@"param" : @"is_front_camera", @"value" : @1}}];
        
        // 设备方向监测
        if (self.motionManager.deviceMotionAvailable) {
            [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                [self handleDeviceMotion:motion];
            }];
        }
    }
}

#pragma mark - Private methods
- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion {
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    int orientation = 0;
    if (fabs(y) >= fabs(x)) {// 竖屏
        if (y < 0) {
            orientation = 0;
        }
        else {
            orientation = 2;
        }
    }
    else { // 横屏
        if (x < 0) {
           orientation = 1;
        }
        else {
           orientation = 3;
        }
    }
    if (orientation != _orientation) {
        _orientation = orientation;
        NSInteger value = _orientation;
        NSLog(@"orientation:%d", (_orientation));
        if (_isFrontCamera) {
            // 前置摄像头横屏两个方向参数相反
            if (value == 3) {
                value = 1;
            } else if (value == 1) {
                value = 3;
            }
        }
        NSDictionary *params = @{@"setParam" : @{@"param" : @"rotationMode", @"value" : @(value)}};
        [AFUHelper setupParameters:params];
    }
    
}

#pragma mark - Event response
- (void)bodySwitchChanged:(FUSwitch *)bodySwitch {
    [AFUHelper setupParameters:@{@"BodyDetection" : bodySwitch.isOn ? @1 : @0}];
}

- (void)buglyAction {
    if (self.buglyButton.isSelected) {
        self.buglyButton.selected = NO;
        self.tipLabel.hidden = YES;
        [self.recognitionTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view.mas_leading).mas_offset(16);
            make.top.equalTo(self.tipLabel.mas_top);
        }];
    } else {
        self.buglyButton.selected = YES;
        self.tipLabel.hidden = NO;
        [self.recognitionTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view.mas_leading).mas_offset(16);
            make.top.equalTo(self.tipLabel.mas_bottom).mas_offset(5);
        }];
    }
}

/// 前/后置摄像头切换
- (void)switchCameraAction {
    if ([self.agoraEngineKit switchCamera] == 0) {
        _isFrontCamera = !_isFrontCamera;
        [AFUHelper setupParameters:@{@"setParam" : @{@"param" : @"is_front_camera", @"value" : _isFrontCamera ? @1: @0}}];
    }
}

#pragma mark - AFUBottomSegmentViewDelegate
- (void)segmentViewDidSelectSegmentAtIndex:(NSInteger)index {
    switch (index) {
        case AFUSegmentTypeCheckAndDistinguish: {
            self.recognitionView.hidden = NO;
            self.skinBeautyView.hidden = YES;
            self.faceBeautyView.hidden = YES;
            self.filterView.hidden = YES;
            self.stickerView.hidden = YES;
            self.portraitSegmentationView.hidden = YES;
        }
            break;
        case AFUSegmentTypeSkinBeauty: {
            self.recognitionView.hidden = YES;
            self.skinBeautyView.hidden = NO;
            self.faceBeautyView.hidden = YES;
            self.filterView.hidden = YES;
            self.stickerView.hidden = YES;
            self.portraitSegmentationView.hidden = YES;
        }
            break;
        case AFUSegmentTypeFaceBeauty: {
            self.recognitionView.hidden = YES;
            self.skinBeautyView.hidden = YES;
            self.faceBeautyView.hidden = NO;
            self.filterView.hidden = YES;
            self.stickerView.hidden = YES;
            self.portraitSegmentationView.hidden = YES;
        }
            break;
        case AFUSegmentTypeFilter: {
            self.recognitionView.hidden = YES;
            self.skinBeautyView.hidden = YES;
            self.faceBeautyView.hidden = YES;
            self.filterView.hidden = NO;
            self.stickerView.hidden = YES;
            self.portraitSegmentationView.hidden = YES;
        }
            break;
            
        case AFUSegmentTypeSticker: {
            self.recognitionView.hidden = YES;
            self.skinBeautyView.hidden = YES;
            self.faceBeautyView.hidden = YES;
            self.filterView.hidden = YES;
            self.stickerView.hidden = NO;
            self.portraitSegmentationView.hidden = YES;
        }
            
            break;
        case AFUSegmentTypePortraitSegmentation: {
            self.recognitionView.hidden = YES;
            self.skinBeautyView.hidden = YES;
            self.faceBeautyView.hidden = YES;
            self.filterView.hidden = YES;
            self.stickerView.hidden = YES;
            self.portraitSegmentationView.hidden = NO;
        }
            break;
    }
}

#pragma mark - AFURecognitionViewDelegate
- (void)recognitionView:(AFURecognitionView *)recognitionView didSelectAtIndex:(NSInteger)index isSelected:(BOOL)isSelected {
    switch (index) {
        case 0:
            [AFUHelper setupParameters:@{@"FaceDetection" : isSelected ? @0 : @(-1)}];
            break;
        case 1: {
            if (isSelected) {
                self.bodySwitch.hidden = NO;
                NSNumber *detection = self.bodySwitch.isOn ? @1 : @0;
                [AFUHelper setupParameters:@{@"BodyDetection" : detection}];
            } else {
                self.bodySwitch.hidden = YES;
                [AFUHelper setupParameters:@{@"BodyDetection" : @(-1)}];
            }
        }
            break;
        case 2: {
            [AFUHelper setupParameters:@{@"ExpressionRecognition" : isSelected ? @0 : @(-1)}];
            if (isSelected) {
                self.recognitionTipLabel.hidden = NO;
            } else {
                self.recognitionTipLabel.hidden = !self.portraitSegmentationItems[3].isSelected;
            }
            
        }
            break;
        case 3: {
            [AFUHelper setupParameters:@{@"GestureRecognition" : isSelected ? @0 : @(-1)}];
            if (isSelected) {
                self.recognitionTipLabel.hidden = NO;
            } else {
                self.recognitionTipLabel.hidden = !self.portraitSegmentationItems[2].isSelected;
            }
        }
            break;
    }
}

#pragma mark - AFUSkinBeautyViewDelegate
- (void)skinBeautyViewDidChangeValue {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (AFUBeautyItem *item in self.skinBeautyItems) {
        [params setObject:@(item.value) forKey:item.key];
    }
    [AFUHelper setupParameters:@{@"beautyface" : [params copy]}];
}
- (void)skinBeautyViewShouldRecoverEffects {
    // 所有值设置为默认
    for (AFUBeautyItem *item in self.skinBeautyItems) {
        item.value = item.defaultValue;
    }
    // 设置默认参数
    [self skinBeautyViewDidChangeValue];
}

#pragma mark - AFUFaceBeautyViewDelegate
- (void)faceBeautyViewDidChangeValue {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (AFUBeautyItem *item in self.faceBeautyItems) {
        [params setObject:@(item.value) forKey:item.key];
    }
    [AFUHelper setupParameters:@{@"beautyshape" : [params copy]}];
}
- (void)faceBeautyViewShouldRecoverEffects {
    // 所有值设置为默认
    for (AFUBeautyItem *item in self.faceBeautyItems) {
        item.value = item.defaultValue;
    }
    // 设置默认参数
    [self faceBeautyViewDidChangeValue];
}

#pragma mark - AFUFiltersViewDelegate
- (void)filterView:(AFUFiltersView *)filterView didSelectFilterAtIndex:(NSInteger)index {
    if (index == 0) {
        // 原图
        [AFUHelper setupParameters:@{@"filter" : @{@"type" : @0, @"level" : @0}}];
    } else {
        // 滤镜
        AFUFilterItem *item = self.filtersItems[index - 1];
        [AFUHelper setupParameters:@{@"filter" : @{@"type" : @(item.type), @"level" : @(item.value)}}];
    }
}

#pragma mark - AFUStickersViewDelegate
- (void)stickersView:(AFUStickersView *)stickersView didSelectStickerAtIndex:(NSInteger)index {
    [AFUHelper setupParameters:@{@"stickers" : @(index)}];
}

#pragma mark - AFUPortraitSegmentationViewDelegate
- (void)portraitSegmentationView:(AFUPortraitSegmentationView *)portraitSegmentationView didSelectAtIndex:(NSInteger)index {
    [AFUHelper setupParameters:@{@"PortraitSegmentation" : @(index)}];
}

#pragma mark - AgoraMediaFilterEventDelegate
- (void)onEvent:(NSString * _Nullable)vendor key:(NSString * _Nullable)key json_value:(NSString * _Nullable)json_value {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json_value dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    if (!self.tipLabel.hidden) {
        // 视频信息
        NSString *tipString = [NSString stringWithFormat:@"resolution:\n%@x%@\n\nfps:%@", dic[@"resolution"][@"width"], dic[@"resolution"][@"height"], @([dic[@"frame"] integerValue])];
        if (dic[@"yaw"]) {
            tipString = [tipString stringByAppendingString:[NSString stringWithFormat:@"\n\nyaw:%.2f°", [dic[@"yaw"] floatValue]]];
        }
        if (dic[@"pitch"]) {
            tipString = [tipString stringByAppendingString:[NSString stringWithFormat:@"\n\npitch:%.2f°", [dic[@"pitch"] floatValue]]];
        }
        if (dic[@"roll"]) {
            tipString = [tipString stringByAppendingString:[NSString stringWithFormat:@"\n\nroll:%.2f°", [dic[@"roll"] floatValue]]];
        }
        self.tipLabel.text = tipString;
    }
    if (!self.recognitionTipLabel.hidden) {
        // 检测识别信息
        NSString *recognitionString = @"";
        if (dic[@"expression_type"]) {
            recognitionString = [recognitionString stringByAppendingString:[NSString stringWithFormat:@"表情：%@", [AFUHelper expressionStringWithInt:[dic[@"expression_type"] integerValue]]]];
        }
        if (dic[@"gesture_type"]) {
            if (recognitionString.length > 0) {
                recognitionString = [recognitionString stringByAppendingString:@"\n\n"];
            }
            recognitionString = [recognitionString stringByAppendingString:[NSString stringWithFormat:@"手势：%@", [AFUHelper gestureStringWithInt:[dic[@"gesture_type"] integerValue]]]];
        }
        self.recognitionTipLabel.text = recognitionString;
    }
    
    // 未识别到人体提示
    if (dic[@"body_num"] && [dic[@"body_num"] integerValue] == 0) {
        // 人体检测开启，并且返回人体数量为0
        self.noBodyTipLabel.hidden = NO;
    } else {
        self.noBodyTipLabel.hidden = YES;
    }
    
}

#pragma mark - Getters
- (UIView *)videoView {
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (AFUDeviceIsiPhoneXStyle ? 83 : 49))];
    }
    return _videoView;
}
- (UIView *)topTaskView {
    if (!_topTaskView) {
        _topTaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 120)];
        UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 120)];
        topImageView.image = [UIImage imageNamed:@"demo_bg_top_mask"];
        [_topTaskView addSubview:topImageView];
        
        [_topTaskView addSubview:self.buglyButton];
        [self.buglyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_topTaskView.mas_leading).mas_offset(10);
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(_topTaskView.mas_safeAreaLayoutGuideTop).mas_offset(10);
            } else {
                make.top.equalTo(_topTaskView.mas_top).mas_offset(10);
            }
            make.size.mas_offset(CGSizeMake(40, 40));
        }];
        
        [_topTaskView addSubview:self.switchCameraButton];
        [self.switchCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(_topTaskView.mas_trailing).mas_offset(-10);
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(_topTaskView.mas_safeAreaLayoutGuideTop).mas_offset(10);
            } else {
                make.top.equalTo(_topTaskView.mas_top).mas_offset(10);
            }
            make.size.mas_offset(CGSizeMake(40, 40));
        }];
    }
    return _topTaskView;
}
- (UIButton *)buglyButton {
    if (!_buglyButton) {
        _buglyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buglyButton setImage:[UIImage imageNamed:@"bugly"] forState:UIControlStateNormal];
        [_buglyButton addTarget:self action:@selector(buglyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buglyButton;
}

- (UIButton *)switchCameraButton {
    if (!_switchCameraButton) {
        _switchCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchCameraButton setImage:[UIImage imageNamed:@"camera_btn_shotcut_normal"] forState:UIControlStateNormal];
        [_switchCameraButton addTarget:self action:@selector(switchCameraAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraButton;
}

- (AFUInsetsLabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[AFUInsetsLabel alloc] initWithFrame:CGRectZero insets:UIEdgeInsetsMake(8, 8, 8, 8)];
        _tipLabel.backgroundColor = [UIColor colorFromHex:0x050F14 alpha:0.5];
        _tipLabel.numberOfLines = 0;
        _tipLabel.layer.masksToBounds = YES;
        _tipLabel.layer.cornerRadius = 4;
        _tipLabel.font = [UIFont systemFontOfSize:11];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

- (AFUInsetsLabel *)recognitionTipLabel {
    if (!_recognitionTipLabel) {
        _recognitionTipLabel = [[AFUInsetsLabel alloc] initWithFrame:CGRectZero insets:UIEdgeInsetsMake(8, 8, 8, 8)];
        _recognitionTipLabel.backgroundColor = [UIColor colorFromHex:0x050F14 alpha:0.5];
        _recognitionTipLabel.numberOfLines = 0;
        _recognitionTipLabel.layer.masksToBounds = YES;
        _recognitionTipLabel.layer.cornerRadius = 4;
        _recognitionTipLabel.font = [UIFont systemFontOfSize:11];
        _recognitionTipLabel.textColor = [UIColor whiteColor];
        _recognitionTipLabel.hidden = YES;
    }
    return _recognitionTipLabel;
}

- (UILabel *)noBodyTipLabel {
    if (!_noBodyTipLabel) {
        _noBodyTipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _noBodyTipLabel.font = [UIFont systemFontOfSize:15];
        _noBodyTipLabel.textColor = [UIColor whiteColor];
        _noBodyTipLabel.hidden = YES;
        _noBodyTipLabel.text = @"未识别到人体";
    }
    return _noBodyTipLabel;
}

- (FUSwitch *)bodySwitch {
    if (!_bodySwitch) {
        _bodySwitch = [[FUSwitch alloc] initWithFrame:CGRectMake(0, 0, 70, 32) onColor:[UIColor colorFromHex:0x5EC7FE] offColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] ballSize:30];
        _bodySwitch.onText = @"全身";
        _bodySwitch.offText = @"半身";
        _bodySwitch.on = YES;
        _bodySwitch.offLabel.textColor = [UIColor colorFromHex:0x5EC7FE];
        _bodySwitch.hidden = YES;
        [_bodySwitch addTarget:self action:@selector(bodySwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _bodySwitch;
}
- (AFUBottomSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[AFUBottomSegmentView alloc] initWithSegments:self.segmentsArray];
        _segmentView.delegate = self;
    }
    return _segmentView;
}
- (AFURecognitionView *)recognitionView {
    if (!_recognitionView) {
        _recognitionView = [[AFURecognitionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 98) recognitions:self.portraitSegmentationItems];
        _recognitionView.delegate = self;
    }
    return _recognitionView;
}
- (AFUSkinBeautyView *)skinBeautyView {
    if (!_skinBeautyView) {
        _skinBeautyView = [[AFUSkinBeautyView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 134) items:self.skinBeautyItems];
        _skinBeautyView.delegate = self;
        _skinBeautyView.hidden = YES;
    }
    return _skinBeautyView;
}
- (AFUFaceBeautyView *)faceBeautyView {
    if (!_faceBeautyView) {
        _faceBeautyView = [[AFUFaceBeautyView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 134) items:self.faceBeautyItems];
        _faceBeautyView.delegate = self;
        _faceBeautyView.hidden = YES;
    }
    return _faceBeautyView;
}
- (AFUFiltersView *)filterView {
    if (!_filterView) {
        _filterView = [[AFUFiltersView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 144) filters:self.filtersItems];
        _filterView.delegate = self;
        _filterView.hidden = YES;
    }
    return _filterView;
}
- (AFUStickersView *)stickerView {
    if (!_stickerView) {
        _stickerView = [[AFUStickersView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 95) stickers:self.segmentsArray[AFUSegmentTypeSticker].items];
        _stickerView.delegate = self;
        _stickerView.hidden = YES;
    }
    return _stickerView;
}
- (AFUPortraitSegmentationView *)portraitSegmentationView {
    if (!_portraitSegmentationView) {
        _portraitSegmentationView = [[AFUPortraitSegmentationView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 95) items:self.segmentsArray[AFUSegmentTypePortraitSegmentation].items];
        _portraitSegmentationView.delegate = self;
        _portraitSegmentationView.hidden = YES;
    }
    return _portraitSegmentationView;
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 0.3;
    }
    return _motionManager;
}

@end

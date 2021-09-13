# 初始化 FaceUnity Plugin

### 初始化

```objective-c
AgoraRtcEngineConfig *config = [[AgoraRtcEngineConfig alloc] init];
config.appId = kAFUAgoraRtcEngineAppID;
    
FUVideoFilterManager *provider = [FUVideoFilterManager sharedInstance];
[provider loadPlugin];

FUVideoExtensionObject *extensionObject = [provider mediaFilterExtension];
config.mediaFilterExtensions = @[extensionObject];

// 注册视频信息、人脸检测、人体检测、表情识别、手势识别代理(AgoraMediaFilterEventDelegate)
config.eventDelegate = self;

self.agoraEngineKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];


#pragma mark - AgoraMediaFilterEventDelegate (self需要实现代理方法)
- (void)onEvent:(NSString * _Nullable)vendor key:(NSString * _Nullable)key json_value:(NSString * _Nullable)json_value {}
```

### AgoraMediaFilterEventDelegate回调参数说明

```json
// 每次渲染都会回调参数
"resolution":{ 		//分辨率
    "width":1920,
    "height":1080
}
"frame":30	 		//帧率

// 其他参数
"hand_num":1		//屏幕中手的数量 如果开启手势识别会返回

"gesture_type":0	//如果开启手势识别会返回

"face_num":1		//屏幕中人脸数量 如果开启表情识别或者表情识别或者人脸检测会返回

"expression_type":0	//表情 如果开启表情识别会返回

"roll":0.00°		//如果开启人脸检测别会返回

"pitch":0.00°		//如果开启人脸检测别会返回

"yaw":0.00°			//如果开启人脸检测别会返回

"body_num":1		//屏幕中人体数量 如果开启人体检测会返回
```



# 配置视频参数并显示视频

```objective-c
[self.agoraEngineKit setClientRole:AgoraClientRoleBroadcaster];
[self.agoraEngineKit enableVideo];

// 视频参数配置初始化
AgoraVideoEncoderConfiguration *config = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:(NSInteger)CGRectGetWidth(self.videoView.frame)
                                                                                            height:(NSInteger)CGRectGetHeight(self.videoView.frame)
                                                                                         frameRate:AgoraVideoFrameRateFps15
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
if ([self.agoraEngineKit startPreview] == 0) {}
```



# 设置参数

### 调用工具类AFUHelper中的setupParameters()方法设置参数

```objective-c
[AFUHelper setupParameters:dictionary];

#pragma mark - AFUHelper setupParameters()方法
+ (void)setupParameters:(NSDictionary *)parameters {
    NSString *jsonString = [AFUUtility jsonStringOfObject:parameters];
    
    // 最终调用[[FUVideoFilterManager sharedInstance] setParameter:jsonString];
    [[FUVideoFilterManager sharedInstance] setParameter:jsonString];
}

#pragma mark - AFUUtility jsonStringOfObject()方法
+ (NSString *)jsonStringOfObject:(id)object {
    if (!object) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
```



### jsonString参数说明

```json
// 屏幕长宽  
"screen":{ 
 	"width":(float),
    "height":(float)
}

// bundle参数
"setParam":{ 
    "param":"rotationMode"(屏幕方向0-3)/"is_front_camera"(前后摄像头 1前置 0后置),
    "value":(int)
}

// 人脸检测
"FaceDetection":-1~0			//0:开启 -1:关闭

// 人体检测
"BodyDetection":-1~1			//0:半身关键点 1:全身关键点 -1:关闭

// 表情识别
"ExpressionRecognition":-1~0	//0:开启 -1:关闭

// 手势识别
"GestureRecognition":-1~0		//0:开启 -1:关闭

// 美肤
"beautyface":{  
   "skin":70, 		//磨皮
   "white":30,		//美白
   "red":30,		//红润
   "lighteye":0,	//亮眼
   "sharpen":70,	//锐化
   "teeth":0,		//美牙
   "blackeye":0,	//去黑眼圈
   "ade":0 			//去法令纹
}

// 美型
"beautyshape":{
    "thinface":40,			//瘦脸
    "bigeye":40,			//大眼
    "circleeye":0,			//圆眼
    "chin":30,				//下巴
    "forehead":30,			//额头
    "thinnose":50,			//瘦鼻
    "mouse":40,				//嘴型
    "vface":50,				//V脸
    "naface":0,				//窄脸
    "smallface":0,			//小脸
    "thincheekbone":0,		//瘦颧骨
    "thinmandible":0,		//瘦下颚骨
    "openeye":0,			//开眼角
    "eyedis":50,			//眼距
    "eyerid":50,			//眼睛角度
    "longnose":50,			//长鼻
    "shrinking":50,			//缩人中
    "smile":0				//微笑嘴角
}

// 滤镜
"filter":{
    "type":0~75,                //0表示取消滤镜 
    "level":0~100				//强度
}

// 贴纸
"stickers":-1~4					//0~4 5种不同的贴纸 -1 取消贴纸

// 人像分割
"PortraitSegmentation":-1~7		//0:男友1 1:男友2 2:男友3 3:古风 4:音乐 5:西瓜 6:海边 7:现代 -1:取消

```



# 原demo存在问题

1. 调用AgoraRtcEngineKit的switchCamera()切换前后摄像头时会出现左右镜像错乱问题
2. 设置贴纸等特殊效果后画面延迟卡顿比较严重

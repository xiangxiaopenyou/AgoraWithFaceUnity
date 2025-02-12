//
//  AgoraObjects.h
//  AgoraRtcEngineKit
//
//  Copyright (c) 2018 Agora. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import <Foundation/Foundation.h>
#import "AgoraEnumerates.h"
#import "AgoraMediaFilterExtensionDelegate.h"
#import "AgoraMediaFilterEventDelegate.h"
#import "AgoraRtcPrimitiveOptional.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
typedef UIView VIEW_CLASS;
typedef UIColor COLOR_CLASS;
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
typedef NSView VIEW_CLASS;
typedef NSColor COLOR_CLASS;
#endif

/**
 * The channel media options.
 */
__attribute__((visibility("default"))) @interface AgoraRtcChannelMediaOptions : NSObject
/**
 * Determines whether to publish the video of the camera track.
 * - `YES`: (Default) Publish the video track of the camera capturer.
 * - `NO`: Do not publish the video track of the camera capturer.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishCameraTrack;
/**
 * Determines whether to publish the video of the screen track.
 * - `YES`: Publish the video track of the screen capturer.
 * - `NO`: (Default) Do not publish the video track of the screen capturer.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishScreenTrack;
/**
 * Determines whether to publish the audio of the custom audio track.
 * - `YES`: Publish the audio of the custom audio track.
 * - `NO`: (Default) Do not publish the audio of the custom audio track.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishCustomAudioTrack;
/**
 * Determines whether to publish the video of the custom video track.
 * - `YES`: Publish the video of the custom video track.
 * - `NO`: (Default) Do not publish the video of the custom video track.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishCustomVideoTrack;
/**
 * Determines whether to publish the video of the encoded video track.
 * - `YES`: Publish the video of the encoded video track.
 * - `NO`: (Default) Do not publish the video of the encoded video track.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishEncodedVideoTrack;
/**
 * Determines whether to publish the audio track of media player.
 * - `YES`: Publish the audio track of media player.
 * - `NO`: (Default) Do not publish the audio track of media player.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishMediaPlayerAudioTrack;
/**
* Determines whether to publish the video track of media player source.
* - true: Publish the video track of media player source.
* - false: (default) Do not publish the video track of media player source.
*/
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishMediaPlayerVideoTrack;
/**
* Determines which media player source should be published.
* - DEFAULT_PLAYER_ID(0) is default.
*/
@property(strong, nonatomic) AgoraRtcIntOptional* _Nullable publishMediaPlayerId;
/**
 * Determines whether to publish the sampled audio.
 * - `YES`: (Default) Publish the sampled audio.
 * - `NO`: Do not publish the sampled audio.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable publishAudioTrack;
/**
 * Determines whether to subscribe to all audio streams automatically.
 * This property replaces calling {@link AgoraRtcEngineKit.setDefaultMuteAllRemoteAudioStreams: setDefaultMuteAllRemoteAudioStreams}
 * before joining a channel.
 * - `YES`: (Default) Subscribe to all audio streams automatically.
 * - `NO`: Do not subscribe to any audio stream automatically.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable autoSubscribeAudio;
/**
 * Determines whether to subscribe to all video streams automatically.
 * This property replaces calling {@link AgoraRtcEngineKit.setDefaultMuteAllRemoteVideoStreams: setDefaultMuteAllRemoteVideoStreams}
 * before joining a channel.
 * - `YES`: Subscribe to all video streams automatically.
 * - `NO`: (default) Do not subscribe to any video stream automatically.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable autoSubscribeVideo;
/**
 * Determines whether to subscribe to PCM audio data only. Note that it only takes effect 
 * when join channel, otherwise not when update channel media option.
 * - `YES`: Subscribe to PCM audio data only, which means that the remote audio stream
 * is not be played by the built-in playback device automatically. You can use this
 * mode to pull PCM data and handle playback.
 * - `NO`: (default) Do not subscribe to PCM audio only, which means that the remote audio stream
 * is played automatically.
 */
@property(strong, nonatomic) AgoraRtcBoolOptional* _Nullable enableAudioRecordingOrPlayout;
/**
 * The client role type: {@link AgoraClientRole}.
 */
@property(strong, nonatomic) AgoraRtcIntOptional* _Nullable clientRoleType;
/**
 * The default video stream type: {@link AgoraVideoStreamType}.
 */
@property(strong, nonatomic) AgoraRtcIntOptional* _Nullable defaultVideoStreamType;
/**
 * The channel profile: {@link AgoraChannelProfile}.
 */
@property(strong, nonatomic) AgoraRtcIntOptional* _Nullable channelProfile;
/**
 * The delay in ms for sending audio frames. This is used for explicit control of A/V sync.
 * To switch off the delay, set the value to zero.
 */
@property(strong, nonatomic) AgoraRtcIntOptional* _Nullable audioDelayMs;
/**
 * The connectionId, which supports a user to join the same channel with different connectionIds.
 * ConnectionId could be obtained by joinChannelEx series defined in AgoraRtcEngineKitEx.h
 */
@property(strong, nonatomic) AgoraRtcUIntOptional* _Nullable connectionId;

@end

/** Properties of the video canvas object.
 */
__attribute__((visibility("default"))) @interface AgoraRtcVideoCanvas : NSObject
/** The video display view. The SDK does not maintain the lifecycle of the view.

 The view can be safely released after calling [leaveChannel]([AgoraRtcEngineKit
 leaveChannel:]) with a returned value. The SDK keeps a cache of the view value, so calling
 [setupLocalVideo]([AgoraRtcEngineKit setupLocalVideo:]) to set the view value to nil can
 clear the cache before switching or releasing the view.
 */
@property(strong, nonatomic) VIEW_CLASS *_Nullable view;
/** Render mode of the view; hidden, fit, or adaptive.
 */
@property(assign, nonatomic) AgoraVideoRenderMode renderMode;
/** Mirror mode of the view; auto, enabled, or disabled.
 */
@property(assign, nonatomic) AgoraVideoMirrorMode mirrorMode;
/** User ID of the view.
 */
@property(assign, nonatomic) NSUInteger uid;
/** the string user id of view
 */
@property(copy, nonatomic) NSString *_Nullable userId;
/** the  sourceType of view
 */
@property(nonatomic, assign) AgoraVideoSourceType sourceType;
/** when sourceType == AgoraVideoSourceTypeMediaPlayer valid( sourceId == mediaPlayerId )
 */
@property(nonatomic, assign) int sourceId;

@end

/**
 * The configurations for the last-mile network probe test.
 */
__attribute__((visibility("default"))) @interface AgoraLastmileProbeConfig : NSObject
/**
 * Sets whether or not to test the uplink network.
 *
 * Some users, for example, the audience in a live-broadcast channel, do not need such a test.
 * - `YES`: Enables the test.
 * - `NO`: Disables the test.
 */
@property (assign, nonatomic) BOOL probeUplink;
/**
 * Sets whether or not to test the downlink network.
 * - `YES`: Enables the test.
 * - `NO`: Disables the test.
 */
@property (assign, nonatomic) BOOL probeDownlink;
/**
 * Sets the expected maximum sending bitrate (bps) of the local user.
 *
 * The value ranges between 100000 and 5000000. Agora recommends
 * setting this value according to the required bitrate of selected video profile.
 */
@property (assign, nonatomic) NSUInteger expectedUplinkBitrate;
/**
 * Sets the expected maximum receiving bitrate (bps) of the local user.
 * The value ranges between 100000 and 5000000.
 */
@property (assign, nonatomic) NSUInteger expectedDownlinkBitrate;
@end

/**
 * The one-way last-mile probe result.
 */
__attribute__((visibility("default"))) @interface AgoraLastmileProbeOneWayResult : NSObject
/**
 * The packet loss rate (%).
 */
@property (assign, nonatomic) NSUInteger packetLossRate;
/**
 * The network jitter (ms).
 */
@property (assign, nonatomic) NSUInteger jitter;
/**
 * The estimated available bandwidth (bps).
 */
@property (assign, nonatomic) NSUInteger availableBandwidth;
@end

/**
 * Statistics of the last-mile probe.
 */
__attribute__((visibility("default"))) @interface AgoraLastmileProbeResult : NSObject
/**
 * The state of the probe test.
 * See {@link AgoraLastmileProbeResultState}.
 */
@property (assign, nonatomic) AgoraLastmileProbeResultState state;
/**
 * The round-trip delay time (ms).
 */
@property (assign, nonatomic) NSUInteger rtt;
/**
 * The uplink last-mile network report.
 *
 * See {@link AgoraLastmileProbeOneWayResult}.
 */
@property (strong, nonatomic) AgoraLastmileProbeOneWayResult *_Nonnull uplinkReport;
/**
 * The downlink last-mile network report.
 *
 * See {@link AgoraLastmileProbeOneWayResult}.
 */
@property (strong, nonatomic) AgoraLastmileProbeOneWayResult *_Nonnull downlinkReport;
@end


/** Statistics of the local video stream.
 */
__attribute__((visibility("default"))) @interface AgoraRtcLocalVideoStats : NSObject
/** Sending bitrate since last count.
 */
@property(assign, nonatomic) NSUInteger sentBitrate;
/** Sending frame rate since last count.
 */
@property(assign, nonatomic) NSUInteger sentFrameRate;
/**
 * ID of the local user whose video is sent.
 */
@property(assign, nonatomic) NSUInteger uid;

/** The encoder output frame rate (fps) of the local video.
 */
@property(assign, nonatomic) NSInteger encoderOutputFrameRate;
/** The render output frame rate (fps) of the local video.
 */
@property(assign, nonatomic) NSInteger rendererOutputFrameRate;
/** The target frame rate (fps) of the current encoder.
  */
@property(assign, nonatomic) NSInteger targetFrameRate;
/**
 * The target bitrate (Kbps) of the current encoder. This value is estimated by the SDK based on the current network conditions.
 */
@property(assign, nonatomic) NSInteger targetBitrate;
/**
 * The encoding bitrate (Kbps) of the video.
 */
@property(assign, nonatomic) NSInteger encodedBitrate;
/**
 * The width of the encoding frame (px).
 */
@property(assign, nonatomic) NSInteger encodedFrameWidth;
/**
 * The height of the encoding frame (px).
 */
@property(assign, nonatomic) NSInteger encodedFrameHeight;
/**
 * The number of the sent frames, represented by an aggregate value.
 */
@property(assign, nonatomic) NSInteger encodedFrameCount;
/** 
* The packet loss rate (%) from the local client to Agora's edge server,
* before network countermeasures.
*/
@property(assign, nonatomic) NSInteger txPacketLossRate;
/** 
 * The capture Frame Rate (%) of the local camera
 */
@property(assign, nonatomic) NSInteger captureFrameRate;
/**
 * The codec type of the local video:
 * - VIDEO_CODEC_VP8 = 1: VP8.
 * - VIDEO_CODEC_H264 = 2: (Default) H.264.
 */
@property(assign, nonatomic) AgoraVideoCodecType codecType;

@end

/** Statistics of the remote video stream. */
__attribute__((visibility("default"))) @interface AgoraRtcRemoteVideoStats : NSObject
/** User ID of the user whose video streams are received.
 */
@property(assign, nonatomic) NSUInteger uid;
/** Time delay (ms).
 */
@property(assign, nonatomic) NSUInteger delay __deprecated;
/** Width (pixels) of the video stream.
 */
@property(assign, nonatomic) NSUInteger width;
/** Height (pixels) of the video stream.
 */
@property(assign, nonatomic) NSUInteger height;
/** Data receive bitrate (Kbps) since last count.
 */
@property(assign, nonatomic) NSUInteger receivedBitrate;
/** Data receive frame rate (fps) since last count.
 */
@property(assign, nonatomic) NSUInteger receivedFrameRate;
/** Video stream type; high- or low-video stream.
 */
@property(assign, nonatomic) AgoraVideoStreamType rxStreamType;

/** The decoder output frame rate (fps) of the remote video.
 */
@property(assign, nonatomic) NSInteger decoderOutputFrameRate;
/** The render output frame rate (fps) of the remote video.
 */
@property(assign, nonatomic) NSInteger rendererOutputFrameRate;
/** The video frame loss rate (%) of the remote video stream in the reported interval.
 */
@property(assign, nonatomic) NSInteger frameLossRate;
/** Packet loss rate (%) of the remote video stream after using the anti-packet-loss method.
 */
@property(assign, nonatomic) NSInteger packetLossRate;
/**
 The total freeze time (ms) of the remote video stream after the remote user joins the channel.
 In a video session where the frame rate is set to no less than 5 fps, video freeze occurs when
 the time interval between two adjacent renderable video frames is more than 500 ms.
 */
@property(assign, nonatomic) NSInteger totalFrozenTime;
/**
 The total video freeze time as a percentage (%) of the total time when the video is available.
 */
@property(assign, nonatomic) NSInteger frozenRate;
/**
 The offset (ms) between audio and video stream. A positive value indicates the audio leads the
 video, and a negative value indicates the audio lags the video.
 */
@property(assign, nonatomic) NSInteger avSyncTimeMs;

@end

/**
 * The statistics of the local audio.
 */
__attribute__((visibility("default"))) @interface AgoraRtcLocalAudioStats : NSObject
/**
 * The number of audio channels.
 */
@property(assign, nonatomic) NSUInteger numChannels;
/**
 * The sample rate (Hz).
 */
@property(assign, nonatomic) NSUInteger sentSampleRate;
/**
 * The average sending bitrate (Kbps).
 */
@property(assign, nonatomic) NSUInteger sentBitrate;
/** The internal payload type.
 */
@property(assign, nonatomic) NSUInteger internalCodec;

@end

/**
 * The statistics of the remote audio.
 */
__attribute__((visibility("default"))) @interface AgoraRtcRemoteAudioStats : NSObject
/**
 * ID of the user sending the audio stream.
 */
@property(assign, nonatomic) NSUInteger uid;
/**
 * The receiving audio quality.
 *
 * - 0: The quality is unknown.
 * - 1: The quality is excellent.
 * - 2: The quality is quite good, but the bitrate may be slightly
 * lower than excellent.
 * - 3: Users can feel the communication slightly impaired.
 * - 4: Users can communicate not very smoothly.
 * - 5: The quality is so bad that users can barely communicate.
 * - 6: The network is disconnected and users cannot communicate at all.
 */
@property(assign, nonatomic) NSUInteger quality;
/**
 * The network delay (ms) from the sender to the receiver.
 */
@property(assign, nonatomic) NSUInteger networkTransportDelay;
/**
 * The jitter buffer delay (ms) at the receiver.
 */
@property(assign, nonatomic) NSUInteger jitterBufferDelay;
/**
 * The packet loss rate in the reported interval.
 */
@property(assign, nonatomic) NSUInteger audioLossRate;
/**
 * The number of audio channels.
 */
@property(assign, nonatomic) NSUInteger numChannels;
/**
 * The sample rate (Hz) of the received audio stream, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger receivedSampleRate;
/**
 * The bitrate (Kbps) of the received audio stream, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger receivedBitrate;
/**
 * The total freeze time (ms) of the remote audio stream after the remote user joins the channel.
 * In a session, audio freeze occurs when the audio frame loss rate reaches 4% within two seconds.
 * Agora uses 2 seconds as an audio piece unit to calculate the audio freeze time.
 * The total audio freeze time = The audio freeze number &times; 2 seconds
 */
@property(assign, nonatomic) NSUInteger totalFrozenTime;
/**
 * The total audio freeze time as a percentage (%) of the total time when the audio is available.
 */
@property(assign, nonatomic) NSUInteger frozenRate;
@end

/** Properties of the audio volume information.
 */
__attribute__((visibility("default"))) @interface AgoraRtcAudioVolumeInfo : NSObject
/** User ID of the speaker.
 */
@property(assign, nonatomic) NSUInteger uid;
/** The volume of the speaker that ranges from 0 (lowest volume) to 255 (highest volume).
 */
@property(assign, nonatomic) NSUInteger volume;
@end

/**
 * The Statistics of the channel.
 */
__attribute__((visibility("default"))) @interface AgoraChannelStats : NSObject
/**
 * The call duration in seconds, represented by an aggregate value.
 */
@property(assign, nonatomic) NSUInteger duration;
/**
 * The total number of bytes transmitted, represented by an aggregate value.
 */
@property(assign, nonatomic) NSUInteger txBytes;
/**
 * The total number of bytes received, represented by an aggregate value.
 */
@property(assign, nonatomic) NSUInteger rxBytes;
/**
 * The audio transmission bitrate in Kbps, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger txAudioKBitrate;
/**
 * The audio receiving bitrate in Kbps, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger rxAudioKBitrate;
/**
 * The video transmission bitrate in Kbps, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger txVideoKBitrate;
/**
 * The video receiving bitrate in Kbps, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger rxVideoKBitrate;
/**
 * Total number of audio bytes sent (bytes), represented by an aggregate value.
 */
@property(assign, nonatomic) NSUInteger txAudioBytes;
/**
 * Total number of video bytes sent (bytes), represented by an aggregate value.
 */
@property(assign, nonatomic) NSUInteger txVideoBytes;
/**
 * Total number of audio bytes received (bytes) before network countermeasures, represented by
 * an aggregate value.
 */
@property(assign, nonatomic) NSUInteger rxAudioBytes;
/**
 * Total number of video bytes received (bytes), represented by an aggregate value.
 */
@property(assign, nonatomic) NSUInteger rxVideoBytes;
/**
 * The client-server latency (ms).
 */
@property(assign, nonatomic) NSUInteger lastmileDelay;
/**
 * The number of users in the channel.
 */
@property(assign, nonatomic) NSUInteger userCount;
/** Application CPU usage (%).
 */
@property(assign, nonatomic) double cpuAppUsage;
/** System CPU usage (%).
 */
@property(assign, nonatomic) double cpuTotalUsage;
/**
 * The connection ID.
 */
@property(assign, nonatomic) NSUInteger connectionId;
/**
 * The time interval (ms) between establishing the connection and the connection succeeds, 0 if not valid.
 */
@property(assign, nonatomic) NSInteger connectTimeMs;

/**
 * The transmission bitrate in Kbps, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger txKBitRate;
/**
 * The receiving bitrate in Kbps, represented by an instantaneous value.
 */
@property(assign, nonatomic) NSUInteger rxKBitRate;

/**The duration(ms) between first audio packet received and connection start, 0 if not valid
 */
@property(assign, nonatomic) NSInteger firstAudioPacketDuration;
/** The duration(ms) between first video packet received and connection start, 0 if not valid
 */
@property(assign, nonatomic) NSInteger firstVideoPacketDuration;
/** The duration(ms) between first video key frame received and connection start, 0 if not valid
 */
@property(assign, nonatomic) NSInteger firstVideoKeyFramePacketDuration;
/** Video packet number before first video key frame received, 0 if not valid
 */
@property(assign, nonatomic) NSInteger packetsBeforeFirstKeyFramePacket;
/**
 * The packet loss rate of sender(broadcaster).
 */
@property(assign, nonatomic) NSInteger txPacketLossRate;
/**
 * The packet loss rate of receiver(audience).
 */
@property(assign, nonatomic) NSInteger rxPacketLossRate;

@end

/** Properties of the video encoder configuration.
 */
__attribute__((visibility("default"))) @interface AgoraVideoEncoderConfiguration : NSObject
/** Video resolution that can be set manually or by choosing from one of the following
 enumerations:

 - AgoraVideoDimension120x120
 - AgoraVideoDimension160x120
 - AgoraVideoDimension180x180
 - AgoraVideoDimension240x180
 - AgoraVideoDimension320x180
 - AgoraVideoDimension240x240
 - AgoraVideoDimension320x240
 - AgoraVideoDimension424x240
 - AgoraVideoDimension360x360
 - AgoraVideoDimension480x360
 - AgoraVideoDimension640x360
 - AgoraVideoDimension480x480
 - AgoraVideoDimension640x480
 - AgoraVideoDimension840x480
 - AgoraVideoDimension960x720
 - AgoraVideoDimension1280x720

 @note Whether 720p can be supported depends on the device. If the device cannot support 720p,
 the frame rate will be lower than the one listed in the table. Agora optimizes the video in
 lower-end devices. Contact mailto:support@agora.io for special requirements.
 */
@property(assign, nonatomic) CGSize dimensions;

/** Codec type
 */
@property(assign, nonatomic) AgoraVideoCodecType codecType;

/** Frame rate of the video: AgoraVideoFrameRate
 */
@property(assign, nonatomic) AgoraVideoFrameRate frameRate;

/** Bitrate of the video:

 Refer to AgoraVideoProfile and set your desired bitrate. If the bitrate you set is beyond the
 proper range, the SDK will automatically adjust it to a value within the range. You can also choose
 from the following options:

 - AgoraVideoBitrateStandard:

     - The standard bitrate in [setVideoEncoderConfiguration]([AgoraRtcEngineKit
 setVideoEncoderConfiguration:]). - (Recommended) In a live broadcast, Agora recommends setting a
 larger bitrate to improve the video quality. When you choose AgoraVideoBitrateStandard, the bitrate
 value doubles in a live broadcast mode, and remains the same as in AgoraVideoProfile in a
 communication mode.

 - AgoraVideoBitrateCompatible:

     - The compatible bitrate in [setVideoEncoderConfiguration]([AgoraRtcEngineKit
 setVideoEncoderConfiguration:]). - The bitrate in both the live broadcast and communication modes
 remain the same as in AgoraVideoProfile.
 */
@property(assign, nonatomic) NSInteger bitrate;

@property(assign, nonatomic) NSInteger minBitrate;

/** Video orientation mode of the video: AgoraVideoOutputOrientationMode.
 */
@property(assign, nonatomic) AgoraVideoOutputOrientationMode orientationMode;

/** Video mirror mode of the video: AgoraVideoMirrorMode.
 */
@property(assign, nonatomic) AgoraVideoMirrorMode mirrorMode;

/** The video encoding degradation preference under limited bandwidth.

AgoraDegradationPreference:

* AgoraDegradationMaintainQuality(0): (Default) Degrades the frame rate to guarantee the video quality.
* AgoraDegradationMaintainFramerate(1): Degrades the video quality to guarantee the frame rate.
*/
@property (assign, nonatomic) AgoraDegradationPreference degradationPreference;

/** Initializes and returns a newly allocated AgoraVideoEncoderConfiguration object with the
 specified video resolution.

 @param size Video resolution
 @param frameRate Video frame rate
 @param bitrate Video bitrate
 @param orientationMode AgoraVideoOutputOrientationMode
 @param mirrorMode AgoraVideoMirrorMode
 @return An initialized AgoraVideoEncoderConfiguration object
 */
- (instancetype _Nonnull)initWithSize:(CGSize)size
                            frameRate:(AgoraVideoFrameRate)frameRate
                              bitrate:(NSInteger)bitrate
                      orientationMode:(AgoraVideoOutputOrientationMode)orientationMode
                           mirrorMode:(AgoraVideoMirrorMode)mirrorMode;

/** Initializes and returns a newly allocated AgoraVideoEncoderConfiguration object with the
 specified video width and height.

 @param width Width of the video
 @param height Height of the video
 @param frameRate Video frame rate
 @param bitrate Video bitrate
 @param orientationMode AgoraVideoOutputOrientationMode
 @param mirrorMode AgoraVideoMirrorMode
 @return An initialized AgoraVideoEncoderConfiguration object
 */
- (instancetype _Nonnull)initWithWidth:(NSInteger)width
                                height:(NSInteger)height
                             frameRate:(AgoraVideoFrameRate)frameRate
                               bitrate:(NSInteger)bitrate
                       orientationMode:(AgoraVideoOutputOrientationMode)orientationMode
                            mirrorMode:(AgoraVideoMirrorMode)mirrorMode;
@end

/** A class for providing user-specific audio/video transcoding settings.
 */
__attribute__((visibility("default"))) @interface AgoraLiveTranscodingUser : NSObject
/** User ID.
 */
@property(assign, nonatomic) NSUInteger uid;
/** Position and size of the video frame.
 */
@property(assign, nonatomic) CGRect rect;
/** Video frame layer number, in the range of 1 to 100.

 * 1: The video frame image is in the lowest layer (default)
 * 100: The video frame image is in the highest layer
 */
@property(assign, nonatomic) NSInteger zOrder;
/** Transparency of the video frame, between 0 and 1.0:

 * 0: Completely transparent
 * 1.0: Opaque (default)
 */
@property(assign, nonatomic) double alpha;
/** The audio channel of the sound. The default value is 0:

 * 0: (default) Supports dual channels at most, depending on the upstream of the broadcaster.
 * 1: The audio stream of the broadcaster is in the FL audio channel. If the upstream of the
 broadcaster uses dual-sound channel, only the left-sound channel will be used for streaming. * 2:
 The audio stream of the broadcaster is in the FC audio channel. If the upstream of the broadcaster
 uses dual-sound channel, only the left-sound channel will be used for streaming. * 3: The audio
 stream of the broadcaster is in the FR audio channel. If the upstream of the broadcaster uses
 dual-sound channel, only the left-sound channel will be used for streaming. * 4: The audio stream
 of the broadcaster is in the BL audio channel. If the upstream of the broadcaster uses dual-sound
 channel, only the left-sound channel will be used for streaming. * 5: The audio stream of the
 broadcaster is in the BR audio channel. If the upstream of the broadcaster uses dual-sound channel,
 only the left-sound channel will be used for streaming.
 */
@property(assign, nonatomic) NSInteger audioChannel;
@end

/** Watermark image properties.
 */
__attribute__((visibility("default"))) @interface AgoraImage : NSObject
/** URL address of the watermark on the broadcasting video
 */
@property(strong, nonatomic) NSURL *_Nonnull url;
/** Position and size of the watermark on the broadcasting video in CGRect
 */
@property(assign, nonatomic) CGRect rect;
/**
 * Order attribute for an ordering of overlapping two-dimensional objects.
*/
@property (assign, nonatomic) NSInteger zOrder;
@end

/** A class for managing CDN transcoding.
 */
__attribute__((visibility("default"))) @interface AgoraLiveTranscoding : NSObject
/** Size of the video (width and height).
 */
@property(assign, nonatomic) CGSize size;
/** Bitrate of the output data stream set for CDN live. Default value is 400 Kbps.
 */
@property(assign, nonatomic) NSInteger videoBitrate;
/** Frame rate of the output data stream set for CDN live. Default value is 15 fps.
 */
@property(assign, nonatomic) NSInteger videoFramerate;
/**
 * - YES: Low latency with unassured quality.
 * - NO: (Default) High latency with assured quality.
 */
@property(assign, nonatomic) BOOL lowLatency;
/** Interval between the I frames. Default value is 2 (s).
 */
@property(assign, nonatomic) NSInteger videoGop;
/** Video codec profile type.
 */
@property(assign, nonatomic) AgoraVideoCodecProfileType videoCodecProfile;

/** An AgoraLiveTranscodingUser object that manages the the user layout configuration in the CDN
 * streaming.
 */
@property(copy, nonatomic) NSArray<AgoraLiveTranscodingUser *> *_Nullable transcodingUsers;
/** Reserved: Extra user-defined information to send to the CDN client.
 */
@property(copy, nonatomic) NSString *_Nullable transcodingExtraInfo;
/** The HTTP url (not HTTPS) address of the watermark image added to the CDN publishing stream.

 The audience of the CDN publishing stream can see the watermark. See AgoraImage for the definition
 of the watermark.
 */
@property(strong, nonatomic) AgoraImage *_Nullable watermark;
/**
 * add few watermarks
*/
@property (copy, nonatomic) NSArray<AgoraImage *> *_Nullable watermarkArray;
/** The HTTP url (not HTTPS) address of the background image added to the CDN publishing stream.

 The audience of the CDN publishing stream can see the background image. See AgoraImage for the
 definition of the background image.
 */
@property(strong, nonatomic) AgoraImage *_Nullable backgroundImage;
/**
 * add few backgroundImage
*/
@property (copy, nonatomic) NSArray<AgoraImage *> *_Nullable backgroundImageArray;
/** Enter any of the 6-digit symbols defined in RGB.
 */
@property(strong, nonatomic) COLOR_CLASS *_Nullable backgroundColor;

/** Audio sampling rate: AgoraAudioSampleRateType.
 */
@property(assign, nonatomic) AgoraAudioSampleRateType audioSampleRate;
/** Bitrate of the audio output stream set for CDN live. The highest value is 128 Kbps.
 */
@property(assign, nonatomic) NSInteger audioBitrate;
/** Agora's self-defined audio channel types. Agora recommends choosing 1 or 2:

 * 1: Mono (default)
 * 2: Dual-sound channels
 * 3: Three-sound channels
 * 4: Four-sound channels
 * 5: Five-sound channels
 */
@property(assign, nonatomic) NSInteger audioChannels;
/** Audio codec profile type.
 */
@property(assign, nonatomic) AgoraAudioCodecProfileType audioCodecProfile;

/** Create a default transcoding

 @return default transcoding
 */
+ (AgoraLiveTranscoding *_Nonnull)defaultTranscoding;

- (int)addUser:(AgoraLiveTranscodingUser *_Nonnull)user;

- (int)removeUser:(NSUInteger)uid;
@end

/** Live broadcast import stream configuration.
 */
__attribute__((visibility("default"))) @interface AgoraLiveInjectStreamConfig : NSObject
/** Size of the stream to be imported into the live broadcast. The default value is 0; same
 * size as the original stream.
 */
@property(assign, nonatomic) CGSize size;
/** Video GOP of the stream to be added into the broadcast. The default value is 30.
 */
@property(assign, nonatomic) NSInteger videoGop;
/** Video frame rate of the stream to be added into the broadcast. The default value is 15 fps.
 */
@property(assign, nonatomic) NSInteger videoFramerate;
/** Video bitrate of the stream to be added into the broadcast. The default value is 400 Kbps.
 */
@property(assign, nonatomic) NSInteger videoBitrate;

/** Audio sampling rate of the stream to be added into the broadcast. The default value is 48000.
 */
@property(assign, nonatomic) AgoraAudioSampleRateType audioSampleRate;
/** Audio bitrate of the stream to be added into the broadcast. The default value is 48 Kbps.
 */
@property(assign, nonatomic) NSInteger audioBitrate;
/** Audio channels to be added into the broadcast. The default value is 1.
 */
@property(assign, nonatomic) NSInteger audioChannels;

/** Create a default stream config

 @return default stream config
 */
+ (AgoraLiveInjectStreamConfig *_Nonnull)defaultConfig;
@end

    __deprecated

    /** AgoraRtcVideoCompositingRegion array.
     */
    __attribute__((visibility("default"))) @interface AgoraRtcVideoCompositingRegion
    : NSObject
      /** User ID of the user with the video to be displayed in the region.
       */
      @property(assign, nonatomic) NSUInteger uid;
/** Horizontal position of the region on the screen (0.0 to 1.0).
 */
@property(assign, nonatomic) CGFloat x;
/** Vertical position of the region on the screen (0.0 to 1.0).
 */
@property(assign, nonatomic) CGFloat y;
/** Actual width of the region (0.0 to 1.0).
 */
@property(assign, nonatomic) CGFloat width;
/** Actual height of the region (0.0 to 1.0).
 */
@property(assign, nonatomic) CGFloat height;
/** 0 means the region is at the bottom, and 100 means the region is at the top.
 */
@property(assign, nonatomic) NSInteger zOrder;
/** 0 means the region is transparent, and 1 means the region is opaque. The default value is 1.0.
 */
@property(assign, nonatomic) CGFloat alpha;
/** Render mode: AgoraVideoRenderMode
 */
@property(assign, nonatomic) AgoraVideoRenderMode renderMode;
@end

    __deprecated
    /** Rtc video compositing layout.
     */
    __attribute__((visibility("default"))) @interface AgoraRtcVideoCompositingLayout
    : NSObject
      /** Width of the entire canvas (display window or screen).
       */
      @property(assign, nonatomic) NSInteger canvasWidth;
/** Height of the entire canvas (display window or screen).
 */
@property(assign, nonatomic) NSInteger canvasHeight;
/** Enter any of the 6-digit symbols defined in RGB. For example, "#c0c0c0"
 */
@property(copy, nonatomic) NSString *_Nullable backgroundColor;
/** AgoraRtcVideoCompositingRegion array.
 */
@property(copy, nonatomic) NSArray<AgoraRtcVideoCompositingRegion *> *_Nullable regions;
/** Application defined data.
 */
@property(copy, nonatomic) NSString *_Nullable appData;
@end

    /**
     @deprecated

     Sets whether the current host is the RTMP stream owner.
     */
    __deprecated __attribute__((visibility("default"))) @interface AgoraPublisherConfiguration
    : NSObject
      /**
       - YES: The current host is the RTMP stream owner and the push-stream configuration is enabled
       (default). - NO: The current host is not the RTMP stream owner and the push-stream
       configuration is disabled.
       */
      @property(assign, nonatomic) BOOL owner;

/** Width of the output data stream set for CDN Live. 360 is the default value
 */
@property(assign, nonatomic) NSInteger width;
/** Height of the output data stream set for CDN Live. 640 is the default value
 */
@property(assign, nonatomic) NSInteger height;
/** Frame rate of the output data stream set for CDN Live. 15 fps is the default value
 */
@property(assign, nonatomic) NSInteger framerate;
/** Bitrate of the output data stream set for CDN Live. 500 kbit/s is the default value
 */
@property(assign, nonatomic) NSInteger bitrate;
/** Audio sample rate of the output data stream set for CDN Live. The default value is 48000.
 */
@property(assign, nonatomic) NSInteger audiosamplerate;
/** Audio bitrate of the output data stream set for CDN Live.  The default value is 48.
 */
@property(assign, nonatomic) NSInteger audiobitrate;
/** Audio channels of the output data stream set for CDN Live. The default value is 1.
 */
@property(assign, nonatomic) NSInteger audiochannels;

/**

* 0: Tile Horizontally
* 1: Layered Windows
* 2: Tile Vertically
 */
@property(assign, nonatomic) NSInteger defaultLayout;
/** Video stream lifecycle of CDN Live: AgoraRtmpStreamLifeCycle
 */
@property(assign, nonatomic) AgoraRtmpStreamLifeCycle lifeCycle;

/** Width of the stream to be injected. Set it as 0.
 */
@property(assign, nonatomic) NSInteger injectStreamWidth;

/** Height of the stream to be injected. Set it as 0.
 */
@property(assign, nonatomic) NSInteger injectStreamHeight;

/** Address of the stream to be injected to the channel.
 */
@property(copy, nonatomic) NSString *_Nullable injectStreamUrl;

/** The push-stream address for the picture-in-picture layouts. The default value is *NULL*.
 */
@property(copy, nonatomic) NSString *_Nullable publishUrl;

/** The push-stream address of the original stream which does not require picture-blending. The
 * default value is NULL.
 */
@property(copy, nonatomic) NSString *_Nullable rawStreamUrl;

/** Reserved field. The default value is NULL.
 */
@property(copy, nonatomic) NSString *_Nullable extraInfo;

/** Check if configuration is validate
 */
- (BOOL)validate;

- (NSString * _Nullable)toJsonString;
@end

#if (!(TARGET_OS_IPHONE) && (TARGET_OS_MAC))

/** AgoraRtcDeviceInfo array.
 */
__attribute__((visibility("default"))) @interface AgoraRtcDeviceInfo : NSObject
@property (assign, nonatomic) int __deprecated index;

/** AgoraMediaDeviceType
 */
@property(assign, nonatomic) AgoraMediaDeviceType type;

/** Device ID.
 */
@property(copy, nonatomic) NSString *_Nullable deviceId;

/** Device name.
 */
@property(copy, nonatomic) NSString *_Nullable deviceName;
@end
#endif

/** Properties of the AgoraVideoFrame object.
 */
__attribute__((visibility("default"))) @interface AgoraVideoFrame : NSObject
/** Video format:

 * - 1: I420
 * - 2: BGRA
 * - 3: NV21
 * - 4: RGBA
 * - 5: IMC2
 * - 7: ARGB
 * - 8: NV12
 * - 12: iOS texture (CVPixelBufferRef)
 */
@property(assign, nonatomic) NSInteger format;

/** Timestamp of the incoming video frame (ms). An incorrect timestamp will result in frame loss or
 * unsynchronized audio and video.
 */
@property(assign, nonatomic) CMTime time;  // Time for this frame.

/**
 @deprecated Use strideInPixels instead.
 */
@property(assign, nonatomic) int stride DEPRECATED_MSG_ATTRIBUTE("use strideInPixels instead");

/** Line spacing of the incoming video frame, which must be in pixels instead of bytes. For
 * textures, it is the width of the texture.
 */
@property(assign, nonatomic) int strideInPixels;  // Number of pixels between two consecutive rows.
                                                  // Note: in pixel, not byte. Not used for iOS
                                                  // textures.

/** Height of the incoming video frame.
 */
@property(assign, nonatomic) int height;  // Number of rows of pixels. Not used for iOS textures.

/** CVPixelBuffer
 */
@property(assign, nonatomic) CVPixelBufferRef _Nullable textureBuf;

/** Raw data buffer.
 */
@property(strong, nonatomic) NSData *_Nullable dataBuf;  // Raw data buffer. Not used for iOS textures.

/** (Optional) Specifies the number of pixels trimmed from the left, which is set as 0 by default.
 */
@property(assign, nonatomic) int cropLeft;  // Number of pixels to crop on the left boundary.
/** (Optional) Specifies the number of pixels trimmed from the top, which is set as 0 by default.
 */
@property(assign, nonatomic) int cropTop;  // Number of pixels to crop on the top boundary.
/** (Optional) Specifies the number of pixels trimmed from the right, which is set as 0 by default.
 */
@property(assign, nonatomic) int cropRight;  // Number of pixels to crop on the right boundary.
/** (Optional) Specifies the number of pixels trimmed from the bottom, which is set as 0 by default.
 */
@property(assign, nonatomic) int cropBottom;  // Number of pixels to crop on the bottom boundary.
/** (Optional) Specifies whether to rotate the incoming video group. Optional values: 0, 90, 180, or
 * 270 clockwise. Set as 0 by default.
 */
@property(assign, nonatomic) int rotation;  // 0, 90, 180, 270. See document for rotation calculation.
/* Note
 * 1. strideInPixels
 *    Stride is in pixels, not bytes
 * 2. About the frame width and height
 *    No field is defined for the width. However, it can be deduced by:
 *       croppedWidth = (strideInPixels - cropLeft - cropRight)
 *    And
 *       croppedHeight = (height - cropTop - cropBottom)
 * 3. About crop
 *    _________________________________________________________________.....
 *    |                        ^                                      |  ^
 *    |                        |                                      |  |
 *    |                     cropTop                                   |  |
 *    |                        |                                      |  |
 *    |                        v                                      |  |
 *    |                ________________________________               |  |
 *    |                |                              |               |  |
 *    |                |                              |               |  |
 *    |<-- cropLeft -->|          valid region        |<- cropRight ->|
 *    |                |                              |               | height
 *    |                |                              |               |
 *    |                |_____________________________ |               |  |
 *    |                        ^                                      |  |
 *    |                        |                                      |  |
 *    |                     cropBottom                                |  |
 *    |                        |                                      |  |
 *    |                        v                                      |  v
 *    _________________________________________________________________......
 *    |                                                               |
 *    |<---------------- strideInPixels ----------------------------->|
 *
 *    If your buffer contains garbage data, you can crop them. For example, the frame size is
 *    360 x 640, often the buffer stride is 368, that is, there extra 8 pixels on the
 *    right are for padding, and should be removed. In this case, you can set:
 *    strideInPixels = 368;
 *    height = 640;
 *    cropRight = 8;
 *    // cropLeft, cropTop, cropBottom are set to a default of 0
 */
@end

__attribute__((visibility("default"))) @interface AgoraLogConfig: NSObject
/** The absolute path of log files.
 
 Ensure that the directory for the log
 files exists and is writable. The default file path is as follows:

 - iOS: `App Sandbox/Library/caches/agorasdk.log`
 - macOS:
   - Sandbox enabled: `App Sandbox/Library/Logs/agorasdk.log`, such as
   `/Users/<username>/Library/Containers/<App Bundle Identifier>/Data/Library/Logs/agorasdk.log`
   - Sandbox disabled: `～/Library/Logs/agorasdk.log`
 */
@property (copy, nonatomic) NSString * _Nullable filePath;
/** The size (KB) of a log file.
 
 The default value is 1024 KB. If you set
 this parameter to 1024 KB, the SDK outputs at most 5 MB log files; if
 you set it to less than 1024 KB, the setting is invalid, and the maximum
 size of a log file is still 1024 KB.
 */
@property (assign, nonatomic) NSInteger fileSizeInKB;
/** The output log level of the SDK. See details in AgoraLogLevel.
 
 For example, if you set the log level to `AgoraLogLevelWarn`, the SDK outputs the logs
 within levels `AgoraLogLevelFatal`, `AgoraLogLevelError`, and `AgoraLogLevelWarn`.
 */
@property (assign, nonatomic) AgoraLogLevel level;
@end

__attribute__((visibility("default"))) @interface AgoraRtcEngineConfig: NSObject
 @property (copy, nonatomic) NSString * _Nullable appId;
 @property (assign, nonatomic) AgoraChannelProfile channelProfile;
 @property (assign, nonatomic) AgoraAudioScenario audioScenario;
 @property (assign, nonatomic) AgoraAreaCodeType areaCode;
 @property (strong, nonatomic) AgoraLogConfig * _Nullable logConfig;
 @property (copy, nonatomic) NSArray<id<AgoraMediaFilterExtensionDelegate>>* _Nullable mediaFilterExtensions;
 @property (weak, nonatomic) id<AgoraMediaFilterEventDelegate> _Nullable eventDelegate;
@end

/**
 * The class of AgoraAudioFrame.
 */

__attribute__((visibility("default"))) @interface AgoraAudioFrame: NSObject
 @property (assign, nonatomic) NSInteger samplesPerChannel;
 @property (assign, nonatomic) NSInteger bytesPerSample;
 @property (assign, nonatomic) NSInteger channels;
 @property (assign, nonatomic) NSInteger samplesPerSec;
 @property (strong, nonatomic) NSData* _Nullable buffer;
 @property (assign, nonatomic) int64_t renderTimeMs;
 @property (assign, nonatomic) NSInteger avSyncType;
@end

/**
 * The collections of network info.
 */
__attribute__((visibility("default"))) @interface AgoraNetworkInfo : NSObject
/**
* The target video encoder bitrate bps.
*/
@property(nonatomic, assign) int videoEncoderTargetBitrateBps;

@end

/**
 * The leave channel options.
 */
__attribute__((visibility("default"))) @interface AgoraLeaveChannelOptions : NSObject
/**
 * Determines whether to stop playing and mixing the music file when leave channel.
 * - true: (Default) Stop playing and mixing the music file.
 * - false: Do not stop playing and mixing the music file.
 */
@property(nonatomic, assign) BOOL stopAudioMixing;
/**
 * Determines whether to stop all music effects when leave channel.
 * - true: (Default) Stop all music effects.
 * - false: Do not stop the music effect.
 */
@property(nonatomic, assign) BOOL stopAllEffect;

/**
 * Determines whether to stop microphone recording when leave channel.
 * - true: (Default) Stop microphone recording.
 * - false: Do not stop microphone recording.
 */
@property(nonatomic, assign) BOOL stopMicrophoneRecording;

@end

__attribute__((visibility("default"))) @interface AgoraOutputVideoFrame : NSObject

/** Video format:
 * - 1: I420
 * - 2: BGRA
 * - 3: NV21
 * - 4: RGBA
 * - 5: IMC2
 * - 7: ARGB
 * - 8: NV12
 * - 12: iOS texture (CVPixelBufferRef)
 */
@property (nonatomic, assign) NSInteger type;
/**
 * The width of the Video frame.
 */
@property (nonatomic, assign) int width;
/**
 * The height of the video frame.
 */
@property (nonatomic, assign) int height;
/**
 * The line span of Y buffer in the YUV data.
 */
@property (nonatomic, assign) int yStride;
/**
 * The line span of U buffer in the YUV data.
 */
@property (nonatomic, assign) int uStride;
/**
 * The line span of V buffer in the YUV data.
 */
@property (nonatomic, assign) int vStride;
/**
 * The pointer to the Y buffer in the YUV data.
 */
@property (nonatomic, assign) uint8_t* _Nullable yBuffer;
/**
 * The pointer to the U buffer in the YUV data.
 */
@property (nonatomic, assign) uint8_t* _Nullable uBuffer;
/**
 * The pointer to the V buffer in the YUV data.
 */
@property (nonatomic, assign) uint8_t* _Nullable vBuffer;
/**
 * The clockwise rotation information of this frame. You can set it as 0, 90, 180 or 270.
 */
@property (nonatomic, assign) int rotation;
/**
 * The timestamp to render the video stream. Use this parameter for audio-video synchronization when
 * rendering the video.
 *
 * @note This parameter is for rendering the video, not capturing the video.
 */
@property (nonatomic, assign) int64_t renderTimeMs;
/**
 * The type of audio-video synchronization.
 */
@property (nonatomic, assign) int avSyncType;

/** CVPixelBuffer
 */
@property(assign, nonatomic) CVPixelBufferRef _Nullable pixelBuffer;

@end

/** the configuration of camera capturer.
 */
#if TARGET_OS_IOS
__attribute__((visibility("default"))) @interface AgoraCameraCapturerConfiguration: NSObject
/** The camera direction. See AgoraCameraDirection:

 - AgoraCameraDirectionRear: The rear camera.
 - AgoraCameraDirectionFront: The front camera.
 */
@property (assign, nonatomic) AgoraCameraDirection cameraDirection;
@end
#endif

/** The definition of AgoraChannelMediaRelayInfo.
 */
__attribute__((visibility("default"))) @interface AgoraChannelMediaRelayInfo: NSObject
/** The token that enables the user to join the channel.
 */
@property (copy, nonatomic) NSString * _Nullable token;
/** The channel name.
 */
@property (copy, nonatomic) NSString * _Nullable channelName;
/** The user ID.
 */
@property (assign, nonatomic) NSUInteger uid;
/** Initializes the AgoraChannelMediaRelayInfo object
 
 @param token The token that enables the user to join the channel.
 */
- (instancetype _Nonnull)initWithToken:(NSString *_Nullable)token;
@end

/** The definition of AgoraChannelMediaRelayConfiguration.
 */
__attribute__((visibility("default"))) @interface AgoraChannelMediaRelayConfiguration: NSObject
/** The information of the destination channel: AgoraChannelMediaRelayInfo. It contains the following members:
 
 - `channelName`: The name of the destination channel.
 - `uid`: ID of the broadcaster in the destination channel. The value ranges from 0 to (2<sup>32</sup>-1). To avoid UID conflicts, this `uid` must be different from any other UIDs in the destination channel. The default value is 0, which means the SDK generates a random UID.
 - `token`: The token for joining the destination channel. It is generated with the `channelName` and `uid` you set in `destinationInfos`.
 
 - If you have not enabled the App Certificate, set this parameter as the default value `nil`, which means the SDK applies the App ID.
 - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`.
 */
@property (strong, nonatomic, readonly) NSDictionary<NSString *, AgoraChannelMediaRelayInfo *> *_Nullable destinationInfos;
/** The information of the source channel: AgoraChannelMediaRelayInfo. It contains the following members:
 
 - `channelName`: The name of the source channel. The default value is `nil`, which means the SDK applies the name of the current channel.
 - `uid`: ID of the broadcaster whose media stream you want to relay. The default value is 0, which means the SDK generates a random UID. You must set it as 0.
 - `token`: The token for joining the source channel. It is generated with the `channelName` and `uid` you set in `sourceInfo`.
 
 - If you have not enabled the App Certificate, set this parameter as the default value `nil`, which means the SDK applies the App ID.
 - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`, and the `uid` must be set as 0.
 */
@property (strong, nonatomic) AgoraChannelMediaRelayInfo *_Nonnull sourceInfo;
/** Sets the information of the destination channel.
 
 If you want to relay the media stream to multiple channels, call this method as many times (at most four).
 
 @param destinationInfo The information of the destination channel: AgoraChannelMediaRelayInfo. It contains the following members:
 
 - `channelName`: The name of the destination channel.
 - `uid`: ID of the broadcaster in the destination channel. The value ranges from 0 to (2<sup>32</sup>-1). To avoid UID conflicts, this `uid` must be different from any other UIDs in the destination channel. The default value is 0, which means the SDK generates a random UID.
 - `token`: The token for joining the destination channel. It is generated with the `channelName` and `uid` you set in `destinationInfo`.
 
 - If you have not enabled the App Certificate, set this parameter as the default value `nil`, which means the SDK applies the App ID.
 - If you have enabled the App Certificate, you must use the `token` generated with the `channelName` and `uid`.
 
 @param channelName The name of the destination channel. Ensure that the value of this parameter is the same as that of the `channelName` member in `destinationInfo`.
 
 @return - YES: Success.
 - NO: Failure.
 */
- (BOOL)setDestinationInfo:(AgoraChannelMediaRelayInfo *_Nonnull)destinationInfo forChannelName:(NSString *_Nonnull)channelName;
/** Removes the destination channel.
 
 @param channelName The name of the destination channel.
 
 @return - YES: Success.
 - NO: Failure.
 */
- (BOOL)removeDestinationInfoForChannelName:(NSString *_Nonnull)channelName;
@end

/** Configurations of built-in encryption schemas.
 */
__attribute__((visibility("default"))) @interface AgoraEncryptionConfig: NSObject

 /** Encryption mode. The default encryption mode is `AgoraEncryptionModeAES128XTS`. See AgoraEncryptionMode.
  */
 @property (assign, nonatomic) AgoraEncryptionMode encryptionMode;

 /** Encryption key in string type.

 **Note**

 If you do not set an encryption key or set it as `nil`, you cannot use the built-in encryption, and the SDK returns `-2` (`AgoraErrorCodeInvalidArgument`).
  */
 @property (copy, nonatomic) NSString * _Nullable encryptionKey;
 @end

/** The definition of AgoraTranscodingVideoStream.
 */
__attribute__((visibility("default"))) @interface AgoraTranscodingVideoStream: NSObject
/**
 * Source type of video stream.
 */
@property (assign, nonatomic) AgoraVideoSourceType sourceType;
/**
 * Remote user uid if sourceType is AgoraVideoSourceTypeRemote.
 */
@property (assign, nonatomic) NSUInteger remoteUserUid;
/**
 * connectionId of Remote user uid if sourceType is VIDEO_SOURCE_REMOTE.
 * Set to DEFAULT_CONNECTION_ID if you only join single channel. (DEFAULT_CONNECTION_ID = 0)
*/
@property (assign, nonatomic) NSUInteger connectionId;
/**
 * RTC image if sourceType is AgoraVideoSourceTypeRtcImage.
 */
@property (copy, nonatomic) NSString * _Nullable imageUrl;
/**
 * Position and size of the video frame.
 */
@property (assign, nonatomic) CGRect rect;
/**
 * The layer of the video frame that ranges from 1 to 100:
   - 1: (Default) The lowest layer.
   - 100: The highest layer.
 */
@property (assign, nonatomic) NSInteger zOrder;
/**
 * The transparency of the video frame.
 */
@property(assign, nonatomic) double alpha;

@end

/** The definition of AgoraLocalTranscoderConfiguration.
 */
__attribute__((visibility("default"))) @interface AgoraLocalTranscoderConfiguration: NSObject
/**
 * The video stream layout configuration in the transcoder.
 */
@property(copy, nonatomic) NSArray<AgoraTranscodingVideoStream *> *_Nullable videoInputStreams;
/**
 * The video encoder configuration of transcoded video.
 */
@property (strong, nonatomic) AgoraVideoEncoderConfiguration *_Nonnull videoOutputConfiguration;

@end

/** The definition of the screen sharing encoding parameters.
 */
__attribute__((visibility("default"))) @interface AgoraScreenCaptureParameters: NSObject
/**
 * The dimensions of the shared region in terms of width &times; height. The default value is 0, which means
 * the original dimensions of the shared screen.
 */
@property (assign, nonatomic) CGSize dimensions;
/**
 * The frame rate (fps) of the shared region. The default value is 5. We do not recommend setting
 * this to a value greater than 15.
 */
@property (assign, nonatomic) NSInteger frameRate;
/**
 * The bitrate (Kbps) of the shared region. The default value is 0, which means the SDK works out a bitrate
 * according to the dimensions of the current screen.
 */
@property (assign, nonatomic) NSInteger bitrate;

@end

/** Configurations of SimulcastStreamConfig.
 */
__attribute__((visibility("default"))) @interface AgoraSimulcastStreamConfig: NSObject

/**
 * The video bitrate (Kbps).
 */
 @property (assign, nonatomic) int bitrate;
/**
 * The video framerate.
 */
 @property (assign, nonatomic) int framerate;
 /**
  * The video frame dimension.
  */
 @property (assign, nonatomic) CGSize dimensions;

 @end

/** The AgoraMediaStreamInfo class, reporting the whole detailed information of
 the media stream.
 */
__attribute__((visibility("default"))) @interface AgoraRtcMediaStreamInfo : NSObject
/** The index of the media stream. */
@property(nonatomic, assign) NSInteger streamIndex;
/** The type of the media stream. See AgoraMediaStreamType for details. */
@property(nonatomic, assign) AgoraMediaStreamType streamType;
/** The codec of the media stream. */
@property(nonatomic, copy) NSString *_Nonnull codecName;
/** The language of the media stream. */
@property(nonatomic, copy) NSString *_Nullable language;
/** For video stream, gets the frame rate (fps). */
@property(nonatomic, assign) NSInteger videoFrameRate;
/** For video stream, gets the bitrate (bps). */
@property(nonatomic, assign) NSInteger videoBitRate;
/** For video stream, gets the width (pixel) of the video. */
@property(nonatomic, assign) NSInteger videoWidth;
/** For video stream, gets the height (pixel) of the video. */
@property(nonatomic, assign) NSInteger videoHeight;
/** For the audio stream, gets the sample rate (Hz). */
@property(nonatomic, assign) NSInteger audioSampleRate;
/** For the audio stream, gets the channel number. */
@property(nonatomic, assign) NSInteger audioChannels;
/** The total duration (s) of the media stream. */
@property(nonatomic, assign) NSInteger duration;
/** The rotation of the video stream. */
@property(nonatomic, assign) NSInteger rotation;

@end

/**
 * The configurations for the last-mile network probe test.
 */
__attribute__((visibility("default"))) @interface AgoraAudioFileRecordingConfig: NSObject
/**
 * Sets whether or not to test the uplink network.
 *
 * Some users, for example, the audience in a live-broadcast channel, do not need such a test.
 * - `YES`: Enables the test.
 * - `NO`: Disables the test.
 */
@property (copy, nonatomic) NSString * _Nullable filePath;
@property (assign, nonatomic) BOOL codec;
/**
 * Sets whether or not to test the downlink network.
 * - `YES`: Enables the test.
 * - `NO`: Disables the test.
 */
@property (assign, nonatomic) NSUInteger sampleRate;
/**
 * Sets the expected maximum sending bitrate (bps) of the local user.
 *
 * The value ranges between 100000 and 5000000. Agora recommends
 * setting this value according to the required bitrate of selected video profile.
 */
@property (assign, nonatomic) AgoraAudioFileRecordingType fileRecordOption;
/**
 * Sets the expected maximum receiving bitrate (bps) of the local user.
 * The value ranges between 100000 and 5000000.
 */
@property (assign, nonatomic) AgoraAudioRecordingQuality quality;
@end

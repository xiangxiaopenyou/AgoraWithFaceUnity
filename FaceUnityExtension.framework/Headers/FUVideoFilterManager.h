#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraMediaFilterExtensionDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@class FUVideoExtensionObject;

@interface FUVideoFilterManager : NSObject
+ (instancetype)sharedInstance;

+ (NSString * __nonnull)vendorName;
- (FUVideoExtensionObject * __nonnull)mediaFilterExtension;
- (void)loadPlugin;
- (int)setParameter:(NSString * __nullable)parameter;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface FUVideoExtensionObject : NSObject <AgoraMediaFilterExtensionDelegate>
@property (copy, nonatomic) NSString * __nonnull vendorName;
@property (assign, nonatomic) id<AgoraExtProviderDelegate> __nullable mediaFilterProvider;

@end

NS_ASSUME_NONNULL_END


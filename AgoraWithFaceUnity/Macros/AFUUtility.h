//
//  AFUUtility.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFUUtility : NSObject

+ (BOOL)deviceIsiPhoneXStyle;

/// object转jsonString
/// @param object NSDictionary 或者 NSArray
+ (NSString *)jsonStringOfObject:(id)object;

@end

NS_ASSUME_NONNULL_END

//
//  UIColor+AFUHex.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AFUHex)

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorFromHex:(UInt32)hex;

+ (UIColor *)colorFromHex:(UInt32)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END

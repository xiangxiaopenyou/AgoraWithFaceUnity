//
//  UIColor+AFUHex.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/29.
//

#import "UIColor+AFUHex.h"

@implementation UIColor (AFUHex)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    return [self colorFromHexString:hexString alpha:1];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    //删除前缀字符
    if ([hexString hasPrefix:@"0X"] || [hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    //判断字符串是否符合长度规范
    if (hexString.length != 6) {
        return [UIColor clearColor];
    }
    
    //截取色值字符
    NSRange range = NSMakeRange(0, 2);
    NSString *redString = [hexString substringWithRange:range];
    range.location = 2;
    NSString *greenString = [hexString substringWithRange:range];
    range.location = 4;
    NSString *blueString = [hexString substringWithRange:range];
    
    //转换成色值
    unsigned int red;
    unsigned int green;
    unsigned int blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    UIColor *resultColor = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
    return resultColor;
}

+ (UIColor *)colorFromHex:(UInt32)hex {
    return [self colorFromHex:hex alpha:1];
}

+ (UIColor *)colorFromHex:(UInt32)hex alpha:(CGFloat)alpha {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

@end

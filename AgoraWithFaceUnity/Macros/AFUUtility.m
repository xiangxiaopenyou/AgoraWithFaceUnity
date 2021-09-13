//
//  AFUUtility.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/26.
//

#import "AFUUtility.h"

#import <UIKit/UIKit.h>

@implementation AFUUtility

+ (BOOL)deviceIsiPhoneXStyle {
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)jsonStringOfObject:(id)object {
    if (!object) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end

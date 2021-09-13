//
//  AFUHelper.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/29.
//

#import "AFUHelper.h"

#import <FaceUnityExtension/FUVideoFilterManager.h>

@implementation AFUHelper


+ (void)setupParameters:(NSDictionary *)parameters {
    NSString *jsonString = [AFUUtility jsonStringOfObject:parameters];
    [[FUVideoFilterManager sharedInstance] setParameter:jsonString];
}

+ (NSString *)expressionStringWithInt:(NSInteger)expressionInt {
    switch (expressionInt) {
        case 0:
            return @"无";
            break;
        case 1 << 1:
            return @"抬眉毛";
            break;
        case 1 << 2:
            return @"皱眉";
            break;
        case 1 << 3:
            return @"闭左眼";
            break;
        case 1 << 4:
            return @"闭右眼";
            break;
        case 1 << 5:
            return @"睁大眼睛";
            break;
        case 1 << 6:
            return @"抬左边嘴角";
            break;
        case 1 << 7:
            return @"抬右边嘴角";
            break;
        case 1 << 8:
            return @"嘴型o";
            break;
        case 1 << 9:
            return @"嘴型'啊'";
            break;
        case 1 << 10:
            return @"嘟嘴";
            break;
        case 1 << 11:
            return @"抿嘴";
            break;
        case 1 << 12:
            return @"鼓脸";
            break;
        case 1 << 13:
            return @"微笑";
            break;
        case 1 << 14:
            return @"撇嘴";
            break;
        case 1 << 15:
            return @"左转头";
            break;
        case 1 << 16:
            return @"右转头";
            break;
        case 1 << 17:
            return @"点头";
            break;
        default: {
            if (expressionInt < 0) {
                return @"无";
            }
            NSString *resultString = @"";
            for (int i = 1; i < 18; i++) {
                int result = 1 << i;
                if ((expressionInt & result) > 0) {
                    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@ ", [self expressionStringWithInt:result]]];
                }
            }
            if (resultString.length > 0) {
                return resultString;
            } else {
                return @"无";
            }
        }
            break;
    }
}

+ (NSString *)gestureStringWithInt:(NSInteger)gestureInt {
    switch (gestureInt) {
        case 1:
            return @"点赞";
            break;
        case 2:
            return @"单手比心";
            break;
        case 3:
            return @"666";
            break;
        case 4:
            return @"拳头";
            break;
        case 5:
            return @"推掌";
            break;
        case 6:
            return @"数字 1";
            break;
        case 7:
            return @"数字2";
            break;
        case 8:
            return @"OK手势";
            break;
        case 9:
            return @"摇滚";
            break;
//        case 10:
//            return @"无";
//            break;
        case 11:
            return @"水平手掌";
            break;
        case 12:
            return @"拜年";
            break;
        case 13:
            return @"拍照";
            break;
        case 14:
            return @"双手爱心";
            break;
        case 15:
            return @"双手合十";
            break;
//        case 16:
//            return @"无";
//            break;
//        case 17:
//            return @"无";
//            break;
//        case 18:
//            return @"无";
//            break;
        default:
            return @"无";
            break;
    }
}

@end

//
//  AFUHelper.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFUHelper : NSObject

+ (void)setupParameters:(NSDictionary *)parameters;

/// 根据表情编码获取表情文字
+ (NSString *)expressionStringWithInt:(NSInteger)expressionInt;

/// 根据手势编码获取手势文字
+ (NSString *)gestureStringWithInt:(NSInteger)gestureInt;

@end

NS_ASSUME_NONNULL_END

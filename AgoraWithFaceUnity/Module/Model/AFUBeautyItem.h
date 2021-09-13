//
//  AFUBeautyItem.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/31.
//  美肤、美型
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFUBeautyItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *key;
/// 当前值
@property (nonatomic, assign) NSInteger value;
/// 默认值
@property (nonatomic, assign) NSInteger defaultValue;
/// 值类型（决定是否有负值）
@property (nonatomic, assign) NSInteger valueType;

@end

NS_ASSUME_NONNULL_END

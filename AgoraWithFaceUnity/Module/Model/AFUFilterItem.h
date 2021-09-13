//
//  AFUFilterItem.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/8.
//  滤镜
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFUFilterItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *icon;
/// 当前值
@property (nonatomic, assign) NSInteger value;

@end

NS_ASSUME_NONNULL_END

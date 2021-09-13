//
//  AFUSegment.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AFUSegmentType) {
    AFUSegmentTypeCheckAndDistinguish = 0,  // 检测与识别
    AFUSegmentTypeSkinBeauty,               // 美肤
    AFUSegmentTypeFaceBeauty,               // 美型
    AFUSegmentTypeFilter,                   // 滤镜
    AFUSegmentTypeSticker,                  // 贴纸
    AFUSegmentTypePortraitSegmentation      // 人像分割

};

@interface AFUSegment : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) AFUSegmentType type;
@property (nonatomic, copy) NSArray *items;

/// 程度值（暂时只有滤镜用到）
@property (nonatomic, assign) NSInteger levelValue;

@end

NS_ASSUME_NONNULL_END

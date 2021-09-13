//
//  AFUPortraitSegmentationItem.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFUPortraitSegmentationItem : NSObject

/// 是否选中
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;


@end

NS_ASSUME_NONNULL_END

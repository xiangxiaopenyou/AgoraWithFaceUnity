//
//  AFUFaceBeautyView.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/1.
//  美型

#import <UIKit/UIKit.h>
@class AFUBeautyItem;
@class AFUFaceBeautyView;

NS_ASSUME_NONNULL_BEGIN

@protocol AFUFaceBeautyViewDelegate <NSObject>

/// 值变化
- (void)faceBeautyViewDidChangeValue;
/// 恢复所有效果
- (void)faceBeautyViewShouldRecoverEffects;

@end

@interface AFUFaceBeautyView : UIView

@property (nonatomic, weak) id<AFUFaceBeautyViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<AFUBeautyItem *> *)items;

@end

NS_ASSUME_NONNULL_END

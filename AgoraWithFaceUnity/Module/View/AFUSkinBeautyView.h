//
//  AFUSkinBeautyView.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/30.
//  美肤
//

#import <UIKit/UIKit.h>
@class AFUBeautyItem;
@class AFUSkinBeautyView;

NS_ASSUME_NONNULL_BEGIN

@protocol AFUSkinBeautyViewDelegate <NSObject>

/// 值变化
- (void)skinBeautyViewDidChangeValue;
/// 恢复所有效果
- (void)skinBeautyViewShouldRecoverEffects;

@end

@interface AFUSkinBeautyView : UIView

@property (nonatomic, weak) id<AFUSkinBeautyViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<AFUBeautyItem *> *)items;

@end

NS_ASSUME_NONNULL_END

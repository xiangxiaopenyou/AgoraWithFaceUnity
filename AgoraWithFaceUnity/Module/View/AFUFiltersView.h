//
//  AFUFiltersView.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/30.
//  滤镜
//

#import <UIKit/UIKit.h>
@class AFUFiltersView;
@class AFUFilterItem;

NS_ASSUME_NONNULL_BEGIN

@protocol AFUFiltersViewDelegate <NSObject>

/// 滤镜变化和滤镜程度变化
- (void)filterView:(AFUFiltersView *)filterView didSelectFilterAtIndex:(NSInteger)index;

@end

@interface AFUFiltersView : UIView

@property (nonatomic, weak) id<AFUFiltersViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame filters:(NSArray<AFUFilterItem *> *)filters;

@end

@interface AFUFilterCell : UICollectionViewCell

@property (nonatomic, strong) AFUFilterItem *filter;

@end

NS_ASSUME_NONNULL_END

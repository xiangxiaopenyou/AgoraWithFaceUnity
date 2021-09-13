//
//  AFUPortraitSegmentationView.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/2.
//

#import <UIKit/UIKit.h>
@class AFUPortraitSegmentationView;

NS_ASSUME_NONNULL_BEGIN

@protocol AFUPortraitSegmentationViewDelegate <NSObject>

- (void)portraitSegmentationView:(AFUPortraitSegmentationView *)portraitSegmentationView didSelectAtIndex:(NSInteger)index;

@end

@interface AFUPortraitSegmentationView : UIView

@property (nonatomic, weak) id<AFUPortraitSegmentationViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

@end

@interface AFUPortraitSegmentationCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName;

@end

NS_ASSUME_NONNULL_END

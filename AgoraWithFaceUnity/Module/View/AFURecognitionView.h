//
//  AFURecognitionView.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/1.
//

#import <UIKit/UIKit.h>

@class AFURecognitionView;
@class AFUPortraitSegmentationItem;

NS_ASSUME_NONNULL_BEGIN

@protocol AFURecognitionViewDelegate<NSObject>

- (void)recognitionView:(nullable AFURecognitionView *)recognitionView didSelectAtIndex:(NSInteger)index isSelected:(BOOL)isSelected;

@end

@interface AFURecognitionView : UIView

@property (nonatomic, weak) id<AFURecognitionViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame recognitions:(NSArray<AFUPortraitSegmentationItem *> *)recognitions;

@end

@interface AFURecognitionCell : UICollectionViewCell

@property (nonatomic, strong) AFUPortraitSegmentationItem *informations;

@property (nonatomic, assign, getter=isRecognitionSelected) BOOL recognitionSelected;

@end

NS_ASSUME_NONNULL_END

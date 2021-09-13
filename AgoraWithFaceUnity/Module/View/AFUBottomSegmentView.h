//
//  AFUBottomSegmentView.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/25.
//
//  主页底部类型选择控件
//

#import <UIKit/UIKit.h>

@class AFUSegment;

NS_ASSUME_NONNULL_BEGIN

@protocol AFUBottomSegmentViewDelegate <NSObject>

- (void)segmentViewDidSelectSegmentAtIndex:(NSInteger)index;

@end

@interface AFUBottomSegmentView : UIView

@property (nonatomic, weak) id<AFUBottomSegmentViewDelegate> delegate;

- (instancetype)initWithSegments:(NSArray<AFUSegment *> *)segments;


@end

NS_ASSUME_NONNULL_END

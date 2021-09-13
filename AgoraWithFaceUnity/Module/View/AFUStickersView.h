//
//  AFUStickersView.h
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/31.
//  贴纸
//

#import <UIKit/UIKit.h>

@class AFUStickersView;

NS_ASSUME_NONNULL_BEGIN

@protocol AFUStickersViewDelegate <NSObject>

- (void)stickersView:(AFUStickersView *)stickersView didSelectStickerAtIndex:(NSInteger)index;

@end

@interface AFUStickersView : UIView

@property (nonatomic, weak) id<AFUStickersViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame stickers:(NSArray *)stickers;

@end

@interface AFUStickerCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName;

@end

NS_ASSUME_NONNULL_END

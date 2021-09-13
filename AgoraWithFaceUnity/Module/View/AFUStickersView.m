//
//  AFUStickersView.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/31.
//

#import "AFUStickersView.h"

static NSString * const kAFUStickerCellIdentifier = @"AFUStickerCell";

@interface AFUStickersView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *stickersCollection;

@property (nonatomic, copy) NSArray *stickers;

@end

@implementation AFUStickersView

#pragma mark - Initializer
- (instancetype)initWithFrame:(CGRect)frame stickers:(NSArray *)stickers {
    self = [super initWithFrame:frame];
    if (self) {
        self.stickers = [stickers copy];
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.stickersCollection];
        [self.stickersCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).mas_offset(5);
            make.leading.trailing.bottom.equalTo(self);
        }];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.alpha = 1.0;
        effectview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self insertSubview:effectview atIndex:0];
    }
    return self;
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stickers.count + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUStickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAFUStickerCellIdentifier forIndexPath:indexPath];
    cell.imageName = indexPath.item == 0 ? @"noitem" : self.stickers[indexPath.item - 1][@"icon"];
    return cell;
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(stickersView:didSelectStickerAtIndex:)]) {
        [self.delegate stickersView:self didSelectStickerAtIndex:indexPath.item - 1];
    }
}

#pragma mark - Getters
- (UICollectionView *)stickersCollection {
    if (!_stickersCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(14, 14, 14, 14);
        layout.itemSize = CGSizeMake(62, 62);
        layout.minimumLineSpacing = 6;
        layout.minimumInteritemSpacing = 0;
        _stickersCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _stickersCollection.backgroundColor = [UIColor clearColor];
        _stickersCollection.showsHorizontalScrollIndicator = NO;
        _stickersCollection.delegate = self;
        _stickersCollection.dataSource = self;
        [_stickersCollection registerClass:[AFUStickerCell class] forCellWithReuseIdentifier:kAFUStickerCellIdentifier];
    }
    return _stickersCollection;
}

@end

@interface AFUStickerCell ()

@property (nonatomic, strong) UIImageView *stickerImageView;

@end

@implementation AFUStickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.stickerImageView];
        [self.stickerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_offset(CGSizeMake(60, 60));
        }];
    }
    return self;
}

#pragma mark - Setters
- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.stickerImageView.layer.borderWidth = 2.5;
        self.stickerImageView.layer.borderColor = [UIColor colorFromHex:0x5EC7FE].CGColor;
    } else {
        self.stickerImageView.layer.borderWidth = 0;
        self.stickerImageView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.stickerImageView.image = [UIImage imageNamed:_imageName];
}

#pragma mark - Getters
- (UIImageView *)stickerImageView {
    if (!_stickerImageView) {
        _stickerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _stickerImageView.layer.masksToBounds = YES;
        _stickerImageView.layer.cornerRadius = 30.f;
    }
    return _stickerImageView;
}

@end

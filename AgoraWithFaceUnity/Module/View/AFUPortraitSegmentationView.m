//
//  AFUPortraitSegmentationView.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/2.
//

#import "AFUPortraitSegmentationView.h"

static NSString * const kAFUPortraitSegmentationCellIdentifier = @"AFUPortraitSegmentationCell";

@interface AFUPortraitSegmentationView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *items;

@end

@implementation AFUPortraitSegmentationView

#pragma mark - Initializer
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [items copy];
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    return self.items.count + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUPortraitSegmentationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAFUPortraitSegmentationCellIdentifier forIndexPath:indexPath];
    cell.imageName = indexPath.item == 0 ? @"noitem" : self.items[indexPath.item - 1][@"icon"];
    return cell;
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(portraitSegmentationView:didSelectAtIndex:)]) {
        [self.delegate portraitSegmentationView:self didSelectAtIndex:indexPath.item - 1];
    }
}

#pragma mark - Getters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(14, 14, 14, 14);
        layout.itemSize = CGSizeMake(62, 62);
        layout.minimumLineSpacing = 6;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        if (@available(iOS 13.0, *)) {
            _collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AFUPortraitSegmentationCell class] forCellWithReuseIdentifier:kAFUPortraitSegmentationCellIdentifier];
    }
    return _collectionView;
}

@end

@interface AFUPortraitSegmentationCell ()

@property (nonatomic, strong) UIImageView *portraitSegmentationImageView;

@end

@implementation AFUPortraitSegmentationCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.portraitSegmentationImageView];
        [self.portraitSegmentationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_offset(CGSizeMake(60, 60));
        }];
    }
    return self;
}

#pragma mark - Setters
- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.portraitSegmentationImageView.layer.borderWidth = 2.5;
        self.portraitSegmentationImageView.layer.borderColor = [UIColor colorFromHex:0x5EC7FE].CGColor;
    } else {
        self.portraitSegmentationImageView.layer.borderWidth = 0;
        self.portraitSegmentationImageView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.portraitSegmentationImageView.image = [UIImage imageNamed:_imageName];
}

#pragma mark - Getters
- (UIImageView *)portraitSegmentationImageView {
    if (!_portraitSegmentationImageView) {
        _portraitSegmentationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _portraitSegmentationImageView.layer.masksToBounds = YES;
        _portraitSegmentationImageView.layer.cornerRadius = 30.f;
    }
    return _portraitSegmentationImageView;
}

@end

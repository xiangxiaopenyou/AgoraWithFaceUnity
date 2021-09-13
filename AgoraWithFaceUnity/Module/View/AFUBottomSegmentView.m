//
//  AFUBottomSegmentView.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/25.
//

#import "AFUBottomSegmentView.h"
#import "AFUBottomSegmentCollectionViewCell.h"

#import "AFUSegment.h"

static NSString *kAFUBottomSegmentCollectionViewCellIdentifier = @"AFUBottomSegmentCollectionViewCell";

@interface AFUBottomSegmentView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *segmentCollection;

@property (nonatomic, copy) NSArray<AFUSegment *> *segmentsArray;

@end

@implementation AFUBottomSegmentView

#pragma mark - Initializer

- (instancetype)initWithSegments:(NSArray<AFUSegment *> *)segments {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, AFUScreenWidth, AFUDeviceIsiPhoneXStyle ? 83 : 49);
        self.backgroundColor = [UIColor colorFromHex:0x050F14 alpha:0.74];
        self.segmentsArray = [segments copy];
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5)];
        topLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self);
            make.height.mas_offset(0.5);
        }];
        
        [self addSubview:self.segmentCollection];
        [self.segmentCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self);
            make.height.mas_offset(49);
        }];
        
        if (segments.count > 0) {
            // 默认选中第一项
            [self.segmentCollection selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        }
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.alpha = 1.0;
        effectview.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [self insertSubview:effectview atIndex:0];
    }
    return self;
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.segmentsArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUBottomSegmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAFUBottomSegmentCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.title = self.segmentsArray[indexPath.item].title;
    return cell;
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 选中居中
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentViewDidSelectSegmentAtIndex:)]) {
        [self.delegate segmentViewDidSelectSegmentAtIndex:indexPath.item];
    }
}


#pragma mark - Collection view delegate flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUSegment *segment = self.segmentsArray[indexPath.item];
    NSString *title = segment.title;
    CGFloat titleWidth = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}].width;
    return CGSizeMake(titleWidth + 40, 39);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - Getters
- (UICollectionView *)segmentCollection {
    if (!_segmentCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _segmentCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 49) collectionViewLayout:flowLayout];
        _segmentCollection.backgroundColor = [UIColor clearColor];
        _segmentCollection.showsHorizontalScrollIndicator = NO;
        _segmentCollection.dataSource = self;
        _segmentCollection.delegate = self;
        [_segmentCollection registerClass:[AFUBottomSegmentCollectionViewCell class] forCellWithReuseIdentifier:kAFUBottomSegmentCollectionViewCellIdentifier];
    }
    return _segmentCollection;
}

@end

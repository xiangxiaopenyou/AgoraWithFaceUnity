//
//  AFURecognitionView.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/1.
//

#import "AFURecognitionView.h"
#import "AFUPortraitSegmentationItem.h"

static NSString * const kAFURecognitionCellIdentifier = @"AFURecognitionCell";

@interface AFURecognitionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *recognitionCollection;

@property (nonatomic, copy) NSArray<AFUPortraitSegmentationItem *> *recognitions;

@end

@implementation AFURecognitionView

#pragma mark - Initializer
- (instancetype)initWithFrame:(CGRect)frame recognitions:(NSArray<AFUPortraitSegmentationItem *> *)recognitions {
    self = [super initWithFrame:frame];
    if (self) {
        self.recognitions = recognitions;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.recognitionCollection];
        [self.recognitionCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self);
        }];
        
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
    return self.recognitions.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AFURecognitionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAFURecognitionCellIdentifier forIndexPath:indexPath];
    cell.informations = self.recognitions[indexPath.item];
    cell.recognitionSelected = self.recognitions[indexPath.item].isSelected;
    return cell;
}

#pragma mark - Colelction view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUPortraitSegmentationItem *item = self.recognitions[indexPath.item];
    item.selected = !item.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(recognitionView:didSelectAtIndex:isSelected:)]) {
        [self.delegate recognitionView:self didSelectAtIndex:indexPath.item isSelected:item.isSelected];
    }
    [self.recognitionCollection reloadData];
}

#pragma mark - Getters
- (UICollectionView *)recognitionCollection {
    if (!_recognitionCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 0, 16);
        layout.itemSize = CGSizeMake(50, 76);
        layout.minimumLineSpacing = 16;
        layout.minimumInteritemSpacing = 0;
        _recognitionCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _recognitionCollection.backgroundColor = [UIColor clearColor];
        _recognitionCollection.showsHorizontalScrollIndicator = NO;
        _recognitionCollection.delegate = self;
        _recognitionCollection.dataSource = self;
        [_recognitionCollection registerClass:[AFURecognitionCell class] forCellWithReuseIdentifier:kAFURecognitionCellIdentifier];
    }
    return _recognitionCollection;
}

@end

@interface AFURecognitionCell ()

@property (nonatomic, strong) UIImageView *recognitionImageView;
@property (nonatomic, strong) UILabel *recognitionNameLabel;

@end

@implementation AFURecognitionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.recognitionImageView];
        [self.recognitionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top);
            make.size.mas_offset(CGSizeMake(44, 44));
        }];
        
        [self.contentView addSubview:self.recognitionNameLabel];
        [self.recognitionNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.recognitionImageView.mas_bottom).mas_offset(8);
        }];
        
    }
    return self;
}

#pragma mark - Setters
- (void)setRecognitionSelected:(BOOL)recognitionSelected {
    _recognitionSelected = recognitionSelected;
    if (_recognitionSelected) {
        self.recognitionNameLabel.textColor = [UIColor colorFromHex:0x5EC7FE];
        self.recognitionImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", _informations.icon]];
    } else {
        self.recognitionNameLabel.textColor = [UIColor whiteColor];
        self.recognitionImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor", _informations.icon]];
    }
}

- (void)setInformations:(AFUPortraitSegmentationItem *)informations {
    _informations = informations;
    self.recognitionNameLabel.text = _informations.name;
    self.recognitionImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor", _informations.icon]];
}

#pragma mark - Getters
- (UIImageView *)recognitionImageView {
    if (!_recognitionImageView) {
        _recognitionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    }
    return _recognitionImageView;
}
- (UILabel *)recognitionNameLabel {
    if (!_recognitionNameLabel) {
        _recognitionNameLabel = [[UILabel alloc] init];
        _recognitionNameLabel.font = [UIFont systemFontOfSize:10];
        _recognitionNameLabel.textColor = [UIColor whiteColor];
    }
    return _recognitionNameLabel;
}

@end

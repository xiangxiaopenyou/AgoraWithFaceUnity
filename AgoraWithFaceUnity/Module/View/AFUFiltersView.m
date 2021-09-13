//
//  AFUFiltersView.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/30.
//

#import "AFUFiltersView.h"
#import "FUSlider.h"

#import "AFUFilterItem.h"

static NSString * const kAFUFilterCellIdentifier = @"AFUFilterCell";

@interface AFUFiltersView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) FUSlider *slider;
@property (nonatomic, strong) UICollectionView *filtersCollection;
// 原图按钮
@property (nonatomic, strong) UIButton *cancelFilterButton;
@property (nonatomic, strong) UILabel *cancelFilterLabel;

@property (nonatomic, copy) NSArray<AFUFilterItem *> *filters;
@property (nonatomic, strong) AFUFilterCell *selectedCell;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation AFUFiltersView

#pragma mark - Initializer
- (instancetype)initWithFrame:(CGRect)frame filters:(NSArray<AFUFilterItem *> *)filters {
    self = [super initWithFrame:frame];
    if (self) {
        self.filters = filters;
        
        // 默认选中原图
        _selectedIndex = -1;
        _selectedCell = nil;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).mas_offset(12);
            make.size.mas_offset(CGSizeMake(264, 20));
        }];
        
        [self addSubview:self.cancelFilterButton];
        [self.cancelFilterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading).mas_offset(16);
            make.top.equalTo(self.mas_top).mas_offset(56);
            make.size.mas_offset(CGSizeMake(54, 54));
        }];
        
        [self addSubview:self.cancelFilterLabel];
        [self.cancelFilterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.cancelFilterButton.mas_centerX);
            make.top.equalTo(self.cancelFilterButton.mas_bottom).mas_offset(8);
        }];
        
        [self addSubview:self.filtersCollection];
        [self.filtersCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.bottom.equalTo(self);
            make.leading.equalTo(self.mas_leading).mas_offset(88);
            make.top.equalTo(self.mas_top).mas_offset(51);
        }];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.alpha = 1.0;
        effectview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self insertSubview:effectview atIndex:0];
    }
    return self;
}

#pragma mark - Event response
- (void)cancelFilterAction {
    if (self.cancelFilterButton.selected) {
        return;
    }
    // 选中原图
    self.selectedCell.selected = NO;
    self.selectedCell = nil;
    _selectedIndex = -1;
    self.cancelFilterButton.layer.cornerRadius = 2.5;
    self.cancelFilterButton.layer.borderWidth = 2.5;
    self.cancelFilterButton.layer.borderColor = [UIColor colorFromHex:0x5EC7FE].CGColor;
    self.cancelFilterButton.selected = YES;
    self.cancelFilterLabel.textColor = [UIColor colorFromHex:0x5EC7FE];
    self.slider.hidden = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterView:didSelectFilterAtIndex:)]) {
        [self.delegate filterView:self didSelectFilterAtIndex:0];
    }
}

/// slider值变化事件
- (void)sliderValueChanged:(FUSlider *)slider {
    self.filters[self.selectedIndex].value = slider.value;
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterView:didSelectFilterAtIndex:)]) {
        [self.delegate filterView:self didSelectFilterAtIndex:_selectedIndex + 1];
    }
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filters.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUFilterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAFUFilterCellIdentifier forIndexPath:indexPath];
    cell.filter = self.filters[indexPath.item];
    return cell;
}

#pragma mark - Colelction view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUFilterCell *cell = (AFUFilterCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == self.selectedCell) {
        return;
    }
    if (self.cancelFilterButton.selected) {
        self.cancelFilterButton.selected = NO;
        self.cancelFilterButton.layer.cornerRadius = 0;
        self.cancelFilterButton.layer.borderWidth = 0;
        self.cancelFilterButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.cancelFilterLabel.textColor = [UIColor whiteColor];
    }
    self.slider.hidden = NO;
    self.slider.value = self.filters[indexPath.item].value;
    self.selectedCell = cell;
    _selectedIndex = indexPath.item;
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterView:didSelectFilterAtIndex:)]) {
        [self.delegate filterView:self didSelectFilterAtIndex:indexPath.item + 1];
    }
}

#pragma mark - Getters
- (FUSlider *)slider {
    if (!_slider) {
        _slider = [[FUSlider alloc] initWithFrame:CGRectMake(0, 0, 264, 20)];
        _slider.maximumValue = 100;
        _slider.type = 0;
        _slider.hidden = YES;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}
- (UIButton *)cancelFilterButton {
    if (!_cancelFilterButton) {
        _cancelFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelFilterButton setBackgroundImage:[UIImage imageNamed:@"noitem"] forState:UIControlStateNormal];
        // 默认选中原图
        _cancelFilterButton.layer.cornerRadius = 2.5;
        _cancelFilterButton.layer.borderWidth = 2.5;
        _cancelFilterButton.layer.borderColor = [UIColor colorFromHex:0x5EC7FE].CGColor;
        _cancelFilterButton.selected = YES;
        [_cancelFilterButton addTarget:self action:@selector(cancelFilterAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelFilterButton;
}
- (UILabel *)cancelFilterLabel {
    if (!_cancelFilterLabel) {
        _cancelFilterLabel = [[UILabel alloc] init];
        _cancelFilterLabel.textColor = [UIColor colorFromHex:0x5EC7FE];
        _cancelFilterLabel.font = [UIFont systemFontOfSize:10];
        _cancelFilterLabel.text = @"原图";
    }
    return _cancelFilterLabel;
}
- (UICollectionView *)filtersCollection {
    if (!_filtersCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(6, 2, 0, 2);
        layout.itemSize = CGSizeMake(59, 86);
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 0;
        _filtersCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _filtersCollection.backgroundColor = [UIColor clearColor];
        _filtersCollection.showsHorizontalScrollIndicator = NO;
        _filtersCollection.delegate = self;
        _filtersCollection.dataSource = self;
        [_filtersCollection registerClass:[AFUFilterCell class] forCellWithReuseIdentifier:kAFUFilterCellIdentifier];
    }
    return _filtersCollection;
}

@end



@interface AFUFilterCell ()

@property (nonatomic, strong) UIImageView *filterImageView;
@property (nonatomic, strong) UILabel *filterNameLabel;

@end

@implementation AFUFilterCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.filterImageView];
        [self.filterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top);
            make.size.mas_offset(CGSizeMake(54, 54));
        }];
        
        [self.contentView addSubview:self.filterNameLabel];
        [self.filterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.filterImageView.mas_bottom).mas_offset(8);
        }];
    }
    return self;
}

#pragma mark - Setters
- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.filterNameLabel.textColor = [UIColor colorFromHex:0x5EC7FE];
        self.filterImageView.layer.borderWidth = 2.5;
        self.filterImageView.layer.borderColor = [UIColor colorFromHex:0x5EC7FE].CGColor;
    } else {
        self.filterNameLabel.textColor = [UIColor whiteColor];
        self.filterImageView.layer.borderWidth = 0;
        self.filterImageView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
}

- (void)setFilter:(AFUFilterItem *)filter {
    _filter = filter;
    self.filterNameLabel.text = _filter.name;
    self.filterImageView.image = [UIImage imageNamed:_filter.icon];
}

#pragma mark - Getters
- (UIImageView *)filterImageView {
    if (!_filterImageView) {
        _filterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54, 54)];
        _filterImageView.layer.masksToBounds = YES;
        _filterImageView.layer.cornerRadius = 2.5;
    }
    return _filterImageView;
}
- (UILabel *)filterNameLabel {
    if (!_filterNameLabel) {
        _filterNameLabel = [[UILabel alloc] init];
        _filterNameLabel.font = [UIFont systemFontOfSize:10];
        _filterNameLabel.textColor = [UIColor whiteColor];
    }
    return _filterNameLabel;
}

@end

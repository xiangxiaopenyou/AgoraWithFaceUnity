//
//  AFUFaceBeautyView.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/1.
//

#import "AFUFaceBeautyView.h"
#import "AFUBeautyCell.h"
#import "FUSlider.h"
#import "AFUBeautyItem.h"

static NSString * const kAFUFaceBeautyCellIdentifier = @"AFUFaceBeautyCell";

@interface AFUFaceBeautyView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) FUSlider *slider;
@property (nonatomic, strong) UICollectionView *faceBeautyCollection;
/// 恢复按钮
@property (nonatomic, strong) UIButton *recoverButton;
@property (nonatomic, strong) UILabel *recoverLabel;

@property (nonatomic, copy) NSArray<AFUBeautyItem *> *itemsArray;
/// 当前选中组
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation AFUFaceBeautyView

#pragma mark - Initializer
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<AFUBeautyItem *> *)items {
    self = [super initWithFrame:frame];
    if (self) {
        self.itemsArray = items;
        _selectedIndex = 0;
        
        [self changeSliderValue];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).mas_offset(12);
            make.size.mas_offset(CGSizeMake(264, 20));
        }];
        
        [self addSubview:self.recoverButton];
        [self.recoverButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading).mas_offset(16);
            make.top.equalTo(self.mas_top).mas_offset(56);
            make.size.mas_offset(CGSizeMake(44, 44));
        }];
        
        [self addSubview:self.recoverLabel];
        [self.recoverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.recoverButton.mas_centerX);
            make.top.equalTo(self.recoverButton.mas_bottom).mas_offset(8);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorFromHex:0xFFFFFF alpha:0.2];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.recoverButton.mas_trailing).mas_offset(13);
            make.centerY.equalTo(self.recoverButton.mas_centerY);
            make.size.mas_offset(CGSizeMake(0.5, 20));
        }];
        
        [self addSubview:self.faceBeautyCollection];
        [self.faceBeautyCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.bottom.equalTo(self);
            make.leading.equalTo(self.mas_leading).mas_offset(74);
            make.top.equalTo(self.mas_top).mas_offset(51);
        }];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.alpha = 1.0;
        effectview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self insertSubview:effectview atIndex:0];
        
        // 134
    }
    return self;
}

#pragma mark - Private methods
- (void)changeSliderValue {
    self.slider.value = self.itemsArray[_selectedIndex].value;
}

#pragma mark - Event response
/// 恢复按钮点击事件
- (void)recoverAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否将所有参数恢复到默认值" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [cancelAction setValue:[UIColor colorWithRed:44/255.0 green:46/255.0 blue:48/255.0 alpha:1.0] forKey:@"titleTextColor"];
    UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(faceBeautyViewShouldRecoverEffects)]) {
            [self.delegate faceBeautyViewShouldRecoverEffects];
            [self changeSliderValue];
            [self.faceBeautyCollection reloadData];
            self.recoverButton.userInteractionEnabled = NO;
            self.recoverButton.alpha = 0.6;
            self.recoverLabel.alpha = 0.6;
        }
    }];
    [certainAction setValue:[UIColor colorWithRed:31/255.0 green:178/255.0 blue:255/255.0 alpha:1.0] forKey:@"titleTextColor"];
    
    [alert addAction:cancelAction];
    [alert addAction:certainAction];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

/// slider值变化事件
- (void)sliderValueChanged:(FUSlider *)slider {
    self.itemsArray[_selectedIndex].value = slider.value;
    if (self.delegate && [self.delegate respondsToSelector:@selector(faceBeautyViewDidChangeValue)]) {
        [self.delegate faceBeautyViewDidChangeValue];
    }
}

/// slider滑动结束
- (void)sliderEnded:(FUSlider *)slider {
    // 根据值是否变化改变恢复按钮状态
    BOOL hasChanged = NO;
    for (AFUBeautyItem *item in self.itemsArray) {
        if (item.value != item.defaultValue) {
            // 发生了变化
            hasChanged = YES;
        }
    }
    if (hasChanged) {
        self.recoverButton.userInteractionEnabled = YES;
        self.recoverButton.alpha = 1;
        self.recoverLabel.alpha = 1;
        // 刷新cell
        [self.faceBeautyCollection reloadData];
    } else {
        self.recoverButton.userInteractionEnabled = NO;
        self.recoverButton.alpha = 0.6;
        self.recoverLabel.alpha = 0.6;
    }
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AFUBeautyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAFUFaceBeautyCellIdentifier forIndexPath:indexPath];
    cell.beautyItem = self.itemsArray[indexPath.item];
    cell.selected = indexPath.item == _selectedIndex;
    
    return cell;
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _selectedIndex) {
        return;
    }
    _selectedIndex = indexPath.item;
    self.slider.type = self.itemsArray[indexPath.item].valueType;
    [self changeSliderValue];
    [collectionView reloadData];
}

#pragma mark - Getters
- (FUSlider *)slider {
    if (!_slider) {
        _slider = [[FUSlider alloc] initWithFrame:CGRectMake(0, 0, 264, 20)];
        _slider.maximumValue = 100;
        _slider.type = 0;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderEnded:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _slider;
}
- (UIButton *)recoverButton {
    if (!_recoverButton) {
        _recoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recoverButton setImage:[UIImage imageNamed:@"recover"] forState:UIControlStateNormal];
        [_recoverButton addTarget:self action:@selector(recoverAction) forControlEvents:UIControlEventTouchUpInside];
        // 默认无法点击
        _recoverButton.alpha = 0.6;
        _recoverButton.userInteractionEnabled = NO;
    }
    return _recoverButton;
}
- (UILabel *)recoverLabel {
    if (!_recoverLabel) {
        _recoverLabel = [[UILabel alloc] init];
        _recoverLabel.textColor = [UIColor whiteColor];
        _recoverLabel.font = [UIFont systemFontOfSize:10];
        _recoverLabel.text = @"恢复";
        _recoverLabel.alpha = 0.6;
    }
    return _recoverLabel;
}
- (UICollectionView *)faceBeautyCollection {
    if (!_faceBeautyCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(6, 12, 0, 12);
        layout.itemSize = CGSizeMake(50, 76);
        layout.minimumLineSpacing = 16;
        layout.minimumInteritemSpacing = 0;
        _faceBeautyCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _faceBeautyCollection.backgroundColor = [UIColor clearColor];
        _faceBeautyCollection.showsHorizontalScrollIndicator = NO;
        _faceBeautyCollection.delegate = self;
        _faceBeautyCollection.dataSource = self;
        [_faceBeautyCollection registerClass:[AFUBeautyCell class] forCellWithReuseIdentifier:kAFUFaceBeautyCellIdentifier];
    }
    return _faceBeautyCollection;
}

@end

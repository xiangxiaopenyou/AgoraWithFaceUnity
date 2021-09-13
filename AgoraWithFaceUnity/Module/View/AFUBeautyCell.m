//
//  AFUBeautyCell.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/31.
//

#import "AFUBeautyCell.h"

#import "AFUBeautyItem.h"

@interface AFUBeautyCell ()

@property (nonatomic, strong) UIImageView *beautyImageView;
@property (nonatomic, strong) UILabel *beautyNameLabel;

@end

@implementation AFUBeautyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.beautyImageView];
        [self.beautyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top);
            make.size.mas_offset(CGSizeMake(44, 44));
        }];
        
        [self.contentView addSubview:self.beautyNameLabel];
        [self.beautyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.beautyImageView.mas_bottom).mas_offset(8);
        }];
    }
    return self;
}

#pragma mark - Setters
- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.beautyNameLabel.textColor = [UIColor colorFromHex:0x5EC7FE];
        if (_beautyItem.valueType == 1) {
            if (self.beautyItem.value == 50) {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-2", self.beautyItem.icon]];
            } else {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-3", self.beautyItem.icon]];
            }
        } else {
            if (self.beautyItem.value > 0) {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-3", self.beautyItem.icon]];
            } else {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-2", self.beautyItem.icon]];
            }
        }
    } else {
        self.beautyNameLabel.textColor = [UIColor whiteColor];
        if (_beautyItem.valueType == 1) {
            if (_beautyItem.value == 50) {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-0", _beautyItem.icon]];
            } else {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-1", _beautyItem.icon]];
            }
        } else {
            if (_beautyItem.value > 0) {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-1", _beautyItem.icon]];
            } else {
                self.beautyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-0", _beautyItem.icon]];
            }
        }
    }
}

- (void)setBeautyItem:(AFUBeautyItem *)beautyItem {
    _beautyItem = beautyItem;
    self.beautyNameLabel.text = _beautyItem.name;
}

#pragma mark - Getters
- (UIImageView *)beautyImageView {
    if (!_beautyImageView) {
        _beautyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    }
    return _beautyImageView;
}
- (UILabel *)beautyNameLabel {
    if (!_beautyNameLabel) {
        _beautyNameLabel = [[UILabel alloc] init];
        _beautyNameLabel.font = [UIFont systemFontOfSize:10];
        _beautyNameLabel.textColor = [UIColor whiteColor];
    }
    return _beautyNameLabel;
}

@end

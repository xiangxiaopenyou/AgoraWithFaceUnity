//
//  AFUBottomSegmentCollectionViewCell.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/3/29.
//

#import "AFUBottomSegmentCollectionViewCell.h"

@interface AFUBottomSegmentCollectionViewCell ()

@property (nonatomic, strong) UILabel *itemLabel;

@end

@implementation AFUBottomSegmentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.itemLabel];
        [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    self.itemLabel.textColor = selected ? [UIColor colorFromHex:0x5EC7FE] : [UIColor whiteColor];
}

#pragma mark - Setters
- (void)setTitle:(NSString *)title {
    _title = title;
    self.itemLabel.text = _title;
}

#pragma mark - Getters
- (UILabel *)itemLabel {
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.font = [UIFont systemFontOfSize:13];
        _itemLabel.textColor = [UIColor whiteColor];
    }
    return _itemLabel;
}




@end

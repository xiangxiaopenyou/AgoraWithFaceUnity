//
//  AFUInsetsLabel.m
//  AgoraWithFaceUnity
//
//  Created by 项林平 on 2021/4/6.
//

#import "AFUInsetsLabel.h"

@interface AFUInsetsLabel ()

@property (nonatomic, assign) UIEdgeInsets insets;

@end

@implementation AFUInsetsLabel

- (instancetype)initWithFrame:(CGRect)frame insets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if (self) {
        self.insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}


- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width  += self.insets.left + self.insets.right;
    size.height += self.insets.top + self.insets.bottom;
    return size;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize fitSize = [super sizeThatFits:size];
    fitSize.width  += self.insets.left + self.insets.right;
    fitSize.height += self.insets.top + self.insets.bottom;
    return fitSize;
}

@end

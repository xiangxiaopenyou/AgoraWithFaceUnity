//
//  FUSlider.m
//  FUAPIDemoBar
//
//  Created by L on 2018/6/27.
//  Copyright © 2018年 L. All rights reserved.
//

#import "FUSlider.h"

@implementation FUSlider
{
    UILabel *tipLabel;
    UIImageView *bgImgView;
    
    UIView *middleView ;
    UIView *line ;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setThumbImage:[UIImage imageNamed:@"makeup_dot"] forState:UIControlStateNormal];
    
    UIImage *bgImage = [UIImage imageNamed:@"slider_tip_bg"];
    bgImgView = [[UIImageView alloc] initWithImage:bgImage];
    bgImgView.frame = CGRectMake(0, -bgImage.size.height, bgImage.size.width, bgImage.size.height);
    [self addSubview:bgImgView];
    
    tipLabel = [[UILabel alloc] initWithFrame:bgImgView.frame];
    tipLabel.text = @"";
    tipLabel.textColor = [UIColor darkGrayColor];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:tipLabel];
    
    bgImgView.hidden = YES;
    tipLabel.hidden = YES;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {//makeup_dot
        [self setThumbImage:[UIImage imageNamed:@"makeup_dot"] forState:UIControlStateNormal];
        UIImage *bgImage = [UIImage imageNamed:@"slider_tip_bg"];
        bgImgView = [[UIImageView alloc] initWithImage:bgImage];
        bgImgView.frame = CGRectMake(0, -bgImage.size.height, bgImage.size.width, bgImage.size.height);
        [self addSubview:bgImgView];
        
        tipLabel = [[UILabel alloc] initWithFrame:bgImgView.frame];
        tipLabel.text = @"";
        tipLabel.textColor = [UIColor darkGrayColor];
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:tipLabel];
        
        bgImgView.hidden = YES;
        tipLabel.hidden = YES;
       
        self.maximumTrackTintColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (!middleView) {
        middleView = [[UIView alloc] initWithFrame:CGRectMake(2, self.frame.size.height /2.0 - 1, 100, 4)];
        middleView.backgroundColor = [UIColor colorFromHex:0X5EC7FE];
        middleView.hidden = YES;
    }
    
    if (!line) {
        line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        line.layer.masksToBounds = YES ;
        line.layer.cornerRadius = 1.0 ;
        line.hidden = YES;
        [self insertSubview:line atIndex: self.subviews.count - 1];
    }
    [self insertSubview:middleView atIndex: self.subviews.count - 2];
    
    line.frame = CGRectMake(self.frame.size.width / 2.0 - 1.0, 4.0, 2.0, self.frame.size.height - 8.0) ;
    
    CGFloat value = self.value ;
    [self setValue:value animated:NO];
}

- (void)setType:(NSInteger)type {
    _type = type ;
    if (type == 1) {
        line.hidden = NO ;
        middleView.hidden = NO ;
        [self setMinimumTrackTintColor:[UIColor whiteColor]];
    } else {
        line.hidden = YES ;
        middleView.hidden = YES ;
        [self setMinimumTrackTintColor:[UIColor colorFromHex:0X5EC7FE]];
    }
}


// 后设置 value
- (void)setValue:(float)value animated:(BOOL)animated   {
    [super setValue:value animated:animated];
    
    NSLog(@"%@", @(value));
    
    if (_type == 1) {
        tipLabel.text = [NSString stringWithFormat:@"%@", @((int)value - 50)];
        
        CGFloat currentValue = value - 50;
        CGFloat width = (currentValue / self.maximumValue) * (self.frame.size.width - 4);
        if (width < 0 ) {
            width = -width ;
        }
        CGFloat X = currentValue > 0 ? self.frame.size.width / 2.0 : self.frame.size.width / 2.0 - width ;
        
        CGRect frame = middleView.frame ;
        frame = CGRectMake(X, frame.origin.y, width, frame.size.height) ;
        middleView.frame = frame ;
        
        NSLog(@"----frame---%@",NSStringFromCGRect(frame));
    } else {
        tipLabel.text = [NSString stringWithFormat:@"%d",(int)value];
    }
    
    CGFloat x = (value / self.maximumValue) * (self.frame.size.width - 20) - tipLabel.frame.size.width * 0.5 + 10;
    CGRect frame = tipLabel.frame;
    frame.origin.x = x;
    
    bgImgView.frame = frame;
    tipLabel.frame = frame;
    tipLabel.hidden = !self.tracking;
    bgImgView.hidden = !self.tracking;
    
}

@end

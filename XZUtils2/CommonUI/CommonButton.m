//
//  CommonButton.m
//  Daipai
//
//  Created by kun on 2020/5/11.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonButton.h"

@implementation CommonButton


/**
 常规的一种初始化方法
 
 @param buttonType 按钮类型
 @param frame 视图大小
 @param titleColor 字体颜色
 @param font 字体
 @return UIButton
 */
+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame titleColor:(UIColor *)titleColor font:(UIFont *)font {
    CommonButton *button = [CommonButton buttonWithType:buttonType];
    button.frame = frame;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

- (void)verticalImageAndTitle:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil];
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:dict];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if ((titleSize.width + .5f) < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height+titleSize.height+spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight-imageSize.height), 0, 0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight-titleSize.height), 0);
}

- (void)horizonImageAndTitle:(CGFloat)spacing {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil];
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:dict];
    CGFloat width = MIN(self.bounds.size.width, titleSize.width+spacing/2.f);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, width, 0, -width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -spacing/2.f*3, 0, spacing/2.f*3);
}

@end

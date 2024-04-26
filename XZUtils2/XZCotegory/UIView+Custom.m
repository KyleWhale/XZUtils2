//
//  UIView+Custom.m
//  XZYiBoEducation
//
//  Created by mac on 2019/11/9.
//  Copyright © 2019 ybed. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)


-(void)generateViewSpecifyCorners:(UIRectCorner)rectCorners corners:(CGFloat)corner cgrect:(CGRect)rect{
    
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:rectCorners cornerRadii:CGSizeMake(corner,corner)];
    // 圆角大小
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.masksToBounds = YES;
    self.layer.mask = maskLayer;
}

@end

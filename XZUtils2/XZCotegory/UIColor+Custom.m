//
//  UIColor+Custom.m
//  EducationOL
//
//  Created by yibomacmini on 2022/9/2.
//

#import "UIColor+Custom.h"

#import <objc/runtime.h>


@implementation UIColor (Custom)


///将颜色转成hex值
- (NSString *)hexString {
    
    const CGFloat * value =  CGColorGetComponents(self.CGColor);
    CGFloat alpha =  CGColorGetAlpha(self.CGColor);
    CGFloat red, green, blue;
    
    
    red = roundf(value[0] * 255.f);
    green = roundf(value[1] * 255.f);
    blue = roundf(value[2] * 255.f);
    alpha = roundf(alpha * 255.f);
    
    uint hex = ((uint)alpha << 24) | ((uint)red << 16) | ((uint)green << 8) | ((uint)blue);
    NSLog(@"%u",hex);
    return [NSString stringWithFormat:@"#%08x", hex];
}


// 获取颜色值的RGBA
+ (NSArray *)getRGBWithColor:(UIColor *)color {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}
@end

//
//  UIColor+Custom.h
//  EducationOL
//
//  Created by yibomacmini on 2022/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Custom)

//将颜色转化为色值
- (NSString *)hexString;

// 根据颜色 获取 r g b 值
+ (NSArray *)getRGBWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END

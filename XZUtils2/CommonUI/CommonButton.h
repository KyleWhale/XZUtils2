//
//  BCommonutton.h
//  Daipai
//
//  Created by kun on 2020/5/11.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonButton : UIButton

/**
 常规的一种初始化方法
 
 @param buttonType 按钮类型
 @param frame 视图大小
 @param titleColor 字体颜色
 @param font 字体
 @return UIButton
 */
+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**图文混排按钮 【上下】*/
- (void)verticalImageAndTitle:(CGFloat)spacing;

/**图文混排按钮 【左右】*/
- (void)horizonImageAndTitle:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END

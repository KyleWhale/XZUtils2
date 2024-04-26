//
//  UIButton+Custom.h
//  XZYiBoEducation
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 ybed. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    UIButtonEdgeInsetsStyleTop,
    UIButtonEdgeInsetsStyleLeft,
    UIButtonEdgeInsetsStyleBottom,
    UIButtonEdgeInsetsStyleRight,
}UIButtonEdgeInsetsStyle;

@interface UIButton (Custom)

//按钮是否点击高亮 默认点击有高亮效果
@property (copy, nonatomic) NSString *notHighlight;

//用来保存高亮前的颜色
@property (copy, nonatomic) UIColor *originColor;

/**
 *style：内容的位置，
 *space：图片和文字之间的距离
 *offset：内容距离边界的偏移
 */
- (void)layoutButtonWithEdgeInsetsStyle:(UIButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space offset:(CGFloat)offset;

//点击高亮扩展方法
- (void)touchesBegan:(NSSet *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(nullable UIEvent *)event;

@end

NS_ASSUME_NONNULL_END

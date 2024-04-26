//
//  CommonLabel.h
//  Daipai
//
//  Created by kun on 2020/5/11.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonLabel : UILabel

/**
 自定义label
 
 @param frame 视图大小
 @param font 字体
 @param text 文字
 @param textcolor  字体的颜色
 @param alignment  对齐方式
 @param lines  行数 <默认1行>
 @return UILabel
 */
- (instancetype)initWithFrame:(CGRect)frame
                         font:(UIFont *)font
                         text:(NSString *)text
                    textColor:(UIColor *)textcolor
                textAlignment:(NSTextAlignment)alignment
                numberOfLines:(NSInteger)lines;

/**
 自定义label
 
 @param frame 视图大小
 @param font 字体
 @param text 文字
 @param textcolor  字体的颜色
 @param alignment  对齐方式
 @param lines  行数 <默认1行>
 @param breakModel 换行方式 <系统默认的方式>
 @return UILabel
 */
- (instancetype)initWithFrame:(CGRect)frame
                         font:(UIFont *)font
                         text:(NSString *)text
                    textColor:(UIColor *)textcolor
                textAlignment:(NSTextAlignment)alignment
                numberOfLines:(NSInteger)lines
                lineBreakMode:(NSLineBreakMode)breakModel;

- (void)setFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment)alignment;
- (void)setFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)lines;

@end

NS_ASSUME_NONNULL_END

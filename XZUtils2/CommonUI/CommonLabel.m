//
//  CommonLabel.m
//  Daipai
//
//  Created by kun on 2020/5/11.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonLabel.h"

@implementation CommonLabel

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
                numberOfLines:(NSInteger)lines {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = font;
        self.textColor = textcolor;
        self.text = (text ?: @"");
        self.textAlignment = alignment;
        self.numberOfLines = lines;
        self.backgroundColor = [UIColor clearColor];
//        self.adjustsFontSizeToFitWidth = (lines == 1);
        [self needsUpdateConstraints];
    }
    return self;
}

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
                lineBreakMode:(NSLineBreakMode)breakModel {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = font;
        self.textColor = textcolor;
        self.text = (text ?: @"");
        self.textAlignment = alignment;
        self.numberOfLines = lines;
        self.lineBreakMode = breakModel;
        self.backgroundColor = [UIColor clearColor];
//        self.adjustsFontSizeToFitWidth = (lines == 1);
    }
    return self;
}

- (void)setFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment)alignment {
    if (self) {
        [self setFont:font text:text textColor:textcolor textAlignment:alignment numberOfLines:0];
    }
}

- (void)setFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)lines {
    if (self) {
        self.font = font;
        self.textColor = textcolor;
        self.text = (text ?: @"");
        self.textAlignment = alignment;
        self.numberOfLines = lines;
//        self.adjustsFontSizeToFitWidth = (lines == 1);
    }
}

@end

//
//  CommonTextField.m
//  Daipai
//
//  Created by lxinfo on 2020/5/25.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonTextField.h"

@implementation CommonTextField

// MARK: init 初始化方法
/**
 自定义textField
 
 @param frame 视图大小
 @param font 字体
 @param textcolor  字体的颜色
 @param alignment  对齐方式
 @param placeholder 占位文字
 @param keyboardType 键盘类型
 @return UITextField
 */
- (instancetype)initWithFrame:(CGRect)frame
                         font:(UIFont *)font
                    textColor:(UIColor *)textcolor
                    alignment:(NSTextAlignment)alignment
                  placeholder:(NSString *)placeholder
                 keyboardType:(UIKeyboardType)keyboardType {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = font;
        self.textColor = textcolor;
        self.textAlignment = alignment;
        self.placeholder = placeholder;
        self.keyboardType = keyboardType;
        //self.tintColor = [GlobalFile textColorWithRed];
    }
    return self;
}

@end

//
//  UIButton+Custom.m
//  XZYiBoEducation
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 ybed. All rights reserved.
//

#import "UIButton+Custom.h"
#import <objc/runtime.h>
#import "UIColor+Custom.h"

const NSString* GlobleFont = @"isGlobleFont";

@implementation UIButton (Custom)

static char *notHighlightKey = "notHighlightKey";

static char *originColorKey = "originColorKey";

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(willMoveToSuperview:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(myWillMoveToSuperview:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)myWillMoveToSuperview:(UIView *)newSuperview
{
    [self myWillMoveToSuperview:newSuperview];
    //去除按钮高亮状态
    self.notHighlight = @"1";
}

- (void)layoutButtonWithEdgeInsetsStyle:(UIButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space offset:(CGFloat)offset{
    CGFloat imageWith = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if (@available(iOS 8.0, *)) {
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case UIButtonEdgeInsetsStyleTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space, 0);
        }
            break;
        case UIButtonEdgeInsetsStyleLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, 0);
            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight){
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space/2.0+offset);
                labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, offset);
            }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                imageEdgeInsets = UIEdgeInsetsMake(0, offset, 0, space/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0+offset, 0, 0);
            }
        }
            break;
        case UIButtonEdgeInsetsStyleBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space, -imageWith, 0, 0);
        }
            break;
        case UIButtonEdgeInsetsStyleRight: {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space, 0, -labelWidth-space);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space, 0, imageWith+space);
            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight){
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space, 0, -labelWidth+offset);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space, 0, imageWith+space+offset);
            }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space+offset, 0, -labelWidth-space);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith+offset, 0, imageWith+space);
            }
            
        }
            break;
        default:
            break;
    }
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
 
- (void)setNotHighlight:(NSString *)notHighlight {
    objc_setAssociatedObject(self, notHighlightKey, notHighlight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)notHighlight{
    return objc_getAssociatedObject(self, notHighlightKey);
}

-(void)setOriginColor:(UIColor *)originColor{
    objc_setAssociatedObject(self, originColorKey, originColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(UIColor *)originColor{
    return objc_getAssociatedObject(self, originColorKey);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //获取原背景色以便恢复
    self.originColor = self.backgroundColor;
    //如果主动设置不高亮或背景色等于主色调则不高亮
    if (self.notHighlight || [self.backgroundColor.hexString isEqualToString:@"f92c1b"]){
    }else{
        if (self.layer.cornerRadius <= 0){ //本身没有圆角的加个高亮圆角
            self.layer.cornerRadius = 10.1;//为了区分取特殊值
        }
        //设置高亮背景色
        [self setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (self.layer.cornerRadius == 10.1){
        self.layer.cornerRadius = 0;
    }
    if (self.notHighlight  || [self.backgroundColor.hexString isEqualToString:@"f92c1b"]){
    }else{
        [self setBackgroundColor:self.originColor];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (self.layer.cornerRadius == 10.1){
        self.layer.cornerRadius = 0;
    }
    if (self.notHighlight  || [self.backgroundColor.hexString isEqualToString:@"f92c1b"]){
    }else{
        [self setBackgroundColor:self.originColor];
    }
}
@end


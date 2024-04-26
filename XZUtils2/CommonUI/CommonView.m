//
//  CommonView.m
//  Daipai
//
//  Created by kun on 2020/5/12.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView

/**
 自定义view
 
 @param frame 视图大小
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.frame = frame;
    }
    return self;
}

/**
 自定义view
 
 @param frame 视图大小
 @param cornerRadius 圆角弧度
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame
                 cornerRadius:(CGFloat)cornerRadius {
    self = [self initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
    }
    return self;
}

/**
 自定义view
 
 @param frame 视图大小
 @param cornerRadius 圆角弧度
 @param masksToBounds  layer.masksToBounds
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame
                 cornerRadius:(CGFloat)cornerRadius
                masksToBounds:(BOOL)masksToBounds {
    self = [self initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = masksToBounds;
    }
    return self;
}

@end

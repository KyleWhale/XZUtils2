//
//  UIView+Custom.h
//  XZYiBoEducation
//
//  Created by mac on 2019/11/9.
//  Copyright © 2019 ybed. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Custom)

//圆角
- (void)generateViewSpecifyCorners:(UIRectCorner)rectCorners corners:(CGFloat)corner cgrect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END

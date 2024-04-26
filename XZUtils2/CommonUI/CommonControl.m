//
//  CommonControl.m
//  Daipai
//
//  Created by kun on 2020/5/12.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonControl.h"

@implementation CommonControl

/**
 自定义control
 
 @param frame 视图大小
 @param target self
 @param action  @selector()
 @param forControlEvents UIControlEvents
 @return UIControl
 */
- (instancetype)initWithFrame:(CGRect)frame
                       target:(id)target
                       action:(SEL)action
             forControlEvents:(UIControlEvents)forControlEvents {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:action forControlEvents:forControlEvents];
    }
    return self;
}

// 展示弹窗
- (void)showAlertView {
    _isShow = YES;
}

// 隐藏弹窗
- (void)hideAlertView {
    _isShow = NO;
}

@end

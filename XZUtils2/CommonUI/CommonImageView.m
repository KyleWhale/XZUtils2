//
//  CommonImageView.m
//  Daipai
//
//  Created by kun on 2020/5/12.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonImageView.h"

@implementation CommonImageView

- (instancetype)init {
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.layer.masksToBounds = YES;
    }
    return self;
}

/**
 自定义imageView
 
 @param frame 视图大小
 @param contentMode UIViewContentMode
 @param masksToBounds  layer.masksToBounds
 @return UIImageView
 */
- (instancetype)initWithFrame:(CGRect)frame
                  contentMode:(UIViewContentMode)contentMode
                masksToBounds:(BOOL)masksToBounds {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = contentMode;
        self.layer.masksToBounds = masksToBounds;
    }
    return self;
}

- (BOOL)isHaveAnimation {
    return self.layer.animationKeys.count;
}

// CABasicAnimation 实现旋转动画
- (void)addRotationImgAnimation {
    // 1.创建动画对象
    // 默认是按Z轴旋转
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 2.设置动画属性
    [rotationAnimation setToValue:@(2*M_PI)]; // 2*M_PI 旋转一周
    [rotationAnimation setDuration:1.f];
    // 动画完成后，是否从CALayer上移除动画对象
    //[rotationAnimation setRemovedOnCompletion:YES];
    rotationAnimation.cumulative = YES;
    // 设置重复次数，HUGE_VALF是一个非常大的浮点数
    [rotationAnimation setRepeatCount:HUGE_VALF];
    // 动画根据锚点旋转的
    // 修改锚点
    //[self.layer setAnchorPoint:CGPointMake(0, 0)];
    // 3.添加动画
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

// 暂停动画
- (void)pauseImgAnimation {
    //（0-5）
    // 开始时间：0
    //self.layer.beginTime
    
    // 1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    // 2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    self.layer.timeOffset = pauseTime;
    // 3.将动画的运行速度设置为0，默认的运行速度是1.0
    self.layer.speed = 0.f;
}

// 恢复动画
- (void)resumeImgAnimation {
    // 1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = self.layer.timeOffset;
    // 2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    [self.layer setTimeOffset:0];
    [self.layer setBeginTime:begin];
    self.layer.speed = 1.f;
}

// 删除指定动画
- (void)removeImgAnimationWithKey:(NSString *)key {
    [self.layer removeAnimationForKey:key];
}

// 删除所有动画
- (void)removeAllImgAnimation {
    [self.layer removeAllAnimations];
}

@end

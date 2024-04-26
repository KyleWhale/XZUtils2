//
//  CommonImageView.h
//  Daipai
//
//  Created by kun on 2020/5/12.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonImageView : UIImageView

/**
 自定义imageView
 
 @param frame 视图大小
 @param contentMode UIViewContentMode 默认UIViewContentModeScaleToFill
 @param masksToBounds  layer.masksToBounds
 @return UIImageView
 */
- (instancetype)initWithFrame:(CGRect)frame
                  contentMode:(UIViewContentMode)contentMode
                masksToBounds:(BOOL)masksToBounds;

/**是否有动画*/
@property (nonatomic, assign) BOOL isHaveAnimation;

// CABasicAnimation 实现旋转动画
- (void)addRotationImgAnimation;

// 暂停动画
- (void)pauseImgAnimation;

// 恢复动画
- (void)resumeImgAnimation;

// 删除指定动画
- (void)removeImgAnimationWithKey:(NSString *)key;

// 删除所有动画
- (void)removeAllImgAnimation;

@end

NS_ASSUME_NONNULL_END

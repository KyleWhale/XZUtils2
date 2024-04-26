//
//  UIImage+HPAdditions.h
//  EducationOL
//
//  Created by apple on 2021/8/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, GradientType) {
    /// 从左到右
    GradientTypeL2R,
    /// 从上到下
    GradientTypeT2B,
};
@interface UIImage (HPAdditions)

/**
 获取颜色渐变图片
 
 @param startColor 开始颜色值
 @param endColor 结束颜色值
 @return 颜色渐变Image对象
 */
+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;
+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size direction:(GradientType)direction;

/// 获取一个旋转后的图片
/// @param image 原始图片
/// @param degree 旋转度数
+ (UIImage *)ehs_imageWithRotation:(UIImage *)image rotationDegree:(CGFloat)degree;

+ (UIImage *)image:(UIImage *)oriImage RotatedByRadians:(CGFloat)radians;
// cgcontext 裁剪
+ (UIImage *)cgcontextclip:(UIImage *)img cornerradius:(CGFloat)c;
/// 获取网络图片大小
/// @param URL 网络图片链接
+ (CGSize)getImageSizeWithURL:(id)URL;

@end

NS_ASSUME_NONNULL_END

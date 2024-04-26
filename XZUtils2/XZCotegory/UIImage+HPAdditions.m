//
//  UIImage+HPAdditions.m
//  EducationOL
//
//  Created by apple on 2021/8/25.
//

#import "UIImage+HPAdditions.h"
#import<QuartzCore/QuartzCore.h>
#import<Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h>

@implementation UIImage (HPAdditions)

#pragma mark ===== 颜色渐变图片 =====
+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size direction:(GradientType)direction {
//+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    //绘制三角Path
    //    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    //    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    //    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    ////    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetHeight(rect));
    //    CGPathCloseSubpath(path);
    
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rect);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    [self drawLinearGradient:context path:path startColor:startColor.CGColor endColor:endColor.CGColor direction:direction];
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //    CGContextSetFillColorWithColor(context, [startColor CGColor]);//在这段上下文中获取到颜色UIColor
    //
    //    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size {
    return   [self imageWithStartColor:startColor endColor:endColor size:size direction:GradientTypeL2R];
}

+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor direction:(GradientType)direction {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    if (direction == GradientTypeT2B) {
        startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
        endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    }
    
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (UIImage *)ehs_imageWithRotation:(UIImage *)image rotationDegree:(CGFloat)degree {
    //将image转化成context
    //获取图片像素的宽和高
    size_t width =  image.size.width * image.scale;
    size_t height = image.size.height * image.scale;
    
    //颜色通道为8 因为0-255 经过了8个颜色通道的变化
    //每一行图片的字节数 因为我们采用的是ARGB/RGBA 所以字节数为 width * 4
    size_t bytesPerRow =width * 4;
    //图片的透明度通道
    CGImageAlphaInfo info =kCGImageAlphaPremultipliedFirst;
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrderDefault|info);
    
    if (!context) {
        return nil;
    }
    //将图片渲染到图形上下文中
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
    
    //旋转context
    uint8_t* data =(uint8_t*) CGBitmapContextGetData(context);
    //旋转欠的数据
    vImage_Buffer src = { data,height,width,bytesPerRow};
    //旋转后的数据
    vImage_Buffer dest= { data,height,width,bytesPerRow};
    
    //背景颜色
    Pixel_8888  backColor = {0,0,0,0};
    //填充颜色
    vImage_Flags flags = kvImageBackgroundColorFill;
    
    vImageRotate_ARGB8888(&src, &dest, nil, degree * M_PI/180.f, backColor, flags);
    
    //将conetxt转换成image
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage  * rotateImage =[UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    
    return  rotateImage;
}

+ (UIImage *)image:(UIImage *)oriImage RotatedByRadians:(CGFloat)radians {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,oriImage.size.width, oriImage.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, radians);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oriImage.size.width / 2, -oriImage.size.height / 2, oriImage.size.width, oriImage.size.height), [oriImage CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
//CGContext.h
// cgcontext 裁剪
+ (UIImage *)cgcontextclip:(UIImage *)img cornerradius:(CGFloat)c{
    int w = img.size.width * img.scale;
    int h = img.size.height * img.scale;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, c);
    CGContextAddArcToPoint(context, 0, 0, c, 0, c);
    CGContextAddLineToPoint(context, w-c, 0);
    CGContextAddArcToPoint(context, w, 0, w, c, c);
    CGContextAddLineToPoint(context, w, h-c);
    CGContextAddArcToPoint(context, w, h, w-c, h, c);
    CGContextAddLineToPoint(context, c, h);
    CGContextAddArcToPoint(context, 0, h, 0, h-c, c);
    CGContextAddLineToPoint(context, 0, c);
    CGContextClosePath(context);
    
    // 先裁剪 context，再画图，就会在裁剪后的 path 中画
    CGContextClip(context);
    [img drawInRect:CGRectMake(0, 0, w, h)]; // 画图
    CGContextDrawPath(context, kCGPathFill);
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
}


/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

@end

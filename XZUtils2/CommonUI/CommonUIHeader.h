//
//  CommonUIHeader.h
//  JAnimeKManga
//
//  Created by jlkun on 2023/2/21.
//

#import <Foundation/Foundation.h>

#import "CommonBubbleLayer.h"

#import "CommonView.h"
#import "CommonButton.h"

#import "CommonImgTextView.h"

#import "CommonTextField.h"

#import "CommonTableCell.h"

#import "CommonCollectionViewFlowLayout.h"
#import "CommonCollectionCell.h"

#import "CommonCollectionViewWaterFallsFlowLayout.h"
#import "CommonScrollView.h"

// 尺寸适配
NS_INLINE CGFloat GetScreenScale() {
    CGFloat width = [UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
    CGFloat height = [UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
    CGFloat widthScale = width/375.f;
    CGFloat heightScale = height/667.f;
    CGFloat scale = ((widthScale <= heightScale) ? widthScale : heightScale);
    return scale < 1 ? 1 : scale;
}

NS_INLINE CGFloat ScreenFit(CGFloat num) {
    return GetScreenScale()*num;
}

NS_INLINE CGFloat FontSizeFit(CGFloat num) {
    return ScreenFit(num);
}

NS_INLINE UIFont* FontFit(CGFloat num) {
    return [UIFont systemFontOfSize:ScreenFit(num)];
}

NS_INLINE UIFont* FontBoldFit(CGFloat num) {
    return [UIFont boldSystemFontOfSize:ScreenFit(num)];
}

NS_INLINE CGFloat FontSizeNormal(CGFloat num) {
    return num;
}

NS_INLINE UIFont* FontNormal(CGFloat num) {
    return [UIFont systemFontOfSize:num];
}

NS_INLINE UIFont* FontBoldNormal(CGFloat num) {
    return [UIFont boldSystemFontOfSize:num];
}

NS_ASSUME_NONNULL_BEGIN

@interface CommonUIHeader : NSObject

@end

NS_ASSUME_NONNULL_END

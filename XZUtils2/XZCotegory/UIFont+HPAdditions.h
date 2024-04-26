//
//  UIFont+HPAdditions.h
//  EducationOL
//
//  Created by apple on 2021/9/1.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PingFangSCType) {
    PingFangSCTypeRegular,
    PingFangSCTypeMedium,
    PingFangSCTypeSemibold,
    PingFangSCTypeUltralight,
    PingFangSCTypeThin,
    PingFangSCTypeLight,
};
NS_ASSUME_NONNULL_BEGIN

@interface UIFont (HPAdditions)


+ (UIFont *)pingFangSCRegularSize:(CGFloat)size;

+ (UIFont *)pingFangSCMediumSize:(CGFloat)size;

+ (UIFont *)pingFangSCSemiboldSize:(CGFloat)size;

+ (UIFont *)pingFangSC:(PingFangSCType)type withSize:(CGFloat)size;

+ (UIFont *)systemRegularSize:(CGFloat)size;

+ (UIFont *)systemMediumSize:(CGFloat)size;

+ (UIFont *)systemSemiboldSize:(CGFloat)size;

+ (UIFont *)fontForSystem:(PingFangSCType)type withSize:(CGFloat)size;


/// Bebas是国外设计师Ryoichi Tsunekawa创作的一款字体，大家可能都用过一款名为DIN的字体，DIN字体非常优秀耐看，但是可惜的是DIN是一款商业字体，使用是需要授权的。而这款Bebas字体跟DIN就非常相似，可以作为DIN字体的替代字体，同样非常优秀。
/// - Parameter size: 字体大小
+ (UIFont *)bebasRegularSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END

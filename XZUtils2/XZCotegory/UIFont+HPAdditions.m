//
//  UIFont+HPAdditions.m
//  EducationOL
//
//  Created by apple on 2021/9/1.
//

#import "UIFont+HPAdditions.h"


@implementation UIFont (HPAdditions)



+ (UIFont *)bebasRegularSize:(CGFloat)size {
    return [UIFont bebas:PingFangSCTypeRegular withSize:size];
}

//+ (UIFont *)pingFangSCMediumSize:(CGFloat)size {
//    return [UIFont pingFangSC:PingFangSCTypeMedium withSize:size];
//}
//
//+ (UIFont *)pingFangSCSemiboldSize:(CGFloat)size {
//    return [UIFont pingFangSC:PingFangSCTypeSemibold withSize:size];
//}

+ (UIFont *)bebas:(PingFangSCType)type withSize:(CGFloat)size {
    NSString *defaultFontName = @"Bebas-Regular";
    switch (type) {
        case PingFangSCTypeMedium:
        {
            defaultFontName = @"PingFangSC-Medium";
        }
            break;
        case PingFangSCTypeSemibold:
        {
            defaultFontName = @"PingFangSC-Semibold";
        }
            break;
        case PingFangSCTypeUltralight:
        {
            defaultFontName = @"PingFangSC-Ultralight";
        }
            break;
        case PingFangSCTypeThin:
        {
            defaultFontName = @"PingFangSC-Thin";
        }
            break;
        case PingFangSCTypeLight:
        {
            defaultFontName = @"PingFangSC-Light";
        }
            break;
        default:
            break;
    }
    UIFont *font = [UIFont fontWithName:defaultFontName size:size];
    if (font) {
        return font;
    }
    return [self fontForSystem:type withSize:size];
}




+ (UIFont *)pingFangSCRegularSize:(CGFloat)size {
    return [UIFont pingFangSC:PingFangSCTypeRegular withSize:size];
}

+ (UIFont *)pingFangSCMediumSize:(CGFloat)size {
    return [UIFont pingFangSC:PingFangSCTypeMedium withSize:size];
}

+ (UIFont *)pingFangSCSemiboldSize:(CGFloat)size {
    return [UIFont pingFangSC:PingFangSCTypeSemibold withSize:size];
}

+ (UIFont *)pingFangSC:(PingFangSCType)type withSize:(CGFloat)size {
    NSString *defaultFontName = @"PingFangSC-Regular";
    switch (type) {
        case PingFangSCTypeMedium:
        {
            defaultFontName = @"PingFangSC-Medium";
        }
            break;
        case PingFangSCTypeSemibold:
        {
            defaultFontName = @"PingFangSC-Semibold";
        }
            break;
        case PingFangSCTypeUltralight:
        {
            defaultFontName = @"PingFangSC-Ultralight";
        }
            break;
        case PingFangSCTypeThin:
        {
            defaultFontName = @"PingFangSC-Thin";
        }
            break;
        case PingFangSCTypeLight:
        {
            defaultFontName = @"PingFangSC-Light";
        }
            break;
        default:
            break;
    }
    UIFont *font = [UIFont fontWithName:defaultFontName size:size];
    if (font) {
        return font;
    }
    return [self fontForSystem:type withSize:size];
}

+ (UIFont *)systemRegularSize:(CGFloat)size {
    return [self fontForSystem:PingFangSCTypeRegular withSize:size];
}

+ (UIFont *)systemMediumSize:(CGFloat)size {
    return [self fontForSystem:PingFangSCTypeMedium withSize:size];
}
+ (UIFont *)systemSemiboldSize:(CGFloat)size {
    return [self fontForSystem:PingFangSCTypeSemibold withSize:size];
}

+ (UIFont *)fontForSystem:(PingFangSCType)type withSize:(CGFloat)size {
    UIFontWeight weight = UIFontWeightRegular;
    switch (type) {
        case PingFangSCTypeMedium:
            weight = UIFontWeightMedium;
            break;
        case PingFangSCTypeSemibold:
            weight = UIFontWeightSemibold;
            break;
        case PingFangSCTypeUltralight:
            weight = UIFontWeightUltraLight;
            break;
        case PingFangSCTypeThin:
            weight = UIFontWeightThin;
            break;
        case PingFangSCTypeLight:
            weight = UIFontWeightLight;
            break;
        default:
            break;
    }
    return [UIFont systemFontOfSize:size weight:weight];;
}

@end

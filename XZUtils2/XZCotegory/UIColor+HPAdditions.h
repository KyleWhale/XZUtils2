//
//  UIColor+HPAdditions.h
//  EducationOL
//
//  Created by apple on 2021/8/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HPAdditions)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END

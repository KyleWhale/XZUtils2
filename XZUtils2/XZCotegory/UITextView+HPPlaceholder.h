//
//  UITextView+HPPlaceholder.h
//  EducationOL
//
//  Created by apple on 2021/8/20.
//

#import <UIKit/UIKit.h>


FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (HPPlaceholder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end

NS_ASSUME_NONNULL_END

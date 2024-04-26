//
//  UIControl+HPClickInterval.h
//  EducationOL
//
//  Created by apple on 2021/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (HPClickInterval)

/// 点击事件响应的时间间隔，不设置或者大于 0 时为默认时间间隔
@property (nonatomic, assign) NSTimeInterval clickInterval;
/// 是否忽略响应的时间间隔
@property (nonatomic, assign) BOOL ignoreClickInterval;

+ (void)kk_exchangeClickMethod;

@end

NS_ASSUME_NONNULL_END

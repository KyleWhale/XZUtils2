//
//  CommonView.h
//  Daipai
//
//  Created by kun on 2020/5/12.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonView : UIView

/**展示的页面viewController*/
@property (nonatomic, strong) UIViewController *targetViewController;

/**
 自定义view
 
 @param frame 视图大小
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 自定义view
 
 @param frame 视图大小
 @param cornerRadius 圆角弧度
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame
                 cornerRadius:(CGFloat)cornerRadius;

/**
 自定义view
 
 @param frame 视图大小
 @param cornerRadius 圆角弧度
 @param masksToBounds  layer.masksToBounds
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame
                 cornerRadius:(CGFloat)cornerRadius
                masksToBounds:(BOOL)masksToBounds;

@end

NS_ASSUME_NONNULL_END

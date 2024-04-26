//
//  CommonControl.h
//  Daipai
//
//  Created by kun on 2020/5/12.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonControl : UIControl

/**展示的页面viewController*/
@property (nonatomic, strong) UIViewController *targetViewController;

/**
 自定义control
 
 @param frame 视图大小
 @param target self
 @param action  @selector()
 @param forControlEvents UIControlEvents
 @return UIControl
 */
 - (instancetype)initWithFrame:(CGRect)frame
                        target:(id)target
                        action:(SEL)action
              forControlEvents:(UIControlEvents)forControlEvents;

/**展示弹窗的回调*/
@property (nonatomic, copy) dispatch_block_t showAlertBlock;
/**关闭弹窗的回调*/
@property (nonatomic, copy) dispatch_block_t closeAlertBlock;
// 展示弹窗
- (void)showAlertView;
// 隐藏弹窗
- (void)hideAlertView;

@property (nonatomic, assign) BOOL isShow;

@end

NS_ASSUME_NONNULL_END

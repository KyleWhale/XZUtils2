//
//  CommonImgTextView.h
//  Daipai
//
//  Created by lxinfo on 2020/7/21.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonControl.h"

#import "CommonImageView.h"
#import "CommonLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonImgTextView : CommonControl

- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;

/**图片*/
@property (nonatomic, strong) CommonImageView *imageView;

/**文字*/
@property (nonatomic, strong) CommonLabel *textLabel;

@end

NS_ASSUME_NONNULL_END

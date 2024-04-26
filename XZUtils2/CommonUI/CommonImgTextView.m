//
//  CommonImgTextView.m
//  Daipai
//
//  Created by lxinfo on 2020/7/21.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonImgTextView.h"

@implementation CommonImgTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self addSubviewImageView];
        [self addSubviewTextLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        [self addSubviewImageView];
        [self addSubviewTextLabel];
    }
    return self;
}

- (void)addSubviewImageView {
    if (!_imageView) {
        _imageView = [[CommonImageView alloc] initWithFrame:CGRectZero contentMode:UIViewContentModeScaleAspectFit masksToBounds:YES];
    }
    [self addSubview:self.imageView];
}

- (void)addSubviewTextLabel {
    if (!_textLabel) {
        _textLabel = [[CommonLabel alloc] initWithFrame:CGRectZero font:[UIFont systemFontOfSize:15] text:@"" textColor:UIColor.clearColor textAlignment:NSTextAlignmentCenter numberOfLines:0];
    }
    [self addSubview:self.textLabel];
}

@end

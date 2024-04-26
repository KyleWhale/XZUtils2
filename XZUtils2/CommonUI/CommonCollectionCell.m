//
//  CommonCollectionCell.m
//  Daipai
//
//  Created by lxinfo on 2020/8/31.
//  Copyright © 2020 XYZoe. All rights reserved.
//

#import "CommonCollectionCell.h"

@implementation CommonCollectionCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        if (self.contentView) {
            [self.contentView removeFromSuperview];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        if (self.contentView) {
            [self.contentView removeFromSuperview];
        }
    }
    return self;
}

@end

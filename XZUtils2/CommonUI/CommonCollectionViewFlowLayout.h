//
//  CommonCollectionViewFlowLayout.h
//  Daipai
//
//  Created by lxinfo on 2021/8/18.
//  Copyright © 2021 XYZoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define CommonCollectionViewFlowLayoutMaxYNotificationName @"CommonCollectionViewFlowLayoutMaxY"

// block回调
typedef void(^BLOCK_foldBlock)(NSInteger index, CGFloat maxX);

@interface CommonCollectionViewFlowLayout : UICollectionViewFlowLayout

/**是否需要更新CollectionView的Frame*/
@property (nonatomic, assign) BOOL frameLayout;
// 用于区分,默认999
@property (nonatomic, assign) NSInteger updateTag;

// 展开/收起
@property (nonatomic, assign) NSInteger foldLineNum;
@property (nonatomic, copy) BLOCK_foldBlock foldBlock;

/**
 类始化方法
 
 @param columnCount 列数
 @param columnSpacing 列间距
 @param rowSpacing 行间距
 @param itemHeight 高度
 @param sectionInsets UIEdgeInsets
 */
+ (instancetype)flowLayoutWithColumnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets;

/**
 初始化方法
 
 @param columnCount 列数
 @param columnSpacing 列间距
 @param rowSpacing 行间距
 @param itemHeight 高度
 @param sectionInsets UIEdgeInsets
 */
- (instancetype)initWithColumnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets;

@end

NS_ASSUME_NONNULL_END

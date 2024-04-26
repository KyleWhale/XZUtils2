//
//  CommonCollectionViewWaterFallsFlowLayout.h
//  Daipai
//
//  Created by kun on 2022/4/8.
//  Copyright © 2022 XYZoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HTCommonCollectionViewWaterFallsFlowLayoutDelegate <NSObject>

/**
 获取item的高度

 @param indexPath 下标
 @return item高度
 */
- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CommonCollectionViewWaterFallsFlowLayout : UICollectionViewLayout

/**单元格尺寸*/
@property (nonatomic, assign) CGSize itemSize;

/**列数*/
@property (nonatomic, assign) NSInteger numberOfColumns;

/**内边距*/
@property (nonatomic, assign) UIEdgeInsets sectionInSet;

/**item间隔*/
@property (nonatomic, assign) CGFloat itemSpacing;

/**代理属性*/
@property (nonatomic, weak) id <HTCommonCollectionViewWaterFallsFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

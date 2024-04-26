//
//  CommonCollectionViewWaterFallsFlowLayout.m
//  Daipai
//
//  Created by kun on 2022/4/8.
//  Copyright © 2022 XYZoe. All rights reserved.
//

#import "CommonCollectionViewWaterFallsFlowLayout.h"

@interface CommonCollectionViewWaterFallsFlowLayout ()

/**列高*/
@property (nonatomic, strong) NSMutableArray *columnsHeights;

/**item的数量*/
@property (nonatomic, assign) NSInteger numberOfItems;

/**存放每个item的位置信息的数组*/
@property (nonatomic, strong) NSMutableArray *itemAttributes;

/**临时存储当前item的x值*/
@property (nonatomic, assign) CGFloat itemX;

/**临时存储当前item的Y值*/
@property (nonatomic, assign) CGFloat itemY;

/**最矮列下标*/
@property (nonatomic, assign) NSInteger shortestIndex;

@end

@implementation CommonCollectionViewWaterFallsFlowLayout

// MARK: 懒加载
- (NSMutableArray *)columnsHeights {
    if (_columnsHeights == nil) {
        self.columnsHeights = [NSMutableArray arrayWithCapacity:0];
    }
    return _columnsHeights;
}

- (NSMutableArray *)itemAttributes {
    if (_itemAttributes == nil) {
        self.itemAttributes = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemAttributes;
}

// MARK: 获取最矮列的下标
- (NSInteger)getShortestColumnIndex {
    // 最矮列下标
    NSInteger shortestIndex = 0;
    // column高度
    CGFloat shortestHeight = MAXFLOAT;
    
    // 遍历高度数组获得最矮列下标
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        CGFloat currentHeight = [[self.columnsHeights objectAtIndex:i] floatValue];
        if (currentHeight < shortestHeight) {
            shortestHeight = currentHeight;
            shortestIndex = i;
        }
    }
    return shortestIndex;
}

// MARK: 获取最高列的下标
- (NSInteger)getHighestColumnIndex {
    // 最高列下标
    NSInteger highestIndex = 0;
    // column高度
    CGFloat highestHeight = 0;
    
    // 遍历高度数组获得最高列下标
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        CGFloat currentHeight = [[self.columnsHeights objectAtIndex:i] floatValue];
        if (currentHeight > highestHeight) {
            highestHeight = currentHeight;
            highestIndex = i;
        }
    }
    return highestIndex;
}

// MARK: 添加顶部内边距的值
- (void)addTopValueForColumns {
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        self.columnsHeights[i] = @(self.sectionInSet.top);
    }
}

// MARK: 计算每个item的X和Y
- (void)getOriginInShortestColumn {
    // 获取最矮列下标
    self.shortestIndex = [self getShortestColumnIndex];
    // 获取最矮列的高度
    CGFloat shortestHeight = [[self.columnsHeights objectAtIndex:self.shortestIndex] floatValue];
    // 设置item的X
    self.itemX = self.sectionInSet.left + (self.itemSize.width + self.itemSpacing) * self.shortestIndex;
    // 设置item的Y
    self.itemY = shortestHeight + self.itemSpacing;
}

// MARK: 计算width和height --> 生成frame
- (void)setFrame:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layOutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 存放item的高度
    CGFloat itemHeight = 0;
    
    if ((self.delegate != nil) && ([self.delegate respondsToSelector:@selector(heightForItemAtIndexPath:)] == YES)) {
        itemHeight = [self.delegate heightForItemAtIndexPath:indexPath];
    }
    
    layOutAttribute.frame = CGRectMake(_itemX, _itemY, self.itemSize.width, itemHeight);
    // 将位置信息加入数组
    [self.itemAttributes addObject:layOutAttribute];
    // 更新当前列的高度
    self.columnsHeights[_shortestIndex] = @(self.itemY + itemHeight);
}

// MARK: 重写父类布局方法
- (void)prepareLayout {
    [super prepareLayout];
    // 为高度数组添加上边距
    [self addTopValueForColumns];
    // 获取item个数
    self.numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    // 循环布局
    for (NSInteger i = 0; i < self.numberOfItems; i ++) {
        // 计算item的X和Y
        [self getOriginInShortestColumn];
        // 生成indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 生成frame
        [self setFrame:indexPath];
    }
}

// MARK: 获取contentView尺寸
- (CGSize)collectionViewContentSize {
    // 获取最高列下标
    NSInteger highestIndex = [self getHighestColumnIndex];
    // 获取最高列高度
    CGFloat highestHeight = [[self.columnsHeights objectAtIndex:highestIndex] floatValue];
    // 构造contentView的size
    CGSize size = self.collectionView.frame.size;
    // 修改高度
    size.height = highestHeight + self.sectionInSet.bottom;
    // 返回size
    return size;
}

// MARK: 返回位置信息数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributes;
}

@end

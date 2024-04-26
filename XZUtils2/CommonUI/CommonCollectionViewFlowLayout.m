//
//  CommonCollectionViewFlowLayout.m
//  Daipai
//
//  Created by lxinfo on 2021/8/18.
//  Copyright © 2021 XYZoe. All rights reserved.
//

#import "CommonCollectionViewFlowLayout.h"

@interface CommonCollectionViewFlowLayout ()

/**列数 */
@property (nonatomic, assign) NSInteger columnCount;

/**列间距*/
@property (nonatomic, assign) CGFloat columnSpacing;

/**行间距*/
@property (nonatomic, assign) CGFloat rowSpacing;

@end

@implementation CommonCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _frameLayout = YES;
        _updateTag = 999;
    }
    return self;
}

+ (instancetype)flowLayoutWithColumnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets {
    return [[CommonCollectionViewFlowLayout alloc] initWithColumnCount:columnCount columnSpacing:columnSpacing rowSpacing:rowSpacing itemHeight:itemHeight sectionInsets:sectionInsets];
    
}

- (instancetype)initWithColumnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets {
    if (self = [super init]) {
        CGFloat itemWidth = (([UIScreen mainScreen].bounds.size.width-columnSpacing*(columnCount-1))-sectionInsets.left-sectionInsets.right)/columnCount;
        if (!itemHeight) {
            itemHeight = itemWidth;
        }
        self.itemSize = CGSizeMake(itemWidth, itemHeight);
        self.sectionInset = sectionInsets;
        self.minimumInteritemSpacing = columnSpacing;
        self.minimumLineSpacing = rowSpacing;
    }
    return self;
}

/**
 重写当前方法 实现控制item最大间距
 
 @param rect 绘图范围
 @return item属性数组
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 获取到父类所返回的数组（里面放的是当前屏幕所能展示的item的结构信息）
    NSArray *superAttrs = [super layoutAttributesForElementsInRect:rect];
    if (superAttrs.count == 0) { //不加这个话，在iOS 13 以下会crash
        return superAttrs;
    }
    NSMutableArray *attributes = [superAttrs mutableCopy];
    BOOL isNeedFold = _foldLineNum > 0 && _foldBlock;
    NSInteger lineNum = 0;
    for (NSInteger i = 0; i < [attributes count]; i++) {
        if (!i) {
            UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = self.sectionInset.left;
            currentLayoutAttributes.frame = frame;
            
            continue;
        }
        
        // 当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        // 上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i-1];
        if (!_frameLayout) {
            NSInteger originY = CGRectGetMaxY(prevLayoutAttributes.frame);
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = self.sectionInset.left;
            frame.origin.y = originY + self.minimumLineSpacing;
            currentLayoutAttributes.frame = frame;
            continue;
        }
        // 我们想设置的最大间距，可根据需要改
        CGFloat maximumSpacing = self.minimumInteritemSpacing;
        
        // 前一个cell的最右边
        CGFloat originX = CGRectGetMaxX(prevLayoutAttributes.frame);
        // 如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        // 不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if ((originX + maximumSpacing + currentLayoutAttributes.frame.size.width+self.sectionInset.right) <= self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = originX + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        } else {
            if (isNeedFold && lineNum < _foldLineNum) {
                lineNum += 1;
                if (lineNum == _foldLineNum) {
                    _foldBlock(i, CGRectGetMaxX(prevLayoutAttributes.frame));
                }
            }
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = self.sectionInset.left;
            currentLayoutAttributes.frame = frame;
        }
    }
    if (_frameLayout) {
        UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [attributes lastObject];
        if (collectionViewLayoutAttributes) {
            CGFloat maxY = CGRectGetMaxY(collectionViewLayoutAttributes.frame);
            [[NSNotificationCenter defaultCenter] postNotificationName:CommonCollectionViewFlowLayoutMaxYNotificationName object:nil userInfo:@{@"maxY":[NSString stringWithFormat:@"%.2f", maxY], @"updateTag":@(_updateTag)}];
        }
    }
    return attributes;
}

@end

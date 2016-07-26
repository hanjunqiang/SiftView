//
//  SiftLayout.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import "SiftLayout.h"

@implementation SiftLayout

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray<UICollectionViewLayoutAttributes*>* attrs = [super layoutAttributesForElementsInRect:rect];
//    return attrs;
    __block UICollectionViewLayoutAttributes* tempAttr = nil;
    __block NSInteger preSection = 0;
    [attrs enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attr, NSUInteger idx, BOOL * _Nonnull stop) {
        if (attr.indexPath.section!=preSection) {//换组时 上一个属性的item为0时
            if(tempAttr.indexPath.item ==0&&(tempAttr.representedElementKind==nil))
            {
//                if (attr.representedElementKind&&[attr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//                  
//                }
                CGRect tempFrame = tempAttr.frame;
                tempFrame.size.width = self.collectionView.bounds.size.width-self.sectionInset.left-self.sectionInset.right;
                tempAttr.frame = tempFrame;
            }
        }
        preSection = attr.indexPath.section;
        tempAttr = attr;
    }];
    
    if (tempAttr.indexPath.item==0&&(tempAttr.representedElementKind==nil)) {
        CGRect tempFrame = tempAttr.frame;
        tempFrame.size.width = self.collectionView.bounds.size.width-self.sectionInset.left-self.sectionInset.right;
        tempAttr.frame = tempFrame;
    }
    
    return attrs;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end

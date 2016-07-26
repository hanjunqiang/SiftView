//
//  SiftViewCell.h
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiftCellModel.h"
@interface SiftViewCell : UICollectionViewCell

@property(nonatomic,assign)SiftCellModel* siftCellModel;

/**
 *  titleArray
 */
@property(nonatomic,strong)NSArray* cellModelArray;
 

/**
 *  点击了item
 */
@property(nonatomic,copy)void(^clickItemBock)(NSInteger index);
@end

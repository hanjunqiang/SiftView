//
//  SiftHeaderView.h
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiftheadModel.h"
@interface SiftHeaderView : UICollectionReusableView
/**
 *  headModel
 */
@property(nonatomic,strong)SiftheadModel* headModel;

/**
 *  点击block
 */
@property(nonatomic,copy)void(^headClickBlock)();
@end

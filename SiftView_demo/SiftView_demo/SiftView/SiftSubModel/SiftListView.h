//
//  SiftListView.h
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiftListView : UIView
/**
 *  数组
 */
@property(nonatomic,strong)NSArray* cellModelArray;

/**
 *  点击了cell
 */
@property(nonatomic,copy)void(^clickItemBlock)(NSInteger index);
@end

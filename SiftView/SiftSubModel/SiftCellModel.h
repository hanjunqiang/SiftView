//
//  SiftCellModel.h
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "SiftConst.h"
#import <Foundation/Foundation.h>

@interface SiftCellModel : NSObject
/**
 *  标题
 */
@property(nonatomic,copy)NSString* title;

/**
 *  选中状态
 */
@property(nonatomic,assign)BOOL selected;

@end

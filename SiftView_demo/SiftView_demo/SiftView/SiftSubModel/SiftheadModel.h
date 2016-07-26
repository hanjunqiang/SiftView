//
//  SiftCellModel.h
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "SiftConst.h"
#import <Foundation/Foundation.h>

@interface SiftheadModel : NSObject
/**
 *  标题
 */
@property(nonatomic,copy)NSString* title;

 /**
 *  cell
 */
@property(nonatomic,strong)NSMutableArray* items;

/**
 *  是否是展开
 */
@property(nonatomic,assign)BOOL isNotExpand;


/**
 *  类型
 */
@property(nonatomic,assign)SiftSectionContentType sectionType;

/**
 *  itemCount
 */
@property(nonatomic,assign)NSInteger itemCount;

 
@end


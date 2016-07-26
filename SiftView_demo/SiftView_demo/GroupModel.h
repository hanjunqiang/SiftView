//
//  BaseModel.h
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/13.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "ItemModel.h"
#import "siftConst.h"
#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

/**
 *  头部标题
 */
@property(nonatomic,copy)NSString* headTitle;

/**
 *  items
 */
@property(nonatomic,strong)NSArray* sectionItem;

/**
 *  类型
 */
@property(nonatomic,assign)SiftSectionContentType sectionType;

/**
 *  根据字典生成 model
 */
-(instancetype)initWithDictionary:(NSDictionary*)dict;

/**
 *  根据字典生成 model
 */
+(instancetype)modelWithDictionary:(NSDictionary*)dict;

/**
 *  根据字典数组生成NSArray数组
 */
+(NSArray*)modelWithArray:(NSArray*)array;

/**
 *  将值复制到对应的model
 */
-(void)modelCopyValueToModel:(id)model;
@end

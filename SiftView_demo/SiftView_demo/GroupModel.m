//
//  BaseModel.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/13.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import <objc/runtime.h>
#import "GroupModel.h"

@implementation GroupModel

-(void)setSectionItem:(NSArray *)sectionItem
{
    if (sectionItem&&sectionItem.count&&[sectionItem isKindOfClass:[NSArray class]]) {
        _sectionItem = [ItemModel modelWithArray:sectionItem];
    }
}

/**
 *  根据字典生成 model
 */
-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init]) {
        NSMutableDictionary *M_dict = [NSMutableDictionary dictionaryWithDictionary:dict];
        NSMutableArray *null_KeyArray = [NSMutableArray array];
        [[M_dict allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            if (M_dict[key] == nil||[M_dict[key] isKindOfClass:[NSNull class]]) {
                [null_KeyArray addObject:key];
            }
        }];
        
        [null_KeyArray enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            [M_dict removeObjectForKey:key];
        }];
        [self setValuesForKeysWithDictionary:M_dict];
    }
    
    return self;
}

/**
 *  根据字典生成 model
 */
+(instancetype)modelWithDictionary:(NSDictionary*)dict
{
    return  [[self alloc]initWithDictionary:dict];
}

/**
 *  根据字典数组生成NSArray数组
 */
+(NSArray*)modelWithArray:(NSArray*)array
{
    NSMutableArray *m_array = [NSMutableArray array];
    if (array&&array.count) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj&&[obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary*)obj;
                [m_array addObject:[self modelWithDictionary:dict]];
            }
        }];
    }else
    {
        const char * className = class_getName([self class]);
        NSString *ocClassName = [NSString stringWithUTF8String:className];
        NSLog(@"%@",ocClassName);
        
    }
    return m_array;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    const char * className = class_getName([self class]);
    NSString *ocClassName = [NSString stringWithUTF8String:className];
    NSLog(@"未设置：%@",ocClassName);
}

/**
 *  将值复制到对应的model
 */
-(void)modelCopyValueToModel:(id)model
{
    
    if(model==nil||![model isKindOfClass:[self class]])
    {
        return;
    }
    unsigned int ivarCount = 0;
    Ivar* ivars = class_copyIvarList([self class], &ivarCount);
    
    for (unsigned int i=0; i<ivarCount; i++) {
        Ivar var = ivars[i];
        
        NSString* key =  [NSString stringWithUTF8String:ivar_getName(var)];
        
        
        id value = [self valueForKey:key];
        if (value) {
            //            if ([key isEqualToString:@"_userArea"]) {
            //                continue;
            //            }
            [model setValue:value forKey:key];
        }
        
    }
    free(ivars);
}


@end


//
//  SiftCellModel.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import "SiftheadModel.h"

@implementation SiftheadModel

-(NSMutableArray *)items
{
    if (_items ==nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


@end

//
//  SiftView.h
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_OPTIONS(NSInteger, SiftSectionContentType)
//{
//    SiftSectionContentTypeNormal,//普通的
//    SiftSectionContentTypePriceScope//价格区间
//};
#import "siftConst.h"
@class SiftView;
@protocol SiftViewDelegate <NSObject>

@required
/**
 *  筛选一共多少组
 */
-(NSInteger)numberOfSiftViewSection;
/**
 *  对应section 有多少的个选项
 */
-(NSInteger)siftView:(SiftView*)siftView numberOfRowsForSection:(NSInteger)section;
/**
 *  对应section 的标题文字
 */
-(NSString*)siftView:(SiftView*)siftView sectionTitleForSection:(NSInteger)section;

/**
 *  对应indexPath 下cell的文字
 */
-(NSString*)siftView:(SiftView*)siftView cellTitleForIndexPath:(NSIndexPath*)indexPath;

@optional

/**
 *  指定的cell 是否需要选中  YES为选中状态
 */
-(BOOL)siftView:(SiftView *)siftView cellSelectedStatusForIndexPath:(NSIndexPath*)indexPath;

/**
 *  点击了cell
 */
-(void)siftView:(SiftView *)siftView didSelectedCellForIndexPath:(NSIndexPath*)indexPath;

/**
 *  SiftSectionContentType  如果是价格区间的类型
 */
-(SiftSectionContentType)siftView:(SiftView *)siftView sectionTypeForSection:(NSInteger)section;


/**
 *  点击了 清楚 或者 确定
 */
-(void)siftView:(SiftView *)siftView didClickButtonWithType:(SiftClickButtonType)buttonType;


@end

@interface SiftView : UIView
/**
 *  section Header  height   组头标题的高度
 */
@property(nonatomic,assign)CGFloat sectionHeaderHeight;

/**
 *  item/cell  height   单个cell高度   默认 54
 */
@property(nonatomic,assign)CGFloat itemHeight;

/**
 *   column  一行显示多少个  默认4个
 */
@property(nonatomic,assign)NSInteger columnCount;

/**
 *  头部标题
 */
@property(nonatomic,copy)NSString* headerTitle;

/**
 *  delegate
 */
@property(nonatomic,weak)id<SiftViewDelegate> delegate;

/**
 *  刷新数据
 */
-(void)reloadData;
@end

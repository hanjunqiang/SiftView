//
//  ViewController.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#define KSectionTitle @"headTitle"
#define KSectionItemKey @"sectionItem"
#define KItemSelected @"selected"
#define KItemTitle @"itemTitle"
#define KSectionType  @"sectionType"


#import "GroupModel.h"
#import "SiftView.h"
#import "ViewController.h"

@interface ViewController ()<SiftViewDelegate>
/**
 *  siftView
 */
@property(nonatomic,strong)SiftView* siftView;

/**
 *  数据
 */
@property(nonatomic,strong)NSArray* dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:(UIBarButtonItemStyleDone) target:self action:@selector(refresh)];

    [self.navigationController.view addSubview:self.siftView];
    self.siftView.delegate = self;
    
}


-(void)refresh
{
    [UIView animateWithDuration:0.3 animations:^{
        self.siftView.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  帅选一共多少组
 */
-(NSInteger)numberOfSiftViewSection
{
    return self.dataArray.count;
}
/**
 *  对应section 有多少的个选项
 */
-(NSInteger)siftView:(SiftView*)siftView numberOfRowsForSection:(NSInteger)section
{
   GroupModel *model  =  self.dataArray[section];
    
    return model.sectionItem.count;
}
/**
 *  对应section 的标题文字
 */
-(NSString*)siftView:(SiftView*)siftView sectionTitleForSection:(NSInteger)section
{
    GroupModel *model =  self.dataArray[section];
    return model.headTitle;
}

/**
 *  对应indexPath 下cell的文字
 */
-(NSString*)siftView:(SiftView*)siftView cellTitleForIndexPath:(NSIndexPath*)indexPath
{
    GroupModel* model =  self.dataArray[indexPath.section];
    NSArray*itmes = model.sectionItem;
    ItemModel* itemModel = itmes[indexPath.item];
    return itemModel.itemTitle;
}

/**
 *  指定的cell 是否需要选中  YES为选中状态
 */
-(BOOL)siftView:(SiftView *)siftView cellSelectedStatusForIndexPath:(NSIndexPath*)indexPath
{
    GroupModel* model =  self.dataArray[indexPath.section];
    NSArray*itmes = model.sectionItem;
    ItemModel* itemModel = itmes[indexPath.item];
    return  itemModel.selected;
}

/**
 *  点击了cell
 */
-(void)siftView:(SiftView *)siftView didSelectedCellForIndexPath:(NSIndexPath*)indexPath
{
    GroupModel* model =  self.dataArray[indexPath.section];
    NSArray*itmes = model.sectionItem;
    ItemModel* itemModel = itmes[indexPath.item];
    
    NSLog(@"点击了{section:%zd,item:%zd} 组标题:%@ 选项:%@",indexPath.section,indexPath.item,model.headTitle,itemModel.itemTitle);
    //选中取反
    itemModel.selected = !itemModel.selected;
    [self.siftView reloadData];
}

/**
 *  SiftSectionContentType  如果是价格区间的类型
 */
-(SiftSectionContentType)siftView:(SiftView *)siftView sectionTypeForSection:(NSInteger)section
{
    GroupModel* model =  self.dataArray[section];
    
    return model.sectionType;
}

/**
 *  按钮点击
 */
-(void)siftView:(SiftView *)siftView didClickButtonWithType:(SiftClickButtonType)buttonType
{
    if(buttonType==SiftClickButtonTypeClear)
    {
        NSLog(@"点击清除");
    }else
    {
        NSLog(@"点击确定");
    }
}

-(SiftView *)siftView
{
    if (_siftView==nil) {
        _siftView = [[SiftView alloc] initWithFrame:self.view.bounds];
        _siftView.transform= CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
        _siftView.delegate =self;
    }
    return _siftView;
}

-(NSArray *)dataArray
{
    if (_dataArray==nil) { 
        NSArray* groupArray = @[
        //第一个字典
        @{KSectionTitle:@"面料",KSectionType:@(0),KSectionItemKey:@[@{KItemTitle:@"纤维",KItemSelected:@(0)},@{KItemTitle:@"真丝",KItemSelected:@(1)},@{KItemTitle:@"羊毛",KItemSelected:@(0)},@{KItemTitle:@"磨毛",KItemSelected:@(0)},@{KItemTitle:@"狗毛",KItemSelected:@(0)},@{KItemTitle:@"驴毛",KItemSelected:@(0)}]},
        //第二个字典
        @{KSectionTitle:@"尺寸",KSectionType:@(0),KSectionItemKey:@[@{KItemTitle:@"1.2米",KItemSelected:@(0)},@{KItemTitle:@"1.5米",KItemSelected:@(0)},@{KItemTitle:@"1.8米",KItemSelected:@(0)}]},
        //第三个字典
        @{KSectionTitle:@"价格区间",KSectionType:@(1),KSectionItemKey:@[@{KItemTitle:@"0",KItemSelected:@(0)},@{KItemTitle:@"100",KItemSelected:@(1)},@{KItemTitle:@"200",KItemSelected:@(1)},@{KItemTitle:@"300",KItemSelected:@(0)},@{KItemTitle:@"400",KItemSelected:@(0)},@{KItemTitle:@"500",KItemSelected:@(0)}]},
        //第四个字典
        @{KSectionTitle:@"特殊分类",KSectionType:@(0),KSectionItemKey:@[@{KItemTitle:@"夏季",KItemSelected:@(0)},@{KItemTitle:@"春季",KItemSelected:@(1)},@{KItemTitle:@"秋季",KItemSelected:@(0)}]}];
        
        
        _dataArray = [GroupModel modelWithArray:groupArray];
    }
    
    return _dataArray;
}
@end

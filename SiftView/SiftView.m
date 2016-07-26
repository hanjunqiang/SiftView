//
//  SiftView.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "SiftLayout.h"
#import "SiftHeaderView.h"
#import "SiftViewCell.h"
#import "SiftView.h"

@interface SiftView()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *  headView
 */
@property(nonatomic,strong)UIView* headView;
/**
 *  头部的标题
 */
@property(nonatomic,strong)UILabel* titleLabel;

/**
 *  布局
 */
@property(nonatomic,strong)SiftLayout* layout;

/**
 *  CollectionView  展示筛选菜单
 */
@property(nonatomic,strong)UICollectionView* collectionView;

/**
 *  清空按钮
 */
@property(nonatomic,strong)UIButton* clearButton;

/**
 *  确定按钮
 */
@property(nonatomic,strong)UIButton* confirmButton;


/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray* siftArray;
@end

@implementation SiftView

static NSString* const reuseidentifer = @"itemCell";
static NSString* const headerReuseidentifer = @"header";

/**
 *  初始化控件
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self =[super initWithFrame:frame])
    {
        self.columnCount = SiftColumnCount;
        self.itemHeight = SiftItemH;
        self.sectionHeaderHeight = SiftSectionHeadHeight;
        
        //头部view
        self.headView = [[UIView alloc]init];
        CGFloat value = (200/255.0);
        self.headView.layer.borderColor = [UIColor colorWithRed:(value) green:value blue:value alpha:1].CGColor;
        self.headView.backgroundColor = [UIColor colorWithRed:(234/255.0) green:(239/255.0) blue:(240/255.0) alpha:1];
        self.headView.layer.borderWidth = 0.5;
        [self addSubview:self.headView];
        
        //头部的标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.text =  self.headerTitle?self.headerTitle:@"标题";
        [self.headView addSubview:self.titleLabel];
        
        //布局
        self.layout = [[SiftLayout alloc] init];
        self.layout.minimumInteritemSpacing= 5;
        self.layout.minimumLineSpacing = 5;
        self.layout.sectionInset = UIEdgeInsetsMake(0, SiftLeftAndRightMargin, 0, SiftLeftAndRightMargin);
        
        //collectionView
        self.collectionView= [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        [self.collectionView registerClass:[SiftViewCell class] forCellWithReuseIdentifier:reuseidentifer];
        [self.collectionView registerClass:[SiftHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseidentifer];
        
        
        //清空按钮
        self.clearButton = [[UIButton alloc] init];
        self.clearButton.layer.borderColor = [UIColor greenColor].CGColor;
        self.clearButton.layer.borderWidth = 0.5;
        [self.clearButton setTitle:@"清空" forState:(UIControlStateNormal)];
        [self.clearButton setTitle:@"清空" forState:(UIControlStateSelected)];
        self.clearButton.tag =  SiftClickButtonTypeClear;
        [self.clearButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.clearButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.clearButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.clearButton] ;
        
        //确定按钮
        self.confirmButton =  [[UIButton alloc] init];
        self.confirmButton.backgroundColor = [UIColor redColor];
        [self.confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
        [self.confirmButton setTitle:@"确定" forState:UIControlStateSelected];
        self.confirmButton.tag = SiftClickButtonTypeConfirm;
        [self.confirmButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.confirmButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.confirmButton];
        
    }
    return self;
}


-(void)btnClick:(UIButton*)btn
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(siftView:didClickButtonWithType:)]) {
        [self.delegate siftView:self didClickButtonWithType:btn.tag];
    }
}

/**
 *  布局子控件
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat selfW = self.bounds.size.width;
    CGFloat selfH = self.bounds.size.height;
    
    //标题
    CGFloat titleW = selfW;
    CGFloat titleH = 64;
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    self.headView.frame = CGRectMake(titleX, titleY, titleW, titleH);
    titleY = 5;
    titleH -= titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat margin  =SiftLeftAndRightMargin;
    //按钮
    CGFloat btnW = (selfW-(3*margin))/2;
    CGFloat btnH = SiftBottomButtonH;
    CGFloat btnX = margin;
    CGFloat btnY = selfH-btnH-30;
    self.clearButton.frame =  CGRectMake(btnX, btnY, btnW, btnH);
    
    btnX += btnW+margin;
    self.confirmButton.frame =  CGRectMake(btnX, btnY, btnW, btnH);
    
    //collectionView
    CGFloat collectionW = selfW;
    CGFloat collectionY = CGRectGetMaxY(self.titleLabel.frame)+margin;
    CGFloat collectionH = btnY-margin-collectionY;
    CGFloat collectionX = 0;
    self.layout.minimumInteritemSpacing= 5;
    self.layout.minimumLineSpacing = 8;
    
    CGFloat itemW =  ((collectionW - (self.columnCount>1?self.columnCount:1-1)*self.layout.minimumInteritemSpacing)-self.layout.sectionInset.left-self.layout.sectionInset.right)/self.columnCount;
    
    self.layout.itemSize = CGSizeMake(itemW, self.itemHeight);
    
    if (self.sectionHeaderHeight) {
        self.layout.headerReferenceSize = CGSizeMake(collectionW, self.sectionHeaderHeight);
    }
    self.collectionView.frame = CGRectMake(collectionX, collectionY, collectionW, collectionH);
    [self.collectionView setCollectionViewLayout:self.layout];
    
}

/**
 *  返回多少组
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger count = 0;
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(numberOfSiftViewSection)]) {
        count =[self.delegate numberOfSiftViewSection];
    }
    return count;
}

/**
 *  返回section下的item个数
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SiftSectionContentType sectionType= SiftSectionContentTypeNormal;
    if(self.delegate&&[self.delegate respondsToSelector:@selector(siftView:sectionTypeForSection:)])
    {
        sectionType = [self.delegate siftView:self sectionTypeForSection:section];
    }
    
    NSInteger count = 0;
    //组头
    SiftheadModel *headerModel = [[SiftheadModel alloc] init];
    headerModel.isNotExpand = SiftDeafaultExpand(YES);
    if(section<self.siftArray.count)//存在
    {
        headerModel =  self.siftArray[section];
    }else
    {
        [self.siftArray addObject:headerModel];
    }
    
    headerModel.sectionType = sectionType;
    
    if (headerModel.isNotExpand) {
        return count;
    }
    
    
    //普通
    if (self.delegate&&[self.delegate respondsToSelector:@selector(siftView:numberOfRowsForSection:)]) {
        count=  [self.delegate siftView:self numberOfRowsForSection:section];
    }
    
    headerModel.itemCount = count;
    //SiftSectionContentTypeListScope 列表
    if(headerModel.sectionType ==SiftSectionContentTypeListScope)
    {
        return 1;
    }
    
    return count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiftViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseidentifer forIndexPath:indexPath];
    cell.clickItemBock = nil;
    //组头
    SiftheadModel *headerModel = [[SiftheadModel alloc] init];
    if(indexPath.section<self.siftArray.count)//存在
    {
        headerModel =  self.siftArray[indexPath.section];
    }else
    {
        [self.siftArray addObject:headerModel];
    }
    //取标题
    NSString*headTitle=@"";
    if(self.delegate&&[self.delegate respondsToSelector:@selector(siftView:sectionTitleForSection:)])
    {
        headTitle= [self.delegate siftView:self sectionTitleForSection:indexPath.section];
    }
    headerModel.title =headTitle;
    
    //SiftSectionContentTypeListScope 列表
    if(headerModel.sectionType ==SiftSectionContentTypeListScope)
    { 
        NSMutableArray *m_array =[NSMutableArray array];
        for (NSInteger i= 0; i<headerModel.itemCount; i++) {
            //取标题
            SiftCellModel *cellModel = [[SiftCellModel alloc] init];
            NSString*cellTitle=@"";
            NSIndexPath* tempIndexPath = [NSIndexPath indexPathForItem:i inSection:indexPath.section];
            if(self.delegate&&[self.delegate respondsToSelector:@selector(siftView:cellTitleForIndexPath:)])
            {
                cellTitle= [self.delegate siftView:self cellTitleForIndexPath:tempIndexPath];
            }
            cellModel.title = cellTitle;
            
            //是否为真
            BOOL selected = NO;
            if(self.delegate&&[self.delegate respondsToSelector:@selector(siftView:cellSelectedStatusForIndexPath:)])
            {
                selected  = [self.delegate siftView:self cellSelectedStatusForIndexPath:tempIndexPath];
            }
            cellModel.selected =selected;
            [m_array addObject:cellModel];
            
          
        }
        cell.cellModelArray = m_array;
        SiftWeakSelf
        cell.clickItemBock  = ^(NSInteger index)
        {
            if (weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(siftView:didSelectedCellForIndexPath:)]) {
                NSIndexPath* tempIndexPath = [NSIndexPath indexPathForItem:index inSection:indexPath.section];
                [weakSelf.delegate siftView:self didSelectedCellForIndexPath:tempIndexPath];
            }
            
        };
    }else if(headerModel.sectionType ==SiftSectionContentTypeNormal)
    {
        //cell
        SiftCellModel *cellModel = [[SiftCellModel alloc] init];
        
        if(indexPath.item<headerModel.items.count)//存在
        {
            cellModel =  headerModel.items[indexPath.item];
        }else
        {
            [headerModel.items addObject:cellModel];
        }
        //取标题
        NSString*cellTitle=@"";
        if(self.delegate&&[self.delegate respondsToSelector:@selector(siftView:cellTitleForIndexPath:)])
        {
            cellTitle= [self.delegate siftView:self cellTitleForIndexPath:indexPath];
        }
        cellModel.title =cellTitle;
        
        //是否为真
        BOOL selected = NO;
        if(self.delegate&&[self.delegate respondsToSelector:@selector(siftView:cellSelectedStatusForIndexPath:)])
        {
            selected  = [self.delegate siftView:self cellSelectedStatusForIndexPath:indexPath];
        }
        cellModel.selected =selected;
        cell.siftCellModel  = cellModel;
        
    }
    
     return cell;
}


-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SiftHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseidentifer forIndexPath:indexPath];
    
    //组头
    SiftheadModel *headerModel = [[SiftheadModel alloc] init];
    if(indexPath.section<self.siftArray.count)//存在
    {
        headerModel =  self.siftArray[indexPath.section];
    }else
    {
        [self.siftArray addObject:headerModel];
    }
    
    SiftWeakSelf
    headView.headClickBlock =^{
        headerModel.isNotExpand = !headerModel.isNotExpand;
        [weakSelf reloadData];
    };
    
    //取标题
    NSString*headTitle=@"";
    if(self.delegate&&[self.delegate respondsToSelector:@selector(siftView:sectionTitleForSection:)])
    {
        headTitle= [self.delegate siftView:self sectionTitleForSection:indexPath.section];
    }
    
    headerModel.title =headTitle;
    headView.headModel = headerModel;
    
    return headView;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //组头
    SiftheadModel *headerModel = [[SiftheadModel alloc] init];
    if(indexPath.section<self.siftArray.count)//存在
    {
        headerModel =  self.siftArray[indexPath.section];
    }else
    {
        [self.siftArray addObject:headerModel];
    }
    
    if (headerModel.sectionType == SiftSectionContentTypeListScope) {
        return;
    }
//    //cell
//    SiftCellModel *cellModel = [[SiftCellModel alloc] init];
//    
//    if(indexPath.item<headerModel.items.count)//存在
//    {
//        cellModel =  headerModel.items[indexPath.item];
//    }else
//    {
//        [headerModel.items addObject:cellModel];
//    }
//
//    cellModel.selected = !cellModel.selected;
//    [self reloadData];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(siftView:didSelectedCellForIndexPath:)]) {
        [self.delegate siftView:self didSelectedCellForIndexPath:indexPath];
    }

}

-(void)reloadData
{
    [self.collectionView reloadData];
}


-(NSMutableArray *)siftArray
{
    if(_siftArray==nil)
    {
        _siftArray = [NSMutableArray array];
    }
    return _siftArray;
}


-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self reloadData];
}
@end

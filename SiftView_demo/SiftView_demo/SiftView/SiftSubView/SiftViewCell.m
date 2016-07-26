//
//  SiftViewCell.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "SiftListView.h"
#import "SiftViewCell.h"
@interface SiftViewCell()
/**
 *  titleLabel
 */
@property(nonatomic,strong)UILabel* titleLabel;

/**
 *  bgView
 */
@property(nonatomic,strong)UIView* bgView;

/**
 *  listView
 */
@property(nonatomic,strong)SiftListView* listView;
@end
@implementation SiftViewCell
/**
 *  初始化
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.bgView = [[UIView alloc]init]; 
        self.bgView.userInteractionEnabled = NO;
        self.bgView.layer.borderWidth =0.5;
        [self.contentView addSubview:self.bgView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment =NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:SiftItemFontSize];
        [self.contentView addSubview:self.titleLabel];
        
        self.listView = [[SiftListView alloc] init];
        SiftWeakSelf
        self.listView.clickItemBlock = ^(NSInteger index)
        {
            if (weakSelf.clickItemBock) {
                weakSelf.clickItemBock(index);
            }
        };
        [self.contentView addSubview:self.listView];
        
    }
    return self;
}

-(void)setCellModelArray:(NSArray *)cellModelArray
{
    if (cellModelArray) {
        _cellModelArray =  cellModelArray;
        
        self.listView.hidden=NO;
        self.titleLabel.hidden = YES;
        self.listView.cellModelArray = cellModelArray;
        
        self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.titleLabel.textColor = [UIColor lightGrayColor];
        [self setNeedsLayout];
    }
}

-(void)setSiftCellModel:(SiftCellModel *)siftCellModel
{
    _siftCellModel =siftCellModel;
    
    if (siftCellModel) {
        self.titleLabel.text = siftCellModel.title;
        if (siftCellModel.selected) {
            self.bgView.layer.borderColor = [UIColor redColor].CGColor;
            self.titleLabel.textColor = [UIColor redColor];
        }else
        {
            self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.titleLabel.textColor = [UIColor lightGrayColor];
        }
        
        self.listView.hidden=YES;
        self.titleLabel.hidden = NO;
        
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
        self.bgView.frame = self.contentView.bounds;
        self.titleLabel .frame = self.contentView.bounds;
        self.listView.frame = self.contentView.bounds;
 
}


@end

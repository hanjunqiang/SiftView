//
//  SiftListView.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "SiftCellModel.h"
#import "siftConst.h"
#import "SiftListView.h"
@interface SiftListView()
/**
 *  bgView
 */
@property(nonatomic,strong)UIView* bgView;

/**
 *  底部条
 */
@property(nonatomic,strong)UIImageView* imageView;


/**
 *  fromIndex
 */
@property(nonatomic,assign)NSInteger fromIdnex;

/**
 *  toIndex
 */
@property(nonatomic,assign)NSInteger toIndex;

@end

@implementation SiftListView
/**
 *  初始化
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.fromIdnex =0;
        self.toIndex = 0;
        self.bgView =  [[UIView alloc] init]; 
        [self addSubview:self.bgView];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
    }
    return self;
}


-(void)setCellModelArray:(NSArray *)cellModelArray
{
    
    if (cellModelArray) {
        _cellModelArray = cellModelArray;
        self.fromIdnex = 0;
        self.toIndex = 0;
        //移除
        [self.bgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        
        __block BOOL firstFlag =  NO;
        [cellModelArray enumerateObjectsUsingBlock:^(SiftCellModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn= [[UIButton alloc] init];
            btn.titleLabel.font =[UIFont systemFontOfSize:SiftItemFontSize];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            btn.tag = idx;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [btn setTitle:model.title forState:(UIControlStateNormal)];
            [self.bgView addSubview:btn];
//            btn.layer.borderWidth = 0.5;
            [self setBtnStautsWithButton:btn andSelected:model.selected];
            
            if (model.selected) {
                if (!firstFlag) {
                    self.fromIdnex = idx;
                    firstFlag = YES;
                }
                self.toIndex = idx;
            }
            
        }];
        
        self.imageView.hidden =self.fromIdnex==self.toIndex;
        
        [self setNeedsLayout];
    }
}


-(void)setBtnStautsWithButton:(UIButton*)btn andSelected:(BOOL)selected
{
    if (selected) {
//        btn.layer.borderColor = [UIColor redColor].CGColor;
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)] ;
    }else
    {
//        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    }
    
}


-(void)btnClick:(UIButton*)btn
{
    if (self.clickItemBlock) {
        self.clickItemBlock(btn.tag);
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = self.bounds;
    
    if (!self.bgView.subviews.count) {
        return;
    }
    CGFloat btnW = self.bounds.size.width/(self.bgView.subviews.count);
    
    [self.bgView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat btnH = self.bounds.size.height-2;
        CGFloat btnX = (btnW)*idx;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }];

    NSInteger value = self.toIndex-self.fromIdnex;
    CGFloat imageViewW = btnW*(value==0?1:value);
    CGFloat imageViewH = 2;
    CGFloat imageViewX = btnW*0.5+(self.fromIdnex)*btnW;
    CGFloat imageViewY = self.bounds.size.height-imageViewH;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
}
@end

//
//  SiftHeaderView.m
//  SiftView_demo
//
//  Created by 朱建伟 on 16/6/8.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "SiftConst.h"
#import "SiftHeaderView.h"
@interface SiftHeaderView()
/**
 *  titleLabel
 */
@property(nonatomic,strong)UILabel* titleLabel;

/**
 *  bgView
 */
@property(nonatomic,strong)UIView* topLineView;

/**
 *  箭头
 */
@property(nonatomic,strong)UIImageView* arrowImageView;

/**
 *  actionBtn
 */
@property(nonatomic,strong)UIButton* actionBtn;

/**
 *  currentArraySelected
 */
//@property(nonatomic,assign)BOOL isNotExpand;
@end

@implementation SiftHeaderView
/**
 *  初始化
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.actionBtn  = [[UIButton alloc] init];
        [self.actionBtn addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.actionBtn];
        
        self.topLineView=[[UIView alloc]init];
        CGFloat value =240/255.0;
        self.topLineView.backgroundColor = [UIColor colorWithRed:value green:value blue:value alpha:1];
        [self addSubview:self.topLineView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:SiftHeaderFontSize];
        [self addSubview:self.titleLabel];
        
        self.arrowImageView = [[UIImageView alloc]init];
        self.arrowImageView.image = [UIImage imageArrowWithSize:CGSizeMake(13, 7) lineWidth:1 andColor:[UIColor lightGrayColor] andArrowDirection:0 stroke:YES];
        [self addSubview:self.arrowImageView];
    }
    return self;
}


-(void)setHeadModel:(SiftheadModel *)headModel
{
    _headModel =  headModel;
    
    if (headModel) {
        
        self.titleLabel.text = headModel.title;
        
        CGAffineTransform transform =  CGAffineTransformIdentity;
        if (headModel.isNotExpand) {
            transform = CGAffineTransformMakeRotation(-M_PI);
        }
//        
//        if (headModel.isNotExpand==self.isNotExpand) {
            self.arrowImageView.transform= transform;
//        }else{
//            [UIView animateWithDuration:0.25 animations:^{
//                self.arrowImageView.transform= transform;
//            }completion:^(BOOL finished) {
//                self.isNotExpand = headModel.isNotExpand;
//            }];
//        }
    }
}



-(void)headClick
{
    if (self.headClickBlock) {
        self.headClickBlock();
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.actionBtn.frame = self.bounds;
    
    CGFloat lineY = self.bounds.size.height-0.5-10;
    self.topLineView.frame = CGRectMake(SiftLeftAndRightMargin,lineY , self.bounds.size.width-2*SiftLeftAndRightMargin, 0.5);
    
    CGFloat x = SiftLeftAndRightMargin;
    CGFloat h  = 21;
    CGFloat y = (lineY-h)*0.5;
    CGFloat w = self.bounds.size.width-2*x;
    self.titleLabel .frame = CGRectMake(x, y, w, h);
    
    CGFloat arrowW = 13;
    CGFloat arrowH = 7;
    CGFloat arrowX = self.bounds.size.width-SiftLeftAndRightMargin-arrowW;
    CGFloat arrowY = (lineY-arrowH)*0.5;
    self.arrowImageView.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
}

@end

#define SiftSectionTopAndBottom 18 //section的Top／Bottom 别改这个值
#define SiftDeafaultExpand(expand) !expand//默认展开 展开用! 不展开则删掉！
#define SiftLeftAndRightMargin 10  //左右的边距
#define SiftItemH 30  //cell高度
#define SiftColumnCount 4  //一行显示多少个
#define SiftSectionHeadHeight 50 //section的高度
#define SiftItemFontSize 13  //cell字体
#define SiftHeaderFontSize 16 //section的字体
#define SiftBottomButtonH 44 //底部按钮的高度
#define SiftWeakSelf __weak typeof(self) weakSelf =self;


#import "UIImage+SiftExtension.h"

typedef NS_OPTIONS(NSInteger, SiftSectionContentType)
{
    SiftSectionContentTypeNormal,//普通的
    SiftSectionContentTypeListScope//价格区间
};

typedef NS_OPTIONS(NSInteger, SiftClickButtonType)
{
    SiftClickButtonTypeClear,//清除
    SiftClickButtonTypeConfirm//确定
};
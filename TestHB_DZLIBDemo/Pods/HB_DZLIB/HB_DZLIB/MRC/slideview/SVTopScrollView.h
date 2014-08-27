 

#import <UIKit/UIKit.h>
//按钮空隙
#define BUTTONGAP 20
//滑条宽度
#define CONTENTSIZEX 320

#define BUTTONIDFUN (sender.tag-100)

//滑动id
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 100)
@interface SVTopScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *nameArray;
    NSInteger userSelectedChannelID;        //点击按钮选择名字ID
    NSInteger scrollViewSelectedChannelID;  //滑动列表选择名字ID
    
    UIImageView *shadowImageView;   //选中阴影
}
@property (nonatomic, retain) NSArray *nameArray;
@property(nonatomic,assign) int BUTTONID;
@property(nonatomic,retain)NSMutableArray *buttonOriginXArray;
@property(nonatomic,retain)NSMutableArray *buttonWithArray;

@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
//AS_SIGNAL(selectNameButtonTap)

//+ (SVTopScrollView *)shareInstance;
/**
 *  加载顶部标签
 */
- (void)initWithNameButtons;
/**
 *  滑动撤销选中按钮
 */
- (void)setButtonUnSelect;
/**
 *  滑动选择按钮
 */
- (void)setButtonSelect;
/**
 *  滑动顶部标签位置适应
 */
-(void)setScrollViewContentOffset;


@end

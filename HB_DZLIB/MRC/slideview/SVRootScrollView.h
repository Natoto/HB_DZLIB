 

#import <UIKit/UIKit.h>
//#define POSITIONID (int)(scrollView.contentOffset.x/320)
@interface SVRootScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *viewNameArray;
    CGFloat userContentOffsetX;
    BOOL isLeftScroll;
}
@property(nonatomic,assign) int POSITIONID;
@property (nonatomic, retain) NSArray *viewNameArray;
//AS_SIGNAL(adjustTopScrollView)
//+ (SVRootScrollView *)shareInstance;

- (void)initWithViews;
/**
 *  加载主要内容
 */
- (void)loadData;

@end

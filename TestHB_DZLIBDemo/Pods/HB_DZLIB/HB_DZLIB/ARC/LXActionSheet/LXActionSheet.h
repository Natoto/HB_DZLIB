//
//  LXActionSheet.h
//  LXActionSheetDemo
//
//  Created by lixiang on 14-3-10.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import <UIKit/UIKit.h>

//#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
//#define HBIOS7_OR_LATER		([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
//#endif

@protocol LXActionSheetDelegate <NSObject>
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex;
@optional
- (void)didClickOnDestructiveButton;
- (void)didClickOnCancelButton;
@end

@interface LXActionSheet : UIView
@property(nonatomic,assign)BOOL isShown;
- (id)initWithTitle:(NSString *)title delegate:(id<LXActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray;
- (void)showInView:(UIView *)view;

@end

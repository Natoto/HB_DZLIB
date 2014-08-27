//
//  FaceBoard.h
//
//  Created by blue on 12-9-26.
//  Copyright (c) 2012年 blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood


#import <UIKit/UIKit.h>

#import "FaceButton.h"

#import "GrayPageControl.h"


#define FACE_NAME_HEAD  @"/s"

// 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define FACE_NAME_LEN   5

#define FACE_MAX_LENGTH 15
@protocol FaceBoardDelegate <NSObject>

@optional
-(void)faceboardBackface;
- (void)facebuttonTap:(id)sender andName:(NSString *)name; 
@end


@interface FaceBoard : UIView<UIScrollViewDelegate>{

    UIScrollView *faceView;
    int  FACE_COUNT_ALL;
    GrayPageControl *facePageControl;

    NSDictionary *_faceMap;
}


@property (nonatomic, assign) id<FaceBoardDelegate> delegate;


@property (nonatomic, retain) UITextField *inputTextField;

@property (nonatomic, retain) UITextView *inputTextView;

+(NSString *)faceFileName:(NSString *)key;
+(NSString *)isExistFacail:(const NSString *)key;
+(NSString *)isExistFacail:(const NSString *)key withDic:(const NSDictionary *)dic;
+(NSDictionary *)facailDictionary;
//加表情包外壳
+(NSString *)addfacialpackage:(const NSString *)message dic:(NSDictionary *)dic;
//去表情包外壳
+(NSString *)removePackage:(NSUInteger)pos text:(const NSString *)text;
+(void)getImageTextRange:(const NSString*)message array: (NSMutableArray*)array;
- (void)backFace;


@end

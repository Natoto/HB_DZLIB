//
//  FaceBoard.m
//
//  Created by blue on 12-9-26.
//  Copyright (c) 2012年 blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood

#import "FaceBoard.h"

#define FACE_COUNT_ROW  4

#define FACE_COUNT_CLU  7

#define FACE_COUNT_PAGE ( FACE_COUNT_ROW * FACE_COUNT_CLU )

#define FACE_ICON_SIZE  44


@implementation FaceBoard

@synthesize delegate;

@synthesize inputTextField = _inputTextField;
@synthesize inputTextView = _inputTextView;


+(NSString *)faceFileName:(NSString *)key
{
    NSString *parpath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:
                 [parpath stringByAppendingPathComponent:@"expressions/_expression_en.plist"]];
    
    return [dic valueForKey:key];
}

+(NSString *)isExistFacail:(const NSString *)key
{
    
    NSString *tempkey=[NSString stringWithFormat:@"%@",key];
    NSString *parpath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"];
     NSDictionary *dic= [NSDictionary dictionaryWithContentsOfFile:
                 [parpath stringByAppendingPathComponent:@"expressions/_expression_en.plist"   ]] ;
    tempkey = [FaceBoard isExistFacail:tempkey withDic:dic];
    return tempkey;
}

+(NSDictionary *)facailDictionary
{
    NSString *parpath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"];
     NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:
                 [parpath stringByAppendingPathComponent:@"expressions/_expression_en.plist"   ]] ;
   
    return dic;
}

+(NSString *)isExistFacail:(const NSString *)key withDic:(const NSDictionary *)dic
{
     NSString *tempkey=[NSString stringWithFormat:@"%@",key];
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:
//                         [[NSBundle mainBundle] pathForResource:@"_expression_en"
//                                                         ofType:@"plist"]] ;
    if ([dic valueForKey:tempkey]) {
        return tempkey;
    }
    tempkey = [NSString stringWithFormat:@":%@",tempkey];
    if ([dic valueForKey:tempkey]) {
        return tempkey;
    }
    tempkey = [NSString stringWithFormat:@":%@:",tempkey];
    if ([dic valueForKey:tempkey]) {
        return tempkey;
    }
    return nil;
}

//算法：从字符串中找出表情标签[]
+(NSString *)addfacialpackage:(const NSString *)message dic:(NSDictionary *)dic
{
    NSString * resultMessage = [[NSString alloc] initWithFormat:@"%@",message];
    NSUInteger postion = 0;
    for (int index = 1 ; index <= FACE_MAX_LENGTH; index ++)
    {
        NSRange range = [message rangeOfString:@":" options:NSCaseInsensitiveSearch range:NSMakeRange(postion, message.length - postion)];
        NSRange range2 = [message rangeOfString:@";" options:NSCaseInsensitiveSearch range:NSMakeRange(postion, message.length - postion)];
        if (range2.location != NSNotFound) {
            range = range2;
        }
        if (range.location == NSNotFound || message.length < index) {
            break;
        }
        if ((range.location + index)>message.length) {
            break;
        }
        NSString *str=[message substringWithRange:NSMakeRange(range.location, index)];
        if ([FaceBoard isExistFacail:str withDic:dic]) {
            NSString * facialmark = [NSString stringWithFormat:@"[%@]",str];
            resultMessage = [resultMessage stringByReplacingOccurrencesOfString:str withString:facialmark];
            postion = range.location + index;
            index = 1;
        }
    }
    return resultMessage;
}

//去掉表情包外壳[]
+(NSString *)removePackage:(NSUInteger)pos text:(const NSString *)text
{
    NSString *content = [NSString stringWithFormat:@"%@",text];
    NSUInteger headpos = [content rangeOfString:@"[" options:NSCaseInsensitiveSearch range:NSMakeRange(pos, text.length - pos)].location;
    NSUInteger tailpos = [content rangeOfString:@"]"  options:NSCaseInsensitiveSearch range:NSMakeRange(pos, text.length - pos)].location;
    if (headpos!=NSNotFound && tailpos!=NSNotFound && headpos < tailpos) {
        content =[content stringByReplacingOccurrencesOfString:@"[" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, headpos+1)];
        content = [content stringByReplacingOccurrencesOfString:@"]" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tailpos)];
        NSUInteger nextheadpos = [content rangeOfString:@"["  options:NSCaseInsensitiveSearch range:NSMakeRange(0, content.length)].location;
        if (nextheadpos != NSNotFound) {
            return [self removePackage:nextheadpos text:content];
        }
    }
    return content;
}


//图文混排
+(void)getImageTextRange:(const NSString*)message array:(NSMutableArray *)array{
    //判断当前字符串是否还有表情的标志。将其分开
    NSUInteger position = 0;
    NSUInteger lastposition = 0;
    
    NSDictionary *dic = [FaceBoard facailDictionary];
    int index = 1;
    for (index = 1; index < message.length; index ++) {
        
        NSRange range=[message rangeOfString: @":" options:NSCaseInsensitiveSearch range:NSMakeRange(position, message.length - position)];
        NSRange range1=[message rangeOfString: @";" options:NSCaseInsensitiveSearch range:NSMakeRange(position, message.length - position)];
        if (range1.location != NSNotFound ) {
            range = range1;
        }
        if (range.location == NSNotFound) {
            break;
        }
        for (int j = 2; j <= FACE_MAX_LENGTH ; j++)
        {
            position = range.location;
            if ((position+j)>message.length) {
                break;
            }
            NSString * substr =[message substringWithRange:NSMakeRange(position, j)];
            NSString * prestr =[message substringWithRange:NSMakeRange(lastposition, position - lastposition)];
            
            if ([FaceBoard isExistFacail:substr withDic:dic]) {
                if (prestr) {
                    [array addObject:prestr];
                }
                [array addObject:substr];
                position = position + substr.length;
                lastposition = position;
                index = position;
                break;
            }
        }
    }
    if (index <= message.length) {
        NSString * substr =[message substringWithRange:NSMakeRange(lastposition, message.length - lastposition)];
        if (substr) {
            [array addObject:substr];
        }
    }
    
}

- (id)init {

    self = [super initWithFrame:CGRectMake(0, 0, 320, 216)];
    if (self) {

        self.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        if ([[languages objectAtIndex:0] hasPrefix:@"zh"]) {
           NSString *parpath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"];
           _faceMap = [[NSDictionary dictionaryWithContentsOfFile:
                         [parpath stringByAppendingPathComponent:@"expressions/_expression_cn.plist"   ]] retain];
        }
        else {
            NSString *parpath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"];
            _faceMap = [[NSDictionary dictionaryWithContentsOfFile:
                         [parpath stringByAppendingPathComponent:@"expressions/_expression_en.plist"   ]] retain];
            NSLog(@"%@",[_faceMap description]);
        }
       
        [[NSUserDefaults standardUserDefaults] setObject:_faceMap forKey:@"FaceMap"];
        FACE_COUNT_ALL=_faceMap.count;
        //表情盘
        faceView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 190)];
        faceView.pagingEnabled = YES;
        faceView.contentSize = CGSizeMake((FACE_COUNT_ALL / FACE_COUNT_PAGE + 1) * 320, 190);
        faceView.showsHorizontalScrollIndicator = NO;
        faceView.showsVerticalScrollIndicator = NO;
        faceView.delegate = self;
        
        NSArray *keys=_faceMap.allKeys;
        for (int i = 0; i < keys.count; i++) {
            
            FaceButton *faceButton = [FaceButton buttonWithType:UIButtonTypeCustom];
            faceButton.buttonIndex = i;
            
            [faceButton addTarget:self
                           action:@selector(faceButton:)
                 forControlEvents:UIControlEventTouchUpInside];
            
            //计算每一个表情按钮的坐标和在哪一屏
            CGFloat x = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * FACE_ICON_SIZE + 6 + ((i - 1) / FACE_COUNT_PAGE * 320);
            CGFloat y = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * FACE_ICON_SIZE + 8;
            faceButton.frame = CGRectMake( x, y, FACE_ICON_SIZE, FACE_ICON_SIZE);
            
            NSString *key=[keys objectAtIndex:i]; //
            NSString *value=[_faceMap objectForKey:key];
            [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image.bundle/expressions/%@",value]]
                        forState:UIControlStateNormal];

            [faceView addSubview:faceButton];
        }
        
        //添加PageControl
        facePageControl = [[GrayPageControl alloc]initWithFrame:CGRectMake(110, 190, 100, 20)];
        
        [facePageControl addTarget:self
                            action:@selector(pageChange:)
                  forControlEvents:UIControlEventValueChanged];
        
        facePageControl.numberOfPages = FACE_COUNT_ALL / FACE_COUNT_PAGE + 1;
        facePageControl.currentPage = 0;
        [self addSubview:facePageControl];
        
        //添加键盘View
        [self addSubview:faceView];
        
        //删除键
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setTitle:@"删除" forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"image.bundle/faceBoard/del_emoji_normal"] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"image.bundle/faceBoard/del_emoji_select"] forState:UIControlStateSelected];
        [back addTarget:self action:@selector(backFace) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(272, 182, 38, 28);
        [self addSubview:back];
    }

    return self;
}

//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [facePageControl setCurrentPage:faceView.contentOffset.x / 320];
    [facePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {

    [faceView setContentOffset:CGPointMake(facePageControl.currentPage * 320, 0) animated:YES];
    [facePageControl setCurrentPage:facePageControl.currentPage];
}

- (void)faceButton:(id)sender {

    int i = ((FaceButton*)sender).buttonIndex;
    if (delegate) { 
        NSArray *keys=_faceMap.allKeys;
        NSString *key=[keys objectAtIndex:i];
        if (delegate && [delegate respondsToSelector:@selector(facebuttonTap:andName:)]) {
             [delegate facebuttonTap:sender andName:[NSString stringWithFormat:@"%@",key]];
        }
    }
}

- (void)backFace{

    if (delegate && [delegate  respondsToSelector:@selector(faceboardBackface)]) {
        [delegate faceboardBackface];
    }
   /* NSString *inputString;
    inputString = self.inputTextField.text;
    if ( self.inputTextView ) {

        inputString = self.inputTextView.text;
    }

    if ( inputString.length ) {
        
        NSString *string = nil;
        NSInteger stringLength = inputString.length;
        if ( stringLength >= FACE_NAME_LEN ) {
            
            string = [inputString substringFromIndex:stringLength - FACE_NAME_LEN];
            NSRange range = [string rangeOfString:FACE_NAME_HEAD];
            if ( range.location == 0 ) {
                
                string = [inputString substringToIndex:
                          [inputString rangeOfString:FACE_NAME_HEAD
                                             options:NSBackwardsSearch].location];
            }
            else {
                
                string = [inputString substringToIndex:stringLength - 1];
            }
        }
        else {
            
            string = [inputString substringToIndex:stringLength - 1];
        }
        
        if ( self.inputTextField ) {
            
            self.inputTextField.text = string;
        }
        
        if ( self.inputTextView ) {
            self.inputTextView.text = string;
            [delegate textViewDidChange:self.inputTextView];
        }
    }*/
}

- (void)dealloc {
    
    [_faceMap release];
    [_inputTextField release];
    [_inputTextView release];
    [faceView release];
    [facePageControl release];
    
    [super dealloc];
}

@end

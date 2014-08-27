//
//  NSData+base64.h
//  DZ
//
//  Created by Nonato on 14-4-28.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSData (MBBase64)
+ (id)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64Encoding;
+ (NSString*)base64encode:(NSString*)str;
+ (NSString*)base64forData:(NSData*)theData;
@end


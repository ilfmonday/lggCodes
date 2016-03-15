//
//  LGGMailUtil.h
//  lggios
//
//  Created by lgg on 16/3/15.
//  Copyright © 2016年 ty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGGMailUtil : NSObject

+(NSArray<NSString*>*)mailListForInputStr:(NSString*)str withStickupMails:(NSArray<NSString*>*)stickupArr;
+(NSArray<NSString*>*)mailListForInputStr:(NSString*)str;

@end

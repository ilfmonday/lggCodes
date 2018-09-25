//
//  UnitTest.m
//  Campus
//
//  Created by lgg on 2018/8/30.
//  Copyright © 2018年 lgg. All rights reserved.
//

#import "UnitTest.h"
#import "WXCCommonDef.h"

@implementation UnitTest
+(void)handleJumpFromUrl:(NSURL*)url
{
    if(![url.host isEqualToString:@"jump"]){
        DDLogWarn(@"invalid jump url: %@",url);
        return;
    }
    NSString* queryInfo = url.query;
    NSArray* queryArr = [queryInfo componentsSeparatedByString:@"&"];
    NSString* targetInfo = @"";
    for(NSString* str in queryArr){
        if([str hasPrefix:@"target="]){
            targetInfo = str;
            break;
        }
    }
    if(STRING_EMPTY(targetInfo)){
        DDLogWarn(@"invalid jump url: %@",url);
        return;
    }
    
    NSString* targetStr = [targetInfo substringFromIndex:[targetInfo rangeOfString:@"target="].length];
    DDLogWarn(@"target str is %@", targetStr);
    if([targetStr isEqualToString:@"pstn"]){
        
    } else if([targetStr isEqualToString:@"pstn"]){
        
    } else if([targetStr isEqualToString:@"pstn"]){
        
    } else if([targetStr isEqualToString:@"pstn"]){
        
    } else if([targetStr isEqualToString:@"pstn"]){
        
    } else {
        DDLogWarn(@"invalid jump url: %@",url);
    }
    
}

@end

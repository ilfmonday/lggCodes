//
//  NSObject+LGG.m
//  lggios
//
//  Created by lgg on 16/3/15.
//  Copyright © 2016年 ty. All rights reserved.
//

#import "NSObject+LGG.h"

#pragma mark - #------------- SafeCast --------------#

@implementation NSObject (SafeCast)

+ (instancetype)safeCast:(id)any WarnOnFailure:(BOOL)warnOnFailure MethodInfo:(const char*)methodInfo
{
    if(any){
        if ([any isKindOfClass:[self class]]){
            return any;
        } else if (warnOnFailure){
            DDLogWarn(@"Can't SafeCast %@ to type %@, return nil, M:%s", any, NSStringFromClass([self class]),methodInfo);
        }
    }
    
    return nil;
}

@end

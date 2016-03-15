//
//  LGGCommonDef.h
//  lggios
//
//  Created by lgg on 16/3/15.
//  Copyright © 2016年 ty. All rights reserved.
//

#ifndef LGGCommonDef_h
#define LGGCommonDef_h

#import <Foundation/Foundation.h>

#pragma mark - #------------日志-------------#

#define DDLogInfo(f,...) NSLog(f,##__VA_ARGS__)
#define DDLogWarn(f,...) NSLog(f,##__VA_ARGS__)
#define DDLogError(f,...) NSLog(f,##__VA_ARGS__)
#define DDLogVerbose(f,...) NSLog(f,##__VA_ARGS__)

#pragma mark - #------------判空-------------#
#define ARRAY_EMPTY(arr) (!arr || arr.count==0)
#define STRING_EMPTY(str) (!str || str.length==0)


#pragma mark - #------------String-------------#

#define NON_NULL_STRING(str)((STRING_EMPTY(str) ? @"" : str))
#define DATA_TO_STRING(data) [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

#pragma mark - #------------block-------------#

#define SAFE_CALL_BLOCK(block,...) \
if(block){ \
block(__VA_ARGS__); \
}

#pragma mark - #------------线程-------------#
NS_INLINE void execOnMainThread(void(^block)(void))
{
    if ( block == NULL ) {
        return;
    }

    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

NS_INLINE void execOnMainThreadAsync(void(^block)(void))
{
    if ( block == NULL ) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), block);
}


#endif /* LGGCommonDef_h */

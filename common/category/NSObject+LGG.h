//
//  NSObject+LGG.h
//  lggios
//
//  Created by lgg on 16/3/15.
//  Copyright © 2016年 ty. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - #------------- SafeCast --------------#

#define CAST(clz,obj) ([clz safeCast:(obj) WarnOnFailure:YES MethodInfo:__PRETTY_FUNCTION__])
#define AS(clz,obj) ([clz safeCast:(obj) WarnOnFailure:NO MethodInfo:nil])

@interface NSObject (SafeCast)

/**
 * 把某对象转换为某类型的对象
 * UIImageView* imgView = [UIImageView safeCast:view WarnOnFailure:YES];
 * if(imgView)....
 */
+ (instancetype)safeCast:(id)any WarnOnFailure:(BOOL)warnOnFailure MethodInfo:(const char*)methodInfo;

@end

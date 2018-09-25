//
//  WXCCommonDef.h
//  wework
//
//  Created by lgg on 15/12/2.
//  Copyright © 2015年 rdgz. All rights reserved.
//

#ifndef WXCCommonDef_h
#define WXCCommonDef_h

#pragma mark - #------------- 头文件引用部分 --------------#

#import <Foundation/Foundation.h>


#pragma mark - #------------- 单例 --------------#

#define HB_IS_TONY YES  //红包逻辑给tony使用版本
#define HB_TONY_SIGNVID @"TONY_SIGN_VID" //标志一个特殊的vid，toVidList中进行判断处理

#ifdef __IPHONE_5_0
#   define _ONE_WAY oneway
#else
#   define _ONE_WAY
#endif

#ifdef __IPHONE_5_0
#   define _ONE_WAY oneway
#else
#   define _ONE_WAY
#endif

#define __CSF_SINGLETON_DECLARE(TypeName) +(TypeName*) sharedInstance;
#if __has_feature(objc_arc) // ARC
#define __CSF_SINGLETON_DEFINE(TypeName) static TypeName* static_instance;\
+(instancetype)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
static_instance = [[self alloc] init];\
}); \
return static_instance; \
} \
+(id)allocWithZone:(NSZone *)zone \
{ \
if (static_instance == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
static_instance = [super allocWithZone:zone]; \
}); \
} \
return static_instance; \
} \
\
-(id)copyWithZone:(NSZone *)zone \
{ \
return static_instance; \
} \
\
-(id)mutableCopyWithZone:(NSZone *)zone \
{ \
return static_instance;\
}

#else // 非ARC

#define __CSF_SINGLETON_DEFINE(TypeName) static TypeName* static_instance;\
+(TypeName*) sharedInstance {\
@synchronized(self) {\
if (static_instance == nil) {\
static_instance = [[TypeName alloc] init];\
}\
}\
return static_instance;\
}\
+ (id)allocWithZone:(NSZone *)zone\
{\
@synchronized(self) {\
if (static_instance == nil) {\
static_instance = [super allocWithZone:zone];\
}\
}\
return static_instance;\
}\
- (id)copyWithZone:(NSZone *)zone {\
return self;\
}\
- (id)retain {\
return self;\
}\
- (NSUInteger)retainCount {\
return UINT_MAX;\
}\
- (_ONE_WAY void)release {\
}\
- (id)autorelease {\
return self;\
}
#endif


#pragma mark - #------------- retain release 相关 MRC时代 --------------#

#define RELEASE_SAFELY(__POINTER)       { if(__POINTER != nil){  [__POINTER release]; __POINTER = nil; }}
#define RELEASE_SAFELY_ARC(__POINTER)

#define SAFE_DELETE(x) if(x != nil){ [x release]; x = nil; }
#define ARC_SAFE_DELETE(x) if(x != nil){ x = nil; }
#define SAFE_RETAIN(x) if(x != nil){ [x retain]; }
#define MAKE_SAFE_NSSTRING(x)    if (x == nil) { x = @"";}

#define SETTER_RETAIN(x, value)    {id tmpValue = value; [tmpValue retain]; [x release]; x = tmpValue;}

#ifndef _CFRELESE
#define _CFRELESE(x) if (NULL != (x)){CFRelease((x)); x = NULL;}
#endif

#ifndef _RELEASE
#define _RELEASE(x)  if( nil != (x) ) { [(x) release] ;  (x) = nil ; }
#endif


#pragma mark - #------------- string array相关 --------------#

#define RETURN_STR(x) (x==NULL)?"":x
#define RETURN_NSSTRING(x) (x==nil)?@"":x
#define SAFE_DECREASE(x, y) if(x >= y) { x = x - y;}

//判空逻辑
#define ARRAY_EMPTY(arr) (!arr || arr.count==0)
#define STRING_EMPTY(str) (!str || str.length==0)
#define ENUM_NUM(value) @((int)value)
#define QCSTRLEN(x) (((x) == NULL) ? 0 : strlen(x))

#pragma mark - #------------ 杂碎 -------------#
#define DEF_WEAK(class,name,target) __weak class* name = target
#define WEAK_OBJ(name,target) __weak __typeof(target) name = target
#define CLOSE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil]
#define REMOVE_OBJNOTI(obj) [[NSNotificationCenter defaultCenter] removeObserver:obj]
#define CLOSE_KEYBOARD_FORTWOWINDOW [[[[UIApplication sharedApplication] delegate] window] endEditing:YES]; [[[UIApplication sharedApplication]keyWindow] endEditing:YES]
#define APP_KEY_WINDOW [[UIApplication sharedApplication]keyWindow]

#define SAFE_CALL_BLOCK(block,...) \
if(block){ \
block(__VA_ARGS__); \
}

#define TIMEINTERVAL1970() (CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970)

#define USER_HIDE_PHONE(user) (user->GetUserInfo() && (user->GetUserInfo()->attr() & CRTX::IS_HIDE_MOBILE))
#define CORP_HIDE_PHONE(user) (user->GetUserInfo() && (user->GetUserInfo()->attr() & CRTX::CORP_HIDE_MOBILE))
#define EXTERNALCONTACT_HIDE_PHONE(user) (user->GetUserInfo() && (user->GetUserInfo()->attr() & CRTX::CONTACT_IS_HIDE_MOBILE))

//#define USER_DOHAVE_PHONE(user) (user->GetUserInfo() && ( (user->GetUserInfo()->mobile().size()>0) || !(user->GetUserInfo()->attr() & CRTX::IS_USER_MOBILE_EMPTY)  ) ) //用户是否真正拥有手机号码。
#define USER_PHONE_REAL_EMPTY(user) ( !user.get() || ( (user->GetUserInfo()->mobile().size()==0) && (user->GetUserInfo()->attr() & CRTX::IS_USER_MOBILE_EMPTY) ) )

#pragma mark - #------------- 日志关闭 --------------#




#ifdef DEBUG
#define DDLogDebug(f,...)       _wxc_DDLOG_TOCPP(0,f,##__VA_ARGS__)
#else
#define DDLogDebug(f,...)
#endif


#define lggLogVerbose   DDLogVerbose
#define lggLogInfo      DDLogInfo
#define lggLogWarn      DDLogWarn
#define lggLogErr       DDLogError


#pragma mark - #------------- 用户交互 --------------#
#define FORBID_INTERACTION [[UIApplication sharedApplication]beginIgnoringInteractionEvents]
#define ALLOW_INTERACTION [[UIApplication sharedApplication]endIgnoringInteractionEvents]
#define IOS8PLUS_JUMPTOSETTING [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]

#pragma mark - #------------- RTX C++ --------------#
#define STRUCT_USER_EQUAL(a,b) ((a == b) || (a.get() && b.get() && a->GetUserInfo()->remote_id() == b->GetUserInfo()->remote_id()))

#pragma mark - #------------- VIEW WINDOW 尺寸 --------------#
#undef SCREEN_WIDTH
#undef SCREEN_HEIGHT
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)

#define NavBarHeight 44

#define SCREEN_W_320 (SCREEN_WIDTH == 320) //4,5
#define SCREEN_W_375 (SCREEN_WIDTH == 375) //6
#define SCREEN_W_414 (SCREEN_WIDTH == 414) //6p
#define SCREEN_H_480 (SCREEN_HEIGHT == 480) //4
#define SCREEN_H_568 (SCREEN_HEIGHT == 568) //5
#define SCREEN_H_667 (SCREEN_HEIGHT == 667) //6
#define SCREEN_H_736 (SCREEN_HEIGHT == 736) //6p

#define IS_32BIT_CPU (sizeof(void*) == 4) //32位cpu

#define ONE_PIXEL_SIZE (1.f/[UIScreen mainScreen].scale)

#define IS_IPHONE [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] || [[[UIDevice currentDevice] model] isEqualToString:@"iPad"])

// 判断设备
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_HEIGHT < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_HEIGHT == 736.0)
#define IS_IPHONE_6_OR_LATER (IS_IPHONE_6 || IS_IPHONE_6P)
#define IS_IPHONE_X ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].nativeBounds.size.height == 2436)

#define DEVICE_IS_PORTRAIT UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)
#define DEVICE_IS_LANDSCAPE UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

#pragma mark - mark - #------------- UIColor相关创建 --------------#
//#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#define UIColorMakeWithHex(hex) [UIColor colorWithHexString:hex]
//#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

#pragma mark - mark - #------------- UIFont相关创建 --------------#
#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define UIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
//#define UIDynamicFontMake(size) [UIFont fontWithSize:size bold:NO]
//#define UIDynamicFontMakeWithLimit(size, upperLimit, lowerLimit) [UIFont fontWithSize:size upperLimitSize:upperLimit lowerLimitSize:lowerLimit bold:NO]
//#define UIDynamicFontBoldMake(size) [UIFont fontWithSize:size bold:YES]
//#define UIDynamicFontBoldMakeWithLimit(size, upperLimit, lowerLimit) [UIFont fontWithSize:size upperLimitSize:upperLimit lowerLimitSize:lowerLimit bold:YES]

#pragma mark - #------------- 判空返回 --------------#
#define _wxc_RETURN_WHEN_EMPTY_void(obj) if(!obj){return;}
#define _wxc_RETURN_WHEN_EMPTY_NO(obj) if(!obj){return NO;}
#define _wxc_RETURN_WHEN_EMPTY_YES(obj) if(!obj){return YES;}
#define _wxc_RETURN_WHEN_EMPTY_nil(obj) if(!obj){return nil;}

#define RETURN_WHEN_EMPTY(obj,ret) _wxc_RETURN_WHEN_EMPTY_##ret(obj)

#pragma mark - #------------- 18n 关闭 --------------#
#define WXCLOCALIZED_STRING(str) str
#define LCSTR_Common_InstantMessages 即时通讯

#pragma mark - #------------- 颜色 --------------#
#define CLR_CLEAR [UIColor clearColor]

#define NO_NULL_NSSTRING(s) (s.length <= 0 ? @"" : s)

#pragma mark - 变量-编译相关

#ifndef __IPHONE_10_3
#define __IPHONE_10_3 100300
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_3
#define IOS103_SDK_ALLOWED YES
#endif


#pragma mark - #------------- 线程执行 --------------#


#pragma mark - #------------------------  屏幕适配器 以Iphone5做标准，归一化为0～1,以竖屏为准   ------------------------ #
#pragma mark - #------------- 动画 --------------#

#define PREPARE_ANIMATION_WITH_ID(t,f,id) \
[UIView beginAnimations:id context:NULL];\
[UIView setAnimationDuration:t];\
[UIView setAnimationDelegate:self];\
[UIView setAnimationDidStopSelector:f]

#define COMMIT_ANIMATION [UIView commitAnimations]


#endif /* WXCCommonDef_h */

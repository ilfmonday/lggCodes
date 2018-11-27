//
//  WXCEngineConfigMgr.h
//  WXCSDKDylib
//
//  Created by lgg on 2018/11/7.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DDLogWarn NSLog
#define DDLogError NSLog

@interface WXCEngineConfigMgr : NSObject
+ (instancetype)sharedInstance;

-(void)parseEngineConfigXML:(NSString*)xmlStr;
@end


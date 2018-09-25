//
//  main.m
//  Campus
//
//  Created by lgg on 2018/8/6.
//  Copyright © 2018年 lgg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitTest.h"

#define DDLogWarn NSLog

uint64_t firstDayTimeInWeek(uint64_t currSec);

int main(int argc, const char * argv[]) {
    NSLog(@"fir: %llu", firstDayTimeInWeek(1535299200));
    NSLog(@"fir: %llu", firstDayTimeInWeek(1534694400));
    
    NSURL* url = [NSURL URLWithString:@"https://work.weixin.qq.com/wework_admin/offline_check?_offid=100"];
    DDLogWarn(@"host: %@",url.host);
    DDLogWarn(@"host: %@",url.path);
    
    
    return 0;
}

uint64_t firstDayTimeInWeek(uint64_t currSec)
{
    time_t t = (time_t)currSec;
    struct tm* tm= localtime(&t);
    if(!tm){
        return currSec;
    }
    tm->tm_hour = 0;
    tm->tm_min = 0;
    tm->tm_sec = 0;
    auto dayDelta = 1 - (tm->tm_wday == 0 ? 7 : tm->tm_wday);
    auto zeroSec = mktime(tm);
    zeroSec += 86400 * dayDelta;
    return zeroSec;
}



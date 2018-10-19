//
//  main.m
//  Campus
//
//  Created by lgg on 2018/8/6.
//  Copyright © 2018年 lgg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitTest.h"
#import "person.hpp"

#define DDLogWarn NSLog

class Member{
public:
    ~Member(){NSLog(@"Member dealloc");}
};

class Container{
public:
    Container(Member mem):_member(mem){
        
    }
    ~Container(){NSLog(@"Container dealloc");}
private:
    Member _member;
};

uint64_t firstDayTimeInWeek(uint64_t currSec);
void cppConstructMethodLearn();

int main(int argc, const char * argv[]) {
    
    cppConstructMethodLearn();
    return 0;
}

void cppConstructMethodLearn()
{
    lgg::Person p1;
    DDLogWarn(@"--------1--------");
    lgg::Person();
    DDLogWarn(@"--------2--------");
    auto p2 = p1;
    DDLogWarn(@"-------3--------");
    auto&& p3  = lgg::Person();
    DDLogWarn(@"--------4--------");
    p3 = p1;
    DDLogWarn(@"---------5-------");
    auto&& p4 = std::move(p1); //不会调用移动构造，只是定义引用
    DDLogWarn(@"--------6-------");
    auto p5 = std::move(p1); //调用移动构造
    DDLogWarn(@"--------7-------");
    auto p6 = static_cast<lgg::Person&&>(p1);
    DDLogWarn(@"--------8-------");
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



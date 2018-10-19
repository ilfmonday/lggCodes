//
//  person.cpp
//  Campus
//
//  Created by lgg on 2018/10/19.
//  Copyright © 2018 lgg. All rights reserved.
//

#include "person.hpp"
#import <Foundation/Foundation.h>

namespace lgg {
    Person::Person():age_(10){
        nameptr_ = new std::string();
        *nameptr_ = "lgg";
        NSLog(@"person CONSTRUCT, %s, %lld",nameptr_->c_str(),(int64_t)nameptr_);
    }
    Person::~Person()
    {
        NSLog(@"person DESTRUCT, %s, %lld",nameptr_ ? nameptr_->c_str() : "nullptr",(int64_t)nameptr_);
        delete nameptr_;
    }
    Person::Person(const Person& p)
    {
        auto str = *(p.nameptr_);
        delete nameptr_;
        nameptr_ = new std::string();
        *nameptr_ = str;
        age_ = p.age_;
        NSLog(@"person COPY_CONSTRUCT, %s, %lld",nameptr_->c_str(),(int64_t)nameptr_);
    }
    Person& Person::operator=(const Person& p)
    {
        auto str = *(p.nameptr_);
        delete nameptr_;
        nameptr_ = new std::string();
        *nameptr_ = str;
        age_ = p.age_;
        NSLog(@"person COPY_ASSIGN, %s, %lld",nameptr_->c_str(),(int64_t)nameptr_);
        return *this;
    }
    Person::Person(Person&& p) noexcept
    {
        nameptr_ = p.nameptr_;
        p.nameptr_ = nullptr;
        age_ = p.age_;
        NSLog(@"person MOVE_CONSTRUCT, %s, %lld",nameptr_->c_str(),(int64_t)nameptr_);
    }
    
    
}

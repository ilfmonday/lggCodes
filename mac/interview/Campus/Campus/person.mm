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
        NSLog(@"person alloc, %s, %lld",nameptr_->c_str(),(int64_t)nameptr_);
    }
    Person::~Person()
    {
        NSLog(@"person dealloc, %s, %lld",nameptr_->c_str(),(int64_t)nameptr_);
        delete nameptr_;
    }
    Person::Person(const Person& p)
    {
        nameptr_ = new std::string();
        *nameptr_ = *(p.nameptr_);
        age_ = p.age_;
        NSLog(@"person copy alloc, %s, %lld",nameptr_->c_str(),(int64_t)nameptr_);
    }
    Person& Person::operator=(const Person& p)
    {
        return *this;
    }
    
    
}

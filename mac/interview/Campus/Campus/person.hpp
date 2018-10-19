//
//  person.hpp
//  Campus
//
//  Created by lgg on 2018/10/19.
//  Copyright © 2018 lgg. All rights reserved.
//

#ifndef person_hpp
#define person_hpp

#include <stdio.h>
#include <string>

namespace lgg {
    class Person{
    public:
        Person();
        virtual ~Person();
        Person(const Person&);
        Person& operator=(const Person&);
        std::string Name(){return *nameptr_;}
        uint64_t NameAddr(){return (uint64_t)nameptr_;};
    private:
        std::string* nameptr_;
        int age_;
    };
}



#endif /* person_hpp */

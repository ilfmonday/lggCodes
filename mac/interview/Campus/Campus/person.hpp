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
        explicit Person();
        ~Person();
        Person(const Person&);
        Person& operator=(const Person&);
        Person(Person&& p) noexcept;
        std::string Name(){return *nameptr_;}
        uint64_t NameAddr(){return (uint64_t)nameptr_;};
    private:
        std::string* nameptr_;
        int age_;
    };
    class Son : public Person{
        ~Son();
    };
}



#endif /* person_hpp */

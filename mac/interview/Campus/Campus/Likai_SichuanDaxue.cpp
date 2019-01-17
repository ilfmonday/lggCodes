//
//  Likai_SichuanDaxue.cpp
//  Campus
//
//  Created by lgg on 2018/8/6.
//  Copyright © 2018年 lgg. All rights reserved.
//

#include "Likai_SichuanDaxue.hpp"
#include <iostream>

namespace cppl {
    
    template <typename T1>
    int print(T1 t) {
        std::cout << t << "\t";
        return 1;
    }
    
    template <typename T1, typename... TS>
    int print(T1 t, TS... ts) {
        print(t);
        return print(ts...);
    }
    
    void PrintRecursive()
    {
        int rr = print("a",1,2);
        std::cout << "\n";
        std::cout << "print Reuslt is" << rr;
    }
}

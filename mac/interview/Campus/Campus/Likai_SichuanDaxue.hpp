//
//  Likai_SichuanDaxue.hpp
//  Campus
//
//  Created by lgg on 2018/8/6.
//  Copyright © 2018年 lgg. All rights reserved.
//

#ifndef Likai_SichuanDaxue_hpp
#define Likai_SichuanDaxue_hpp

#include <stdio.h>

struct ListNode {
    int value;
    ListNode* next;
};

void deleteCurrNode(ListNode* node);

namespace cppl {
    void PrintRecursive();
}

#endif /* Likai_SichuanDaxue_hpp */

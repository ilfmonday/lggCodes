//
//  Xufeiyu_SichuanDaxue.hpp
//  Campus
//
//  Created by lgg on 2018/8/8.
//  Copyright © 2018年 lgg. All rights reserved.
//

#ifndef Xufeiyu_SichuanDaxue_hpp
#define Xufeiyu_SichuanDaxue_hpp

#include <stdio.h>

namespace xufeiyu {
    struct ListNode {
        int value;
        ListNode* next;
    };
    ListNode* createLinkList();
    void printLinkList(ListNode* head);
    void deleteNode(ListNode* node);
    int countOfOne(int a);
    void MergeSort(int a[], int temp[], int start, int end);
}



#endif /* Xufeiyu_SichuanDaxue_hpp */

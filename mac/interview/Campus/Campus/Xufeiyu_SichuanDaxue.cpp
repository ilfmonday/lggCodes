//
//  Xufeiyu_SichuanDaxue.cpp
//  Campus
//
//  Created by lgg on 2018/8/8.
//  Copyright © 2018年 lgg. All rights reserved.
//

#include "Xufeiyu_SichuanDaxue.hpp"


namespace xufeiyu{
    
    ListNode* createLinkList()
    {
        ListNode *head = new ListNode;
        ListNode *node;
        
        head->value = 0;
        node = head;
        
        for (int i = 0; i < 10; ++i) {
            node->next = new ListNode;
            node->next->value = i;
            node = node->next;
        }
        
        return head;
        
    }
    void printLinkList(ListNode* head)
    {
        ListNode *node = head;
        while (node != NULL) {
            printf("%d\n", node->value);
            node = node->next;
        }
    }
    
    int countOfOne(int a)
    {
        int count = 0;
        while (a != 0) {
            if (a % 2 == 1) {
                ++count;
            }
            a = a >> 1;
        }
        
        return count;
    }
    
    void Merge(int a[], int temp[], int start, int mid, int end) {
        int i = start;
        int j = mid + 1;
        int k = start;
        
        while (i != mid + 1 && j != end + 1) {
            if (a[i] < a[j]) {
                temp[k++] = a[i++];
            } else {
                temp[k++] = a[j++];
            }
        }
        
        while (i != mid + 1) {
            temp[k++] = a[i++];
        }
        
        while (j != end + 1) {
              temp[k++] = a[j++];
        }
        
        for (i = start; i <= end; ++i) {
            a[i] = temp[i];
        }
    }
    
    void MergeSort(int a[], int temp[], int start, int end) {
        int mid;
        if (start < end) {
            mid = start + (end - start) / 2;
            
            MergeSort(a, temp, start, mid);
            MergeSort(a, temp, mid + 1, end);
            Merge(a, temp, start, mid, end);
        }
    }
    
    void deleteNode(ListNode* node)
    {
        
    }
}
    

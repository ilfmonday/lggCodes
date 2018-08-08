//
//  main.m
//  Campus
//
//  Created by lgg on 2018/8/6.
//  Copyright © 2018年 lgg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Xufeiyu_SichuanDaxue.hpp"

int main(int argc, const char * argv[]) {
    NSLog(@"hello world");
    
//    auto head = xufeiyu::createLinkList();
//    xufeiyu::printLinkList(head);
    int a[10] = {9, 8, 7, 6, 5, 4, 3, 2, 1};
    int temp[10];
    xufeiyu::MergeSort(a, temp, 0, 9);
    
    for (int i = 0; i < 10; i++) {
        printf("%d\n", a[i]);
    }
    
    return 0;
}

//
//  ViewController.m
//  lggios
//
//  Created by lgg on 16/3/14.
//  Copyright © 2016年 ty. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,copy)NSString* ccStr;
@end

@interface ViewController ()
@property (nonatomic,copy)NSString* bbStr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor   = [UIColor grayColor];
    
    execOnMainThread(^{
       
        [[[UIAlertView alloc]initWithTitle:@"234" message:@"asfd" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
    });
    
    NSLog(@"Controller加载完毕");
}

@end

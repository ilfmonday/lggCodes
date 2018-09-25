//
//  ViewController.m
//  lggios
//
//  Created by lgg on 16/3/14.
//  Copyright © 2016年 ty. All rights reserved.
//

#import "ViewController.h"

@interface TouchView : UIView
@end

@interface ViewController ()
@property (nonatomic,copy)NSString* ccStr;
@end

@interface ViewController ()
@property (nonatomic,copy)NSString* bbStr;
@property (nonatomic,strong)UIView* contentView;
@property (nonatomic,strong)UIView* contentSubView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor   = [UIColor grayColor];
    
    self.contentView = [[TouchView alloc]init];
    self.contentView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.contentView];
    
    self.contentSubView = [[UIView alloc]init];
    self.contentSubView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.contentSubView];
    
    self.contentView.frame = CGRectMake(100, 100, 150, 80);
    self.contentSubView.frame = CGRectMake(30, 20, 75, 40);
    
    execOnMainThread(^{
       
        [[[UIAlertView alloc]initWithTitle:@"234" message:@"asfd" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
    });
    
    NSLog(@"Controller加载完毕");
}




-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}

@end

#define TRANS_SCALE .9f

@implementation  TouchView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, TRANS_SCALE, TRANS_SCALE);
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, TRANS_SCALE, TRANS_SCALE);
    [super touchesMoved:touches withEvent:event];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.transform = CGAffineTransformIdentity;
    [super touchesEnded:touches withEvent:event];
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.transform = CGAffineTransformIdentity;
    [super touchesCancelled:touches withEvent:event];
    
}



@end


//
//  LGGBlockObject.m
//  lggios
//
//  Created by lgg on 16/3/15.
//  Copyright © 2016年 ty. All rights reserved.
//

#import "LGGBlockObject.h"

typedef void (^ObjAction)(id obj1);
typedef void (^BoolAction)(BOOL suc);
typedef void (^BoolObjAction)(BOOL suc, id obj1);

#define BLOCK_CALL(blkType,action,...) if(action){ execOnMainThread(^{  ( (blkType)action )(__VA_ARGS__);  }); }

@implementation LGGBlockObject

-(instancetype)initWithBlock:(id)block
{
    self = [super init];
    if(self){
        _action = block;
    }
    return self;
}

-(void)callWithTypeAndParas:(LGGBlockObjectParaType)type, ...
{
    va_list args;
    va_start(args,type);
    
    switch (type) {
        case LGGBlockObjectParaType_Bool:
            [self p_callBool:args];
            break;
            
        case LGGBlockObjectParaType_Obj:
            [self p_callObj:args];
            break;
            
        case LGGBlockObjectParaType_BoolObj:
            [self p_callBoolOjb:args];
            break;
            
        default:
            break;
    }
    
    va_end(args);
    DDLogInfo(@"[BlockObject]: call2.1 调用完毕");

    
}

-(void)p_callBool:(va_list)args
{
    
    BOOL bb = (BOOL)va_arg(args, int);
    
    BLOCK_CALL(BoolAction, _action, bb);
}

-(void)p_callObj:(va_list)args
{
    id obj = va_arg(args, id);
    
    BLOCK_CALL(ObjAction, _action, obj);
}

-(void)p_callBoolOjb:(va_list)args
{
    BOOL bb = (BOOL)va_arg(args, int);
    id obj = va_arg(args, id);
    
    BLOCK_CALL(BoolObjAction, _action, bb, obj);
}


@end

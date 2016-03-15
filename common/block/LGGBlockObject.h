//
//  LGGBlockObject.h
//  lggios
//
//  Created by lgg on 16/3/15.
//  Copyright © 2016年 ty. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LGGBlockObjectParaType)
{
    LGGBlockObjectParaType_Bool,
    LGGBlockObjectParaType_BoolObj,
    LGGBlockObjectParaType_Obj,
};

@interface LGGBlockObject : NSObject

@property(nonatomic,copy)id action; //block
@property(nonatomic,assign)LGGBlockObjectParaType paraType;


-(instancetype)initWithBlock:(id)ocBlock;
-(void)callWithTypeAndParas:(LGGBlockObjectParaType)type, ...;


@end

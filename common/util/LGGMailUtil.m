//
//  LGGMailUtil.m
//  lggios
//
//  Created by lgg on 16/3/15.
//  Copyright © 2016年 ty. All rights reserved.
//

#import "LGGMailUtil.h"

#define MIN_CHAR 1 //输入三个字符才展示列表

@implementation LGGMailUtil

static NSArray* mailCandidates = nil;

+(void)initMailCandidates
{
    if(!mailCandidates){
        mailCandidates = @[@"qq.com",@"tencent.com",@"163.com",@"126.com",@"sina.com"];
    }
}

+(NSArray<NSString*>*)mailListForInputStr:(NSString*)str
{
    return [self mailListForInputStr:str withStickupMails:nil];
}

+(NSArray<NSString*>*)mailListForInputStr:(NSString*)str withStickupMails:(NSArray<NSString*>*)stickupArr
{
    [self initMailCandidates];
    
    NSMutableArray* arr = @[].mutableCopy;
    
    if(str.length < MIN_CHAR){
        return [arr copy];
    }
    
    //插入置顶
    NSMutableArray* candicateMutal = [NSMutableArray arrayWithArray:mailCandidates];
    if(!ARRAY_EMPTY(stickupArr)){
        for(int i= (int)stickupArr.count-1; i>=0 ; i--){ //从后往前
            NSString* curStr = stickupArr[i];
            [candicateMutal removeObject:curStr];
            [candicateMutal insertObject:curStr atIndex:0];
        }
    }
    
    
    if([self p_isValidEmailPrefixWithString:str]){ //只包含前缀
        
        for(NSString* suffix in candicateMutal){
            [arr addObject:[NSString stringWithFormat:@"%@@%@",str,suffix]];
        }
        
    } else if([self p_numberOfAT:str]==1){ //只包含了1个at
        
        NSArray* partArr = [str componentsSeparatedByString:@"@"];
        NSString* prefix = partArr[0];
        NSString* suffix = partArr[1];
        
        if([self p_isValidEmailPrefixWithString:prefix]){ //去掉@前缀合法
            
            for(NSString* sstr in candicateMutal){
                if(STRING_EMPTY(suffix) || [sstr rangeOfString:suffix].location == 0){ //abc@ 或者 abc@1 必须开头match
                    [arr addObject:[NSString stringWithFormat:@"%@@%@",prefix,sstr]];
                }
            }
        }
    }
    
    return [arr copy];
    
}

+(BOOL)isValidEmailWithString:(NSString*)str
{
    return [self p_isValidEmailStrict:YES withString:str];
}


#pragma mark - #------------私有-------------#

+(int)p_numberOfAT:(NSString*)mailStr
{
    if(STRING_EMPTY(mailStr)){
        return 0;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@" options:NSRegularExpressionCaseInsensitive error:&error];
    if(error){
        DDLogError(@"邮箱AT检测发生错误: %@",error);
        return 0;
    }
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:mailStr options:0 range:NSMakeRange(0, [mailStr length])];
    
    return (int)numberOfMatches;
}

+(BOOL)p_isValidEmailStrict:(BOOL)isStrict withString:(NSString*)str
{
    if(STRING_EMPTY(str)){
        return NO;
    }
    
    BOOL stricterFilter = isStrict;
    static NSString* const stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    static NSString* const laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];

}

+(BOOL)p_isValidEmailPrefixWithString:(NSString*)str
{
    if(STRING_EMPTY(str)){
        return NO;
    }
    static NSString* const prefixReg = @"^[A-Z0-9a-z\\._%+-]+$";
    NSPredicate* prefixPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",prefixReg];
    return [prefixPredicate evaluateWithObject:str];

}

+(BOOL)p_isValidEmailSuffixWithString:(NSString*)str
{
    if(STRING_EMPTY(str)){
        return NO;
    }
    
    static NSString* const suffixReg = @"^([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSPredicate* suffixPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",suffixReg];
    return [suffixPredicate evaluateWithObject:str];
}

@end

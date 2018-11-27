//
//  WXCEngineConfigMgr.m
//  WXCSDKDylib
//
//  Created by lgg on 2018/11/7.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import "WXCEngineConfigMgr.h"
#define AS(type,any) ([any isKindOfClass:[type class]] ? (type*)any : nil)

#pragma mark - #------------XMLReader-------------#
enum {
    XMLReaderOptionsProcessNamespaces           = 1 << 0, // Specifies whether the receiver reports the namespace and the qualified name of an element.
    XMLReaderOptionsReportNamespacePrefixes     = 1 << 1, // Specifies whether the receiver reports the scope of namespace declarations.
    XMLReaderOptionsResolveExternalEntities     = 1 << 2, // Specifies whether the receiver reports declarations of external entities.
};
typedef NSUInteger XMLReaderOptions;
@interface XMLReader : NSObject <NSXMLParserDelegate>
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLReaderOptions)options error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLReaderOptions)options error:(NSError **)errorPointer;
@end

NSString *const kXMLReaderTextNodeKey        = @"text";
NSString *const kXMLReaderAttributePrefix    = @"@";

@interface XMLReader ()
@property (nonatomic, strong) NSMutableArray *dictionaryStack;
@property (nonatomic, strong) NSMutableString *textInProgress;
@property (nonatomic, strong) NSError *errorPointer;
@end

@implementation XMLReader

#pragma mark - Public methods

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)error
{
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data options:0];
    return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)error
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [XMLReader dictionaryForXMLData:data error:error];
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLReaderOptions)options error:(NSError **)error
{
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data options:options];
    return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLReaderOptions)options error:(NSError **)error
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [XMLReader dictionaryForXMLData:data options:options error:error];
}

- (id)initWithError:(NSError **)error
{
    self = [super init];
    if (self)
    {
        self.errorPointer = *error;
    }
    return self;
}

- (NSDictionary *)objectWithData:(NSData *)data options:(XMLReaderOptions)options
{
    // Clear out any old data
    self.dictionaryStack = [[NSMutableArray alloc] init];
    self.textInProgress = [[NSMutableString alloc] init];
    
    // Initialize the stack with a fresh dictionary
    [self.dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    [parser setShouldProcessNamespaces:(options & XMLReaderOptionsProcessNamespaces)];
    [parser setShouldReportNamespacePrefixes:(options & XMLReaderOptionsReportNamespacePrefixes)];
    [parser setShouldResolveExternalEntities:(options & XMLReaderOptionsResolveExternalEntities)];
    
    parser.delegate = self;
    BOOL success = [parser parse];
    
    // Return the stack's root dictionary on success
    if (success)
    {
        NSDictionary *resultDict = [self.dictionaryStack objectAtIndex:0];
        return resultDict;
    }
    
    return nil;
}


#pragma mark -  NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // Get the dictionary for the current level in the stack
    NSMutableDictionary *parentDict = [self.dictionaryStack lastObject];
    
    // Create the child dictionary for the new element, and initilaize it with the attributes
    NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
    [childDict addEntriesFromDictionary:attributeDict];
    
    // If there's already an item for this key, it means we need to create an array
    id existingValue = [parentDict objectForKey:elementName];
    if (existingValue)
    {
        NSMutableArray *array = nil;
        if ([existingValue isKindOfClass:[NSMutableArray class]])
        {
            // The array exists, so use it
            array = (NSMutableArray *) existingValue;
        }
        else
        {
            // Create an array if it doesn't exist
            array = [NSMutableArray array];
            [array addObject:existingValue];
            
            // Replace the child dictionary with an array of children dictionaries
            [parentDict setObject:array forKey:elementName];
        }
        
        // Add the new child dictionary to the array
        [array addObject:childDict];
    }
    else
    {
        // No existing value, so update the dictionary
        [parentDict setObject:childDict forKey:elementName];
    }
    
    // Update the stack
    [self.dictionaryStack addObject:childDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // Update the parent dict with text info
    NSMutableDictionary *dictInProgress = [self.dictionaryStack lastObject];
    
    // Set the text property
    if ([self.textInProgress length] > 0)
    {
        // trim after concatenating
        NSString *trimmedString = [self.textInProgress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [dictInProgress setObject:[trimmedString mutableCopy] forKey:kXMLReaderTextNodeKey];
        
        // Reset the text
        self.textInProgress = [[NSMutableString alloc] init];
    }
    
    // Pop the current dict
    [self.dictionaryStack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // Build the text value
    [self.textInProgress appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    // Set the error pointer to the parser's error object
    self.errorPointer = parseError;
}

@end



#pragma mark - #------------WXCEngineConfigMgr-------------#

@interface WXCEngineConfigMgr ()<NSXMLParserDelegate>
@end

@implementation WXCEngineConfigMgr

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static WXCEngineConfigMgr *instance = nil;
    dispatch_once(&once, ^{
        instance = [[WXCEngineConfigMgr alloc] init];
    });
    return instance;
}

-(void)parseEngineConfigXML:(NSString*)xmlStr
{
    if(xmlStr.length == 0){
        DDLogWarn(@"No engine config xml info");
        return;
    }
    NSError* err = nil;
    NSDictionary* xmlDic = [XMLReader dictionaryForXMLString:xmlStr error:&err];
    if(err){
        DDLogError(@"Error parse xml: %@", err);
        return;
    }
    
    NSInteger value = 0;
    BOOL found = NO;
    found = [self findDigiValueFromKey:@".voip.audio.streamtype" withDic:xmlDic outValue:&value];
    DDLogWarn(@"find:%d, value:%ld",found,value);
}

-(NSString*)p_findStrValueFromDic:(NSDictionary*)dic keyStr:(NSString*)key
{
    //".voip.audio.speakerstreamtype"
    NSArray* arr = [key componentsSeparatedByString:@"."];
    NSDictionary* innerDic = dic;
    NSString* valueStr = nil;
    for(NSString* k in arr){
        if(k.length){
            innerDic = AS(NSDictionary, innerDic[k]);
        }
    }
    if(innerDic){
        valueStr = innerDic[kXMLReaderTextNodeKey];
    }
    return valueStr;
}

-(BOOL)findDigiValueFromKey:(NSString*)key withDic:(NSDictionary*)dic outValue:(NSInteger*)intValue;
{
    NSString* str = [self p_findStrValueFromDic:dic keyStr:key];
    if(str){
        if(intValue){ *intValue = str.integerValue; }
        return YES;
    } else {
        return NO;
    }
}
-(BOOL)findStrValueFromKey:(NSString*)key withDic:(NSDictionary*)dic outValue:(NSString**)strValue
{
    NSString* str = [self p_findStrValueFromDic:dic keyStr:key];
    if(str){
        if(strValue){ *strValue = str; }
        return YES;
    } else {
        return NO;
    }
}



@end

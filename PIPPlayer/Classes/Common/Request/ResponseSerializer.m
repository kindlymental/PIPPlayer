//
//  ResponseSerializer.m
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "ResponseSerializer.h"
#import <XMLDictionary/XMLDictionary.h>

@implementation ResponseSerializer

+ (instancetype)serializer {
    return [[self alloc]init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/xml", nil];
    }
    return self;
}

/**
 重写数据解析方法 (json/xml/js)

 @param response 相应体
 @param data 数据
 @param error 是否错误
 @return 解析到的数据
 */
- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    
    id responseObject = nil;
    NSError *serializationError = nil;
    
    BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
    if (data.length > 0 && !isSpace) {
        if ([response.MIMEType isEqualToString:@"application/json"] ||
            [response.MIMEType isEqualToString:@"text/json"]) {
            
            responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
            if (serializationError) {
                NSMutableString *JSONString = [NSMutableString stringWithUTF8String:data.bytes];
                if ([JSONString hasPrefix:@"seasonListCallback("]) {
                    [JSONString deleteCharactersInRange:NSMakeRange(0, @"seasonListCallback(".length)];
                    [JSONString deleteCharactersInRange:NSMakeRange(JSONString.length-2, @");".length)];
                    data = [NSData dataWithBytes:JSONString.UTF8String length:[JSONString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
                    serializationError = NULL;
                    responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
                }
            }
        }
        else if ([response.MIMEType isEqualToString:@"text/xml"]) {
            responseObject = [NSDictionary dictionaryWithXMLData:data];
        }
        else if ([response.MIMEType isEqualToString:@"text/javascript"]) {
            NSMutableString *JSONString = [NSMutableString stringWithUTF8String:data.bytes];
            if ([JSONString hasPrefix:@"seasonListCallback("]) {
                [JSONString deleteCharactersInRange:NSMakeRange(0, @"seasonListCallback(".length)];
                [JSONString deleteCharactersInRange:NSMakeRange(JSONString.length-2, @");".length)];
                data = [NSData dataWithBytes:JSONString.UTF8String length:[JSONString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
                serializationError = NULL;
                responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
            }
        }
    } else {
        return nil;
    }
    
    if (error && serializationError) {
        NSMutableDictionary *mutableUserInfo = [serializationError.userInfo mutableCopy];
        mutableUserInfo[NSUnderlyingErrorKey] = *error;
        *error = [[NSError alloc] initWithDomain:serializationError.domain code:serializationError.code userInfo:mutableUserInfo];
    }
    
    return responseObject;
}

@end

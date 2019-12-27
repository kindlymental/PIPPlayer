//
//  BaseRequest.m
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (NSInteger)responseCode {
    
    if (self.responseObject) {
        return [[self.responseObject valueForKey:@"code"] integerValue];
    } else {
        return -1;
    }
}

- (id)responseData {
    if (self.responseObject) {
        id data = [self.responseObject valueForKey:@"data"];
        if (data) {
            return data;
        } else {
            return NULL;
        }
    } else {
        return NULL;
    }
}

- (NSString *)errorMsg {
    if (self.error) {
        return self.error.localizedDescription;
    }
    else if ([self.responseData objectForKey:@"message"]) {
        return [self.responseData objectForKey:@"message"];
    }
    else {
        return @"网络请求出错";
    }
}

- (void)requestWithURLString:(NSString *)urlString method:(HTTPMethod)method parameters:(id)param completionBlock:(void (^)(BaseRequest *request))completionBlock {
    
    super.urlString = urlString;
    super.method = method;
    super.parameters = param;
    
    [super startWithCompletionBlock:completionBlock];
}

@end

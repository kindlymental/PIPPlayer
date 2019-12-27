//
//  BaseRequest.h
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "Request.h"

@interface BaseRequest : Request

@property (assign, nonatomic, readonly) NSInteger responseCode;

@property (strong, nonatomic, readonly) id responseData;

@property (strong, nonatomic, readonly) NSString *errorMsg;

- (void)requestWithURLString:(NSString *)urlString method:(HTTPMethod)method parameters:(id)param completionBlock:(void (^)(BaseRequest *request))completionBlock;

@end


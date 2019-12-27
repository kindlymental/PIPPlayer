//
//  VideoURLViewModel.h
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VideoURLViewModel : NSObject


- (instancetype)initWithAid:(NSInteger)aid cid:(NSInteger)cid page:(NSInteger)page completionBlock:(void (^)(NSURL *videoURL))completionBlock;


+ (void)requestVideoURLWithAid:(NSInteger)aid cid:(NSInteger)cid page:(NSInteger)page completionBlock:(void (^)(NSURL *videoURL))completionBlock;


@end

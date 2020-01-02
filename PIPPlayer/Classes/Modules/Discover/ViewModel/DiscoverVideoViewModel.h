//
//  DiscoverVideoViewModel.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/2.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiscoverVideoViewModel : NSObject

//RAC
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic,strong) NSMutableArray<Video *> *videoArray;


@end

NS_ASSUME_NONNULL_END

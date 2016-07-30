//
//  BullerManager.h
//  CommentDemo
//
//  Created by xiaoerlong on 16/7/29.
//  Copyright © 2016年 xiaoerlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BullerView;

@interface BullerManager : NSObject

@property (nonatomic, copy) void (^ generateViewBlock)(BullerView *view);

- (void)start;

- (void)stop;

@end

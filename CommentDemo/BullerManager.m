//
//  BullerManager.m
//  CommentDemo
//
//  Created by xiaoerlong on 16/7/29.
//  Copyright © 2016年 xiaoerlong. All rights reserved.
//

#import "BullerManager.h"
#import "BullerView.h"

@interface BullerManager ()
//弹幕的数据来源
@property (nonatomic, strong) NSMutableArray *datasource;
//弹幕使用过程中的数组变量
@property (nonatomic, strong) NSMutableArray *bullerComments;
//存储弹幕view的数组变量
@property (nonatomic, strong) NSMutableArray *bullerViews;

@property (nonatomic, assign) BOOL bStopAnimation;

@end

@implementation BullerManager

- (instancetype)init {
    if (self = [super init]) {
        self.bStopAnimation = YES;
    }
    return self;
}

- (void)start {
    if (!self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = NO;
    
    [self.bullerComments removeAllObjects];
    [self.bullerComments addObjectsFromArray:self.datasource];
    [self initBullerComment];
}

- (void)stop {
    if (self.bStopAnimation) {
        return;
    }
    
    self.bStopAnimation = YES;
    [self.bullerViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BullerView *view = (BullerView *)obj;
        [view stopAnimation];
        view = nil;
    }];
    [self.bullerViews removeAllObjects];
}

//初始化弹幕,随机分配弹幕轨迹
- (void)initBullerComment {
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0), @(1), @(2)]];
    for (int i = 0; i < 3; i++) {
        //通过随机数获取弹幕轨迹
        NSInteger index = arc4random() % trajectorys.count;
        int trajectory = [[trajectorys objectAtIndex:index] intValue];
        [trajectorys removeObjectAtIndex:index];
        
        //从弹幕数组中逐一取出弹幕数据
        NSString *comment = [self.bullerComments firstObject];
        [self.bullerComments removeObjectAtIndex:0];
        
        //创建弹幕view
        [self createBullerView:comment trajectory:trajectory];
    }
}

- (void)createBullerView:(NSString *)comment trajectory:(int)trajectory {
    
    if (self.bStopAnimation) {
        return;
    }
    
    BullerView *bullerView = [[BullerView alloc] initWithComment:comment];
    bullerView.trajectory = trajectory;
    [self.bullerViews addObject:bullerView];
    
    __weak typeof(bullerView) weakView = bullerView;
    __weak typeof(self) weakSelf = self;
    bullerView.moveStatusBlock = ^(MoveStatus status) {
        if (self.bStopAnimation) {
            return ;
        }
        switch (status) {
            case Start:
                [weakSelf.bullerViews addObject:weakView];
                break;
            case Enter: {
                
                NSString *acomment = [weakSelf nextComment];
                
                if (acomment) {
                    [weakSelf createBullerView:acomment trajectory:trajectory];
                }
            }
                break;
                
            case End:
                if ([weakSelf.bullerViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [weakSelf.bullerViews removeObject:weakView];
                }
                
                if (self.bullerComments.count == 0) {
                    //说明屏幕上已经没弹幕了
                    self.bStopAnimation = YES;
                    [weakSelf start];
                }
                break;
                
            default:
                break;
        }
    };
    
    if (self.generateViewBlock) {
        self.generateViewBlock(bullerView);
    }
}

- (NSString *)nextComment {
    
    if (self.bullerComments.count == 0) {
        return nil;
    }
    
    NSString *comment = [self.bullerComments firstObject];
    if (comment) {
        [self.bullerComments removeObjectAtIndex:0];
        
    }
    return comment;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray arrayWithArray:@[@"弹幕1~~~~~~",
                                                       @"弹幕2~~~~~~~~~~~",
                                                       @"弹幕3~~",
                                                       @"弹幕4~~~~~~",
                                                       @"弹幕5~~~~~~~~~~~",
                                                       @"弹幕6~~",
                                                       @"弹幕7~~~~~~",
                                                       @"弹幕8~~~~~~~~~~~",
                                                       @"弹幕9~~"]];
    }
    return _datasource;
}

- (NSMutableArray *)bullerComments {
    if (!_bullerComments) {
        _bullerComments = [NSMutableArray array];
    }
    return _bullerComments;
}

- (NSMutableArray *)bullerViews {
    if (!_bullerViews) {
        _bullerViews = [NSMutableArray array];
    }
    return _bullerViews;
}

@end

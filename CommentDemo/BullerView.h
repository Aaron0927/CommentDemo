//
//  BullerView.h
//  CommentDemo
//
//  Created by xiaoerlong on 16/7/29.
//  Copyright © 2016年 xiaoerlong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MoveStatus) {
    Start,
    Enter,
    End
};
@interface BullerView : UIView

@property (nonatomic, assign) int trajectory; //弹道
@property (nonatomic, copy) void(^moveStatusBlock)(MoveStatus); //弹幕状态

- (instancetype)initWithComment:(NSString *)comment;

- (void)startAnimation;

- (void)stopAnimation;

@end

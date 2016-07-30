//
//  BullerView.m
//  CommentDemo
//
//  Created by xiaoerlong on 16/7/29.
//  Copyright © 2016年 xiaoerlong. All rights reserved.
//

#import "BullerView.h"

#define padding 10

@interface BullerView ()

@property (nonatomic, strong) UILabel *lbComment;

@end

@implementation BullerView

- (instancetype)initWithComment:(NSString *)comment {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        CGFloat width = [comment sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
        self.bounds = CGRectMake(0, 0, width + 2 * padding, 30);
        
        
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(padding, 0, width, 30);
    }
    return self;
}

- (void)startAnimation {
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWith + self.bounds.size.width;
    
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
        
    }
    
    //进入时间(从开始进入到完全进入)
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / speed;
    
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;//x坐标移动的距离
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (self.moveStatusBlock) {
            _moveStatusBlock(End);
        }
    }];
    
}

- (void)enterScreen {
    if (self.moveStatusBlock) {
        
        self.moveStatusBlock(Enter);
    }
}

- (void)stopAnimation {
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
    
    
}

- (UILabel *)lbComment {
    if (!_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.textColor = [UIColor greenColor];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    return _lbComment;
}

@end

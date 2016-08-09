//
//  XZFPSLabel.m
//  XZFPSLabelDemo
//
//  Created by 徐章 on 16/8/9.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZFPSLabel.h"

@interface XZFPSLabel(){

    NSTimeInterval _lastStampTime;
    NSInteger _executeCount;
}

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation XZFPSLabel

+ (XZFPSLabel *)shareInstance{

    static XZFPSLabel *fpsLab = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fpsLab = [[XZFPSLabel alloc] init];
    });
    return fpsLab;
}

- (id)init{

    self = [super init];
    if (self) {
        _lastStampTime = 0;
        _executeCount = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont boldSystemFontOfSize:12.0f];
        self.textColor = [UIColor greenColor];
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-50.0f)/2.0f, 20, 50, 20);
        self.text = @"0 FPS";
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
    }
    return self;
}

#pragma mark - Setter && Getter
- (CADisplayLink *)displayLink{

    if (!_displayLink) {
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkMethod:)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

#pragma mark - Private_Methods
- (void)displayLinkMethod:(CADisplayLink *)displayLink{
    
    if (_lastStampTime == 0) {
        _lastStampTime = displayLink.timestamp;
        return;
    }
    
    _executeCount++;
    NSTimeInterval diff = displayLink.timestamp - _lastStampTime;
    if (diff < 1)
        return;
    
    self.text = [NSString stringWithFormat:@"%ld FPS",(long)(_executeCount/diff)];
    _executeCount = 0;
    _lastStampTime = displayLink.timestamp;
}

#pragma mark - notification
- (void)applicationDidBecomeActiveNotification {
    [_displayLink setPaused:NO];
}

- (void)applicationWillResignActiveNotification {
    [_displayLink setPaused:YES];
}

#pragma mark - Public_Methods
- (void)start{

    self.displayLink.paused = NO;
}

- (void)stop{
    self.displayLink.paused = YES;
}

@end

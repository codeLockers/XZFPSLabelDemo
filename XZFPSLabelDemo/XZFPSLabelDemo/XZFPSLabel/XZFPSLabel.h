//
//  XZFPSLabel.h
//  XZFPSLabelDemo
//
//  Created by 徐章 on 16/8/9.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZFPSLabel : UILabel

+ (XZFPSLabel *)shareInstance;

- (void)start;
- (void)stop;
@end

//
//  MyLabel.m
//  DemoForForwardingTarget
//
//  Created by wangjw on 16/9/26.
//  Copyright © 2016年 kaolafm. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setText:(NSString *)text
{
    [super setText:text];
    NSLog(@"MyLabel perform setText method");
}

@end

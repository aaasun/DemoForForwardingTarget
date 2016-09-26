//
//  ViewController.m
//  DemoForForwardingTarget
//
//  Created by wangjw on 16/9/26.
//  Copyright © 2016年 kaolafm. All rights reserved.
//

#import "ViewController.h"
#import "MyLabel.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic ,strong) UILabel *labTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labTitle.frame = CGRectMake(0, 100, 100, 21);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.labTitle];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 消息转发

//第一步：通过resolveInstanceMethod来进行方法判断你，然后进行方法方法添加
//如果不实现第一步的相关方法，就会进入到第二部的相关方法中
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(setText:)) {
//        class_addMethod(self, sel, (IMP)setText, "v@:");
//    }
//    return YES;
//}
//
//void setText (id self,SEL _cmd){
//    NSLog(@"%@ %s",self,sel_getName(_cmd));
//}
//===========================================================================

//第二步：通过forwardingTargetForSelector来进行将消息转发给另一个接受者
//如果不实现，就会进入到第三步中
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    return [MyLabel new];
//}

//第三步：通过methodSignatureForSelector生成方法签名，然后给forwardInvocation中的参数anInvocation调用。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    //实现一：
//    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//    if (!signature) {
//        signature = [self.labTitle methodSignatureForSelector:aSelector];
//    }
//    
//    return signature;
    
    //实现二：
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel isEqualToString:@"setText:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    if ([self.labTitle respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self.labTitle];
    }
}

//===========================================================================

#pragma mark getters and setters

- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.font = [UIFont systemFontOfSize:14];
        _labTitle.textColor = [UIColor blackColor];
        _labTitle.text = @"222";
    }
    
    return _labTitle;
}

@end

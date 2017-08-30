//
//  UIControl+delayBtn.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/8/23.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "UIControl+delayBtn.h"
#import <objc/runtime.h>

static char *buttonCallBackBlockKey;

@interface UIControl ()

//是否忽略
@property (nonatomic, assign)BOOL cj_ignoreEvent;

@end

@implementation UIControl (delayBtn)


+(void)load {
    
    Method sys_method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method add_method = class_getInstanceMethod(self, @selector(cj_sendAction:to:forEvent:));
    
    method_exchangeImplementations(sys_method, add_method);
}

- (void)cj_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {
    if (self.cj_ignoreEvent) return;
    if (self.cj_delayTime > 0) {
        self.cj_ignoreEvent = YES;
        [self performSelector:@selector(setCj_ignoreEvent:) withObject:@(NO) afterDelay:self.cj_delayTime];
    }
    [self cj_sendAction:action to:target forEvent:event];
    
}


/*
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
 id object                     :表示关联者，是一个对象，变量名理所当然也是object
 const void *key               :获取被关联者的索引key
 id value                      :被关联者
 objc_AssociationPolicy policy : 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
 */



#pragma mark -- 是否忽略
- (void)setCj_ignoreEvent:(BOOL)cj_ignoreEvent{
    objc_setAssociatedObject(self, @selector(cj_ignoreEvent), @(cj_ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)cj_ignoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

# pragma mark -- 延迟时间
- (void)setCj_delayTime:(NSTimeInterval)cj_delayTime{
    objc_setAssociatedObject(self, @selector(cj_delayTime), @(cj_delayTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)cj_delayTime{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)cj_clickControl:(cj_click_block)block delay:(NSTimeInterval)delay{
    [self addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.cj_delayTime = delay;
    if (block) {
        objc_setAssociatedObject(self, &buttonCallBackBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)clickBtn:(UIButton *)btn {
    
    cj_click_block block = objc_getAssociatedObject(self, &buttonCallBackBlockKey);
    if (block) {
        block(btn);
    }
}
@end

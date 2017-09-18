//
//  UIButton+cjBtn.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/8/29.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "UIButton+cjBtn.h"
#import <objc/runtime.h>

static const char *buttonCallBackBlockKey;
static const char *topNameKey;
static const char *rightNameKey;
static const char *bottomNameKey;
static const char *leftNameKey;
static const char *titleRectKey;
static const char *imageRectKey;

#pragma mark ----------UIControl-------------

@interface UIControl ()
//是否忽略
@property (nonatomic, assign)BOOL cj_ignoreEvent;

@end

@implementation UIControl (cjBtn)

+ (void)load {
    //延迟
    Method sys_method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method add_method = class_getInstanceMethod(self, @selector(cj_sendAction:to:forEvent:));
    method_exchangeImplementations(sys_method, add_method);
}

#pragma mark -- 延迟
- (void)cj_sendAction:(SEL)action to:(nullable id)target
             forEvent:(nullable UIEvent *)event {
    

    if (self.cj_ignoreEvent) return;
    
        CGFloat delay = [self.cj_delayTime doubleValue];
//        NSLog(@"延迟时间：%@,%@",@([self.cj_delayTime doubleValue]),@(delay));
        if (delay > 0) {
            self.cj_ignoreEvent = YES;
            [self performSelector:@selector(setCj_ignoreEvent:) withObject:@(NO) afterDelay:delay];
        }

    [self cj_sendAction:action to:target forEvent:event];
}

//延迟时间
/*
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
 id object                     :表示关联者，是一个对象，变量名理所当然也是object
 const void *key               :获取被关联者的索引key
 id value                      :被关联者
 objc_AssociationPolicy policy : 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
 */
//间隔时间
- (void)setCj_delayTime:(NSString *)cj_delayTime {
    objc_setAssociatedObject(self, @selector(cj_delayTime), cj_delayTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSNumber *)cj_delayTime {
    return objc_getAssociatedObject(self, _cmd);
}
//是否忽略
- (void)setCj_ignoreEvent:(BOOL)cj_ignoreEvent{
    objc_setAssociatedObject(self, @selector(cj_ignoreEvent), @(cj_ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}
/**
 * 这里的 _cmd 代指当前方法的选择子，也就是 @selector(cj_ignoreEvent)。
 * 这种方法省略了声明参数的代码，并且能很好地保证 key 的唯一性。
 */
- (BOOL)cj_ignoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end




#pragma mark -------------UIButton-------------------


@implementation UIButton (cjBtn)

#pragma mark -- Load
+ (void)load {
    //图文
    MethodSwizzle(self,@selector(titleRectForContentRect:),@selector(override_titleRectForContentRect:));
    MethodSwizzle(self,@selector(imageRectForContentRect:),@selector(override_imageRectForContentRect:));
}

#pragma mark -- Block封装
- (void)cj_clickControl:(cj_click_block)block {
    
    [self cj_clickControl:block delay:0];

}
- (void)cj_clickControl:(cj_click_block)block delay:(NSTimeInterval)delay {
    
    [self addTarget:self action:@selector(cj_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (delay>0) {
        self.cj_delayTime =  @(delay);
    }
    
    //存储block行为
    if (block) {
        objc_setAssociatedObject(self, &buttonCallBackBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
- (void)cj_clickBtn:(UIButton *)sender {
    //取出
    cj_click_block block = objc_getAssociatedObject(self, &buttonCallBackBlockKey);
    if (block) {
        block(sender);
    }
}

#pragma mark -- 图文
- (CGRect)titleRect {
    
    return [objc_getAssociatedObject(self, &titleRectKey) CGRectValue];
}

- (void)setTitleRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, &titleRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)imageRect {
    
    NSValue * rectValue = objc_getAssociatedObject(self, &imageRectKey);
    
    return [rectValue CGRectValue];
}

- (void)setImageRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, &imageRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

void MethodSwizzle(Class c,SEL origSEL,SEL overrideSEL)
{
    
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    
    //运行时函数class_addMethod 如果发现方法已经存在，会失败返回，也可以用来做检查用:
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        //如果添加成功(在父类中重写的方法)，再把目标类中的方法替换为旧有的实现:
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        //addMethod会让目标类的方法指向新的实现，使用replaceMethod再将新的方法指向原先的实现，这样就完成了交换操作。
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}

- (CGRect)override_titleRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [self override_titleRectForContentRect:contentRect];
    
}

- (CGRect)override_imageRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [self override_imageRectForContentRect:contentRect];
}

- (void)setTitleRect:(CGRect )titleRect ImageRect:(CGRect )imageRect {
    
    self.titleRect = titleRect;
    self.imageRect = imageRect;
}


#pragma mark -- 热响应
- (void)setEnlargeEdge:(CGFloat) size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}
@end

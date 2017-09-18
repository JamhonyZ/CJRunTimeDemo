//
//  UIFont+cjFont.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/9/15.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "UIFont+cjFont.h"
#import <objc/runtime.h>

#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define kSmall_IPhone (KScreenHeight < 600)

#define kVersion [[UIDevice currentDevice].systemVersion floatValue]
#define iOS9Before  ( kVersion < 9.0)

@implementation UIFont (cjFont)
//替换UI字体
+ (void)load {
    
    Method sys_method = class_getClassMethod(self, @selector(fontWithName:size:));
    Method add_method = class_getClassMethod(self, @selector(cj_fontWithName:size:));
    method_exchangeImplementations(sys_method, add_method);
}

+ (nullable UIFont *)cj_fontWithName:(NSString *)fontName
                                size:(CGFloat)fontSize {
    if ([fontName containsString:@"PingFangSC"] && iOS9Before) {
        //或者在这里替代 某种字体 ，一般UI出字体，不会太多，可在这里做区分字体转换
        return [UIFont cj_fontWithName:@"KohinoorDevanagari-Light" size:fontSize];
    }
    return [UIFont cj_fontWithName:fontName size:fontSize];
}


//小机型适配
+ (UIFont *)cj_fontWithName:(NSString *)fontName
                     uiSize:(CGFloat)fontSize
                    cutSize:(CGFloat)cutSize {
    
    fontSize = kSmall_IPhone ? fontSize-cutSize : fontSize;
    return [UIFont fontWithName:fontName size:fontSize];
}

@end

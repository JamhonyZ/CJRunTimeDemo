//
//  UIFont+cjFont.h
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/9/15.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIFont (cjFont)


//给小机型 给出小字体适配
+ (UIFont *)cj_fontWithName:(NSString *)fontName
                     uiSize:(CGFloat)fontSize
                    cutSize:(CGFloat)cutSize;


@end

//
//  NSString+calcuSize.h
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/11/2.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (calcuSize)

/**
 * 计算文字高度，可以处理计算带行间距的等属性
 */
- (CGSize)cj_boundingRectWithSize:(CGSize)size
                   paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
                             font:(UIFont*)font;

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)cj_boundingRectWithSize:(CGSize)size
                             font:(UIFont*)font
                      lineSpacing:(CGFloat)lineSpacing;

/**
 * 计算最大行数文字高度，可以处理计算带行间距的
 */
- (CGFloat)cj_boundingRectWithSize:(CGSize)size
                              font:(UIFont*)font
                       lineSpacing:(CGFloat)lineSpacing
                          maxLines:(NSInteger)maxLines;

/**
 *  计算是否超过一行
 */
- (BOOL)cj_isMoreThanOneLineWithSize:(CGSize)size
                                font:(UIFont *)font
                        lineSpaceing:(CGFloat)lineSpacing;

/**
 *  判断字符串是否为空
 */
+ (BOOL)cj_isNull:(id)obj;

@end

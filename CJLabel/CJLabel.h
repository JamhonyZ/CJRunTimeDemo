//
//  CJLabel.h
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/11/2.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/****** 支持行间距定制的文本 ******/
/**
 *  必须设置frame。自动计算自动计算高度。
 *  支持行间距、多颜色、居中、行数。
 **/


@interface CJLabel : UILabel


#pragma mark ----------- 方法1 -----------
/*** 赋值以下属性 ***/

//行间距
@property (nonatomic, assign)CGFloat cj_lineSpace;
//样式
@property (nonatomic, assign)NSTextAlignment cj_alignment;
//最大行数
@property (nonatomic, assign)NSInteger cj_maxLines;
//赋值上述属性之后，最后赋值文字
@property (nonatomic, copy)NSString *cj_text;

#pragma mark ----------- 方法2 -----------
/**
 *  当文本内容已知情况下，初始化创建。frame 高度可传 0.
 */
- (instancetype)initWithFrame:(CGRect)frame
                         font:(UIFont *)font
                    lineSpace:(CGFloat)lineSpace
                       cjText:(NSString *)cjText;


/**
 *  初始化frame之后，可动态配置。
 *  对齐方式
 */
- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
       textAlignment:(NSTextAlignment)textAlignment;

/**
 *  初始化frame之后，可动态配置。
 *  最大行数
 */
- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
            maxLines:(NSInteger)maxLines;

/**
 * 初始化frame之后，可动态配置。
 * 同时设置文本对齐方式和最大行数
 */
- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
       textAlignment:(NSTextAlignment)textAlignment
            maxLines:(NSInteger)maxLines;

/**
 * 初始化frame之后，可动态配置。
 * 设置变色 字段数组，颜色数组
 * 对齐方式
 */

- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
              colors:(NSArray *)colorArr
          colorTexts:(NSArray *)colorStringArr
       textAlignment:(NSTextAlignment)textAlignment;

/**
 *  获得带行间距的attributeString
 *  类方法创建，方便外部类获取
 */
+ (NSMutableAttributedString *)getAttLineSpace:(CGFloat)space
                                       content:(NSString *)content
                                          font:(UIFont *)font
                                       maxSize:(CGSize)maxSize;


@end

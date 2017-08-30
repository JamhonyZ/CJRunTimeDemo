//
//  UIButton+cjBtn.h
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/8/29.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  延迟功能
 *  block封装
 *  图文位置
 *  热响应区域
 */
typedef void(^cj_click_block)(UIButton *btn);

@interface UIControl (cjBtn)


/**
 * 延迟功能
 */
@property(nonatomic,assign)NSTimeInterval cj_delayTime;

@end


@interface UIButton (cjBtn)

/**
 * block封装
 */
- (void)cj_clickControl:(cj_click_block)block;

- (void)cj_clickControl:(cj_click_block)block delay:(NSTimeInterval)delay;


/**
 *  文字相对于按钮的的位置
 */
@property (nonatomic,assign) CGRect titleRect;

/**
 *  图片相对于按钮的的位置
 */
@property (nonatomic,assign) CGRect imageRect;



/**
 * 扩大按钮热响应区域 size 四边扩大的数值
 */
- (void)setEnlargeEdge:(CGFloat)size;

/**
 * 扩大按钮热响应区域 各个边扩大的数值
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;
@end

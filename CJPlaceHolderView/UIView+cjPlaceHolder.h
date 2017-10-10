//
//  UIView+cjPlaceHolder.h
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/10/9.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

/** UIView的占位图类型 */
typedef NS_ENUM(NSInteger, CJPlaceholderViewType) {
    /** 没网 */
    CJPlaceholderViewTypeNoNetwork,
    /** 没数据 */
    CJPlaceholderViewTypeNoBlankData,
    /** 加载失败 */
    CJPlaceholderViewTypeLoadFaild
};

@interface UIView (cjPlaceHolder)


#pragma mark -- 添加手势
/**
 *  给view添加点击手势
 *
 *  @param tapBlock 回调block
 */
- (void)cj_addTapGestureWithBlock:(GestureActionBlock)tapBlock;

/**
 *  给view添加长按手势
 *
 *  @param longPressBlock 回调block
 */
- (void)cj_addLongPressWithBlock:(GestureActionBlock)longPressBlock;


#pragma mark -- 展示占位图

/**
 展示UIView及其子类的占位图，大小可以设置（本质是在这个view上添加一个自定义view）
 @param imageName 占位图名字
 @param tipTitle  占位文字
 @param top 占位图上间距
 @param margin 文字和图片间距
 @param reloadBlock 重新加载按钮点击时的回调
 */
- (void)cj_showPlaceholderViewWithImageName:(NSString *)imageName
                                   tipTitle:(NSString *)tipTitle
                                   imageTop:(CGFloat)top
                             imageTipMargin:(CGFloat)margin
                                reloadBlock:(void (^)())reloadBlock;

- (void)cj_showPlaceholderViewWithImageName:(NSString *)imageName
                                   tipTitle:(NSString *)tipTitle
                                reloadBlock:(void (^)())reloadBlock;

- (void)cj_showPlaceholderViewWithType:(CJPlaceholderViewType)type
                           reloadBlock:(void (^)())reloadBlock;

/**
  主动移除占位图
 */
- (void)cj_removePlaceholderView;

@end

//
//  UIView+cjPlaceHolder.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/10/9.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "UIView+cjPlaceHolder.h"
#import "UIButton+cjBtn.h"
#import <objc/runtime.h>

@interface UIView ()

/** 占位图 */
@property (nonatomic, strong) UIView *cj_placeholderView;
/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign) BOOL cj_originalScrollEnabled;

@end


@implementation UIView (cjPlaceHolder)


static void *placeholderViewKey = &placeholderViewKey;
static void *originalScrollEnabledKey = &originalScrollEnabledKey;

static char *kTapActionBlockKey;
static char *kLongPressActionBlockKey;

#pragma mark -- block
- (void)cj_addTapGestureWithBlock:(GestureActionBlock)tapBlock
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlerTapAction:)]];
    self.userInteractionEnabled = YES;
    if (tapBlock) {
        objc_setAssociatedObject(self, &kTapActionBlockKey, tapBlock, OBJC_ASSOCIATION_COPY);
    }
}

- (void)handlerTapAction:(UIGestureRecognizer *)gestureRecoginzer
{
    GestureActionBlock tapActionBlock = objc_getAssociatedObject(self, &kTapActionBlockKey);
    if (tapActionBlock) {
        tapActionBlock(gestureRecoginzer);
    }
}

- (void)cj_addLongPressWithBlock:(GestureActionBlock)longPressBlock
{
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlerLongPressAction:)]];
    self.userInteractionEnabled = YES;
    if (longPressBlock) {
        objc_setAssociatedObject(self, &kLongPressActionBlockKey, longPressBlock, OBJC_ASSOCIATION_COPY);
    }
}

- (void)handlerLongPressAction:(UIGestureRecognizer *)gestureRecoginzer
{
    GestureActionBlock longPressActionBlock = objc_getAssociatedObject(self, &kLongPressActionBlockKey);
    if (longPressActionBlock) {
        longPressActionBlock(gestureRecoginzer);
    }
}

#pragma mark -- 占位
- (UIView *)cj_placeholderView {
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

- (void)setCj_placeholderView:(UIView *)cj_placeholderView {
    objc_setAssociatedObject(self, &placeholderViewKey, cj_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cj_originalScrollEnabled {
    return [objc_getAssociatedObject(self, &originalScrollEnabledKey) boolValue];
}

- (void)setCj_originalScrollEnabled:(BOOL)cj_originalScrollEnabled {
    objc_setAssociatedObject(self, &originalScrollEnabledKey, @(cj_originalScrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 方法
- (void)cj_showPlaceholderViewWithType:(CJPlaceholderViewType)type
                           reloadBlock:(void (^)())reloadBlock {
    
    NSString *imageName;
    NSString *tipTitle;
    switch (type) {
        case CJPlaceholderViewTypeNoNetwork: {
            tipTitle = @"请您检查网络";
            imageName = @"cj_wd_null_icon";
        }
            break;
        case CJPlaceholderViewTypeNoBlankData: {
            tipTitle = @"数据请求为空";
            imageName = @"cj_data_null";
        }
            break;
        case CJPlaceholderViewTypeLoadFaild: {
            tipTitle = @"加载失败,点击重载";
            imageName = @"cj_data_faild";
        }
            break;
            
        default:
            break;
    }
    [self cj_showPlaceholderViewWithImageName:imageName tipTitle:tipTitle reloadBlock:reloadBlock];
}

- (void)cj_showPlaceholderViewWithImageName:(NSString *)imageName
                                   tipTitle:(NSString *)tipTitle
                                reloadBlock:(void (^)())reloadBlock {
    
    //设置默认图片距离顶部间距为 当前view的五分之二，图文间距20
    [self cj_showPlaceholderViewWithImageName:imageName tipTitle:tipTitle imageTop:CGRectGetHeight(self.frame)*0.4 imageTipMargin:20 reloadBlock:reloadBlock];
}

- (void)cj_showPlaceholderViewWithImageName:(NSString *)imageName
                                   tipTitle:(NSString *)tipTitle
                                   imageTop:(CGFloat)top
                             imageTipMargin:(CGFloat)margin
                                reloadBlock:(void (^)())reloadBlock {
    // 如果是UIScrollView及其子类，占位图展示期间禁止scroll
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        // 先记录原本的scrollEnabled
        self.cj_originalScrollEnabled = scrollView.scrollEnabled;
        // 再将scrollEnabled设为NO
        scrollView.scrollEnabled = NO;
    }
    
    //------- 占位图 -------//
    if (self.cj_placeholderView) {
        [self.cj_placeholderView removeFromSuperview];
        self.cj_placeholderView = nil;
    }
    self.cj_placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    self.cj_placeholderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.cj_placeholderView];
    
    
    //------- 图标 -------//
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:imageName];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake((CGRectGetWidth(self.frame)-image.size.width)/2, top, image.size.width, image.size.height);
    [self.cj_placeholderView addSubview:imageView];
    
    
    //------- 文字 （可由项目不同定制富文本属性）------//
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.text = tipTitle;
    [tipLabel sizeToFit];
    tipLabel.frame = CGRectMake(CGRectGetMinX(imageView.frame)-20, CGRectGetMaxY(imageView.frame)+margin, image.size.width+40, tipLabel.font.pointSize);
    [self.cj_placeholderView addSubview:tipLabel];
    
    //回调
    [tipLabel cj_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (reloadBlock) {
            reloadBlock();
            [self cj_removePlaceholderView];
        }
    }];
    
    [imageView cj_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (reloadBlock) {
            reloadBlock();
            [self cj_removePlaceholderView];
        }
    }];
    
}

- (void)cj_removePlaceholderView {
    if (self.cj_placeholderView) {
        [self.cj_placeholderView removeFromSuperview];
        self.cj_placeholderView = nil;
    }
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.cj_originalScrollEnabled;
    }
}
@end

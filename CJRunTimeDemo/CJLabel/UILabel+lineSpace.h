//
//  UILabel+lineSpace.h
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/11/2.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (lineSpace)

/**行间距**/
@property (nonatomic, assign)CGFloat lineSpace;

/**样式**/
@property (nonatomic, assign)NSTextAlignment alignment;

/**最大行数**/
@property (nonatomic, assign)NSInteger maxLines;

/**调整**/
- (void)cj_adjustment;

@end

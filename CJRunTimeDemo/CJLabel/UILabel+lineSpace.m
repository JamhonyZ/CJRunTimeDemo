//
//  UILabel+lineSpace.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/11/2.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "UILabel+lineSpace.h"
#import <objc/runtime.h>
#import "NSString+calcuSize.h"

static const char *lineSpaceKey;
static const char *alignmentKey;
static const char *maxLinesKey;
//static const char *lineSpaceKey;

@implementation UILabel (lineSpace)

- (void)setLineSpace:(CGFloat)lineSpace {
    objc_setAssociatedObject(self, &lineSpaceKey, @(lineSpace), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)lineSpace {
    NSNumber *cj_lineSpace = objc_getAssociatedObject(self, &lineSpaceKey);
    return [cj_lineSpace floatValue];
}

- (void)setMaxLines:(NSInteger)maxLines {
    objc_setAssociatedObject(self, &maxLinesKey, @(maxLines), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)maxLines {
    NSNumber *cj_maxLines = objc_getAssociatedObject(self, &maxLinesKey);
    return [cj_maxLines integerValue];
}

- (void)setAlignment:(NSTextAlignment)alignment {
    objc_setAssociatedObject(self, &alignmentKey, @(alignment), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTextAlignment)alignment {
    NSNumber *cj_alignment = objc_getAssociatedObject(self, &alignmentKey);
    return [cj_alignment integerValue];
}

#pragma mark -- 赋值完上述内容属性之后，调用该方法。
- (void)cj_adjustment {
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    self.numberOfLines = 0;
    
    CGFloat lineSpace = self.lineSpace ? self.lineSpace : 1.0;
    NSTextAlignment alignment = self.alignment ? self.alignment : NSTextAlignmentLeft;
    NSInteger maxLines = self.maxLines ? self.maxLines : NSIntegerMax;
    
    //赋值
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if ([attributeString.string cj_isMoreThanOneLineWithSize:maxSize font:self.font lineSpaceing:lineSpace]) {
        style.lineSpacing = lineSpace;
    }
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,self.text.length)];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = alignment;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,self.text.length)];
    
    self.attributedText = attributeString;
    
    CGRect newFrame = self.frame;
    
    newFrame.size.height = [self.text cj_boundingRectWithSize:maxSize font:self.font lineSpacing:lineSpace maxLines:maxLines];
    
    if ([NSString cj_isNull:self.text]) {
        newFrame.size.height = 0;
    }
    self.frame = newFrame;

}
@end

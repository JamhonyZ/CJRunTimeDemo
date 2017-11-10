//
//  CJLabel.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/11/2.
//  Copyright © 2017年 cjzzh. All rights reserved.
//


#import "CJLabel.h"
#import "NSString+calcuSize.h"

static CGFloat const kDefultLineSpace = 1.0f;

@implementation CJLabel

#pragma mark ----------- 方法一 -----------
- (void)setCj_text:(NSString *)cj_text {
    
    _cj_text = cj_text;
    
    CGFloat lineSpace = _cj_lineSpace ? _cj_lineSpace : kDefultLineSpace;
    
    CGFloat alignment = _cj_alignment ? _cj_alignment : self.textAlignment;
    
    NSInteger masLines = _cj_maxLines ? _cj_maxLines : NSIntegerMax;

    [self configCJText:cj_text
             lineSpace:lineSpace
                  font:self.font
         textAlignment:alignment
              maxLines:masLines];
    
}

#pragma mark ----------- 方法2 -----------
- (instancetype)initWithFrame:(CGRect)frame
                         font:(UIFont *)font
                    lineSpace:(CGFloat)lineSpace
                       cjText:(NSString *)cjText {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = font;
        
        _cj_text = cjText;
        
        _cj_maxLines = NSIntegerMax;
        
        _cj_alignment = NSTextAlignmentLeft;
        
        self.numberOfLines = 0;
        
        NSMutableAttributedString *attributeString = [self getMutableStr:cjText];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        if ([attributeString.string cj_isMoreThanOneLineWithSize:CGSizeMake(frame.size.width, CGFLOAT_MAX) font:font lineSpaceing:lineSpace]) {
            style.lineSpacing = lineSpace;
            _cj_lineSpace = lineSpace;
        }
        [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,cjText.length)];
        self.attributedText = attributeString;
        
        
        [self changeNewFrame];
    }
    return self;
}


- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
       textAlignment:(NSTextAlignment)textAlignment {
    
    if (!cjText) return;
    
    _cj_text = cjText;

    _cj_alignment = textAlignment;
    
    _cj_maxLines = NSIntegerMax;
    
    self.font = font;
    
    self.numberOfLines = 0;
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    //赋值
    NSMutableAttributedString *attributeString = [self getMutableStr:cjText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if ([attributeString.string cj_isMoreThanOneLineWithSize:maxSize font:font lineSpaceing:lineSpace]) {
        style.lineSpacing = lineSpace;
        _cj_lineSpace = lineSpace;
    }
    style.alignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,cjText.length)];
    self.attributedText = attributeString;
    
    [self changeNewFrame];
}

- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
            maxLines:(NSInteger)maxLines {
    
    if (!cjText) return;
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    _cj_text = cjText;
    
    _cj_maxLines = maxLines;
    
    self.font = font;
    
    self.numberOfLines = 0;
    
    //赋值
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:cjText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if ([attributeString.string cj_isMoreThanOneLineWithSize:maxSize font:font lineSpaceing:lineSpace]) {
        style.lineSpacing = lineSpace;
        _cj_lineSpace = lineSpace;
    }
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,cjText.length)];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    self.attributedText = attributeString;
    
    [self changeNewFrame];
}

- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
              colors:(NSArray *)colorArr
          colorTexts:(NSArray *)colorStringArr
       textAlignment:(NSTextAlignment)textAlignment {
    
    if (!cjText) return;
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    _cj_text = cjText;
    
    _cj_maxLines = NSIntegerMax;
    
    _cj_alignment = textAlignment;
    
    self.font = font;
    
    self.numberOfLines = 0;
    
    //赋值
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:cjText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if ([attributeString.string cj_isMoreThanOneLineWithSize:maxSize font:font lineSpaceing:lineSpace]) {
        style.lineSpacing = lineSpace;
        _cj_lineSpace = lineSpace;
    }
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,cjText.length)];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,cjText.length)];
    
    //添加颜色
    [colorStringArr enumerateObjectsUsingBlock:^(NSString *colorString, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange stringRange = [cjText rangeOfString:colorString];
        NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
        if (colorArr.count>idx) {
            [stringDict setObject:colorArr[idx] forKey:NSForegroundColorAttributeName];
        } else {
            [stringDict setObject:colorArr[0] forKey:NSForegroundColorAttributeName];
        }
        [stringDict setObject:font forKey:NSFontAttributeName];
        [attributeString setAttributes:stringDict range:stringRange];
    }];
    
    self.attributedText = attributeString;
    
    [self changeNewFrame];

}

- (void)configCJText:(NSString *)cjText
           lineSpace:(CGFloat)lineSpace
                font:(UIFont *)font
       textAlignment:(NSTextAlignment)textAlignment
            maxLines:(NSInteger)maxLines {
    
    if (!cjText) return;
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    _cj_text = cjText;
    
    _cj_alignment = textAlignment;
    
    _cj_maxLines = maxLines;
    
    self.font = font;
    
    self.numberOfLines = 0;
    
    //赋值
    NSMutableAttributedString *attributeString = [self getMutableStr:cjText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if ([attributeString.string cj_isMoreThanOneLineWithSize:maxSize font:font lineSpaceing:lineSpace]) {
        style.lineSpacing = lineSpace;
        _cj_lineSpace = lineSpace;
    }
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,cjText.length)];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = textAlignment ? textAlignment : self.textAlignment;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,cjText.length)];
    
    self.attributedText = attributeString;
    
    
    [self changeNewFrame];
    
}

- (void)changeNewFrame {
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    CGRect newFrame = self.frame;
    
    newFrame.size.height = [_cj_text cj_boundingRectWithSize:maxSize font:self.font lineSpacing:_cj_lineSpace maxLines:_cj_maxLines];
    
    if ([NSString cj_isNull:_cj_text]) {
        newFrame.size.height = 0;
    }
    self.frame = newFrame;
}

- (NSMutableAttributedString *)getMutableStr:(NSString *)cjText {
    return [[NSMutableAttributedString alloc] initWithString:cjText];
}

+ (NSMutableAttributedString *)getAttLineSpace:(CGFloat)space
                                       content:(NSString *)content
                                          font:(UIFont *)font
                                       maxSize:(CGSize)maxSize {
    if (!content) return [[NSMutableAttributedString alloc] initWithString:@""];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if ([attributeString.string cj_isMoreThanOneLineWithSize:maxSize font:font lineSpaceing:space]) {
        style.lineSpacing = space;
    }
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,content.length)];
    return attributeString;
}



@end

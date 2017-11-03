//
//  NSString+calcuSize.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/11/2.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "NSString+calcuSize.h"

@implementation NSString (calcuSize)


/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)cj_boundingRectWithSize:(CGSize)size
                   paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
                             font:(UIFont*)font
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    return rect.size;
}

//判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)cj_boundingRectWithSize:(CGSize)size
                             font:(UIFont*)font
                      lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    return rect.size;
}



/**
 *  计算最大行数文字高度,可以处理计算带行间距的
 */
- (CGFloat)cj_boundingRectWithSize:(CGSize)size
                              font:(UIFont*)font
                       lineSpacing:(CGFloat)lineSpacing
                          maxLines:(NSInteger)maxLines{
    
    if (maxLines <= 0) {
        return 0;
    }
    
    if (maxLines == NSIntegerMax) {
       return  [self cj_boundingRectWithSize:size font:font lineSpacing:lineSpacing].height;
    } else {
        CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
        
        CGSize orginalSize = [self cj_boundingRectWithSize:size font:font lineSpacing:lineSpacing];
        
        if ( orginalSize.height >= maxHeight ) {
            return maxHeight;
        } else {
            return orginalSize.height;
        }
    }
    return 0;
}

/**
 *  计算是否超过一行
 */
- (BOOL)cj_isMoreThanOneLineWithSize:(CGSize)size
                                font:(UIFont *)font
                        lineSpaceing:(CGFloat)lineSpacing{
    
    if ( [self cj_boundingRectWithSize:size font:font lineSpacing:lineSpacing].height > font.lineHeight  ) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)cj_isNull:(id)obj
{
    BOOL result = NO;
    
    if ([obj isEqual:[NSNull null]] || obj == nil) {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        if (!string || [string isEqualToString:@""] || 0 == string.length) {
            result = YES;
        }
    }
    
    return result;
}
@end

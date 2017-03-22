//
//  CYXTouchLabel.m
//  CYXTouchLabel
//
//  Created by 超级腕电商 on 17/3/22.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#import "CYXTouchLabel.h"
#import <objc/runtime.h>
#import "UILabel+AttributeTextTapAction.h"

static char kAttributeTapActionKey;

@implementation CYXTouchLabel

-(void)setText:(NSString *)text
{
    [super setText:text];
    self.attributedText = [self subStr:text];
}
- (void)addAttributeTapActionTapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick
{
    objc_setAssociatedObject(self, &kAttributeTapActionKey, tapClick, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableAttributedString*)subStr:(NSString *)string
{
    if (!self.regulaStr) {return nil;}
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    //NSString *subStr;
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableArray *rangeArr=[[NSMutableArray alloc]init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [arr addObject:substringForMatch];
        
    }
    NSString *subStr=string;
    for (NSString *str in arr)
    {
        [rangeArr addObjectsFromArray:[self rangesOfString:str inString:subStr]];
    }
    
    //计算大小
    UIFont *font = self.font;
    NSMutableAttributedString *attributedText;
    
    attributedText=[[NSMutableAttributedString alloc]initWithString:subStr attributes:@{NSFontAttributeName :font}];
    
    for(NSValue *value in rangeArr)
    {
        NSRange range=[value rangeValue];
        [attributedText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        
        [attributedText addAttribute:NSForegroundColorAttributeName value:kColor(0x00cbf1) range:range];
    }
    
    void (^tapClick) (NSString *string , NSRange range , NSInteger index)  = objc_getAssociatedObject(self, &kAttributeTapActionKey);
    if (tapClick) {
        [self addAttributeTapActionWithStrings:arr tapClicked:tapClick];
    }
    return attributedText;
}
//获取查找字符串在母串中的NSRange
- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    
    return results;
}

@end

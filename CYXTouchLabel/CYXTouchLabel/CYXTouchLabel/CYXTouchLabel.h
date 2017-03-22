//
//  CYXTouchLabel.h
//  CYXTouchLabel
//
//  Created by 超级腕电商 on 17/3/22.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kColor(string) [UIColor colorWithRed:((float)((string & 0xFF0000) >> 16))/255.0 green:((float)((string & 0xFF00) >> 8))/255.0 blue:((float)(string & 0xFF))/255.0 alpha:1.0]
@interface CYXTouchLabel : UILabel
/**
 *  是否打开点击效果，默认是打开   @property (nonatomic, assign) BOOL enabledTapEffect; 已在category里面定义
 */


@property (nonatomic,copy)NSString * regulaStr;//需要筛选的正则表达式

/**
 添加点击事件

 @param tapClick 点击触发的block
 */
- (void)addAttributeTapActionTapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

@end

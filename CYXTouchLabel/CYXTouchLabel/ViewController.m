//
//  ViewController.m
//  CYXTouchLabel
//
//  Created by 超级腕电商 on 17/3/22.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#import "ViewController.h"
#import "CYXTouchLabel.h"

@interface ViewController ()
@property (nonatomic, strong) CYXTouchLabel *content;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.content];
    self.content.text = @"kskla;;swww.baidu.comsskks!!!kskla;;swww.sdsd.comsskks!!";
}

- (UILabel *)content
{
    if (!_content) {
        _content = [[CYXTouchLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
        _content.textColor = kColor(0x5f5f5f);
        _content.textAlignment = NSTextAlignmentLeft;
        _content.font = [UIFont systemFontOfSize:14];
        _content.numberOfLines = 0;
        _content.regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";//可以识别url的正则表达式
        __weak typeof(self) _weakSelf = self;
        [self.content addAttributeTapActionTapClicked:^(NSString *string, NSRange range, NSInteger index) {
            UIAlertController *action = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [action addAction:cancel];
            [_weakSelf presentViewController:action animated:YES completion:nil];
        }];
        
    }
    return _content;
}

@end

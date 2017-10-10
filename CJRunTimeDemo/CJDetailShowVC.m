//
//  CJDetailShowVC.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/10/10.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "CJDetailShowVC.h"
#import "UIView+cjPlaceHolder.h"

@interface CJDetailShowVC ()

@end

@implementation CJDetailShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_type) {
        case 0: {
            [self.view cj_showPlaceholderViewWithType:CJPlaceholderViewTypeNoNetwork reloadBlock:^{
                self.view.backgroundColor = [UIColor redColor];
            }];
        }
            break;
        case 1: {
            //传入nil 则不可点击
            [self.view cj_showPlaceholderViewWithType:CJPlaceholderViewTypeNoBlankData reloadBlock:nil];
        }
            break;
        case 2: {
            [self.view cj_showPlaceholderViewWithType:CJPlaceholderViewTypeLoadFaild reloadBlock:^{
                self.view.backgroundColor = [UIColor redColor];
            }];
        }
            break;
        case 3: {
            [self.view cj_showPlaceholderViewWithImageName:@"cj_wd_null_icon" tipTitle:@"玉树临风" imageTop:150 imageTipMargin:10 reloadBlock:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

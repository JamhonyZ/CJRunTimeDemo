//
//  ViewController.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/8/23.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+cjBtn.h"


@interface ViewController ()

@property (nonatomic, assign)NSInteger clickCount0;
@property (nonatomic, assign)NSInteger clickCount1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"间隔一秒" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn cj_clickControl:^(UIButton *btn) {
        [self changeAction:btn];
    }];
    btn.cj_delayTime = 1;
    btn.frame = CGRectMake(10, 80, 60, 20);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"block封装" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 cj_clickControl:^(UIButton *btn) {
        [self changeAction1:btn];
    }];
    btn1.frame = CGRectMake(CGRectGetMaxX(btn.frame)+50, 80, 60, 20);
    btn1.backgroundColor = [UIColor redColor];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    

    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"图文位置" forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"xj_alert_succeed"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn1.frame)+20, 100,130);
    btn2.backgroundColor = [UIColor redColor];
    btn2.imageRect = CGRectMake(20, 20, 60, 60);
    btn2.titleRect = CGRectMake(20, 80, 60, 50);
    [btn2 cj_clickControl:^(UIButton *btn) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            btn.imageRect = CGRectMake(0, 20, 60, 60);
            btn.titleRect = CGRectMake(0, 80, 60, 50);
        } else {
            btn.imageRect = CGRectMake(20, 20, 60, 60);
            btn.titleRect = CGRectMake(20, 80, 60, 50);
        }
    }];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    
    
    
    //热响应
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn2.frame), CGRectGetMaxY(btn2.frame), 100, 100)];
    bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bgView];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"点黄色" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 cj_clickControl:^(UIButton *btn) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            btn.backgroundColor = [UIColor blueColor];
        } else {
            btn.backgroundColor = [UIColor redColor];
        }
    }];
    [btn3 setEnlargeEdge:30];
    btn3.titleLabel.font = [UIFont systemFontOfSize:11];
    btn3.frame = CGRectMake(30, 30, 40, 40);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview:btn3];
    
 
   
}



- (void)changeAction:(UIButton *)btn {
    _clickCount0 ++;
    [btn setTitle:[NSString stringWithFormat:@"%@",@(_clickCount0)] forState:UIControlStateNormal];
}
- (void)changeAction1:(UIButton *)btn {
    _clickCount1 ++;
    [btn setTitle:[NSString stringWithFormat:@"%@",@(_clickCount1)] forState:UIControlStateNormal];
}



@end

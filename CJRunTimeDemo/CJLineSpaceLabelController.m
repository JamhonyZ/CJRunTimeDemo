//
//  CJLineSpaceLabelController.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/11/3.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "CJLineSpaceLabelController.h"
#import "UILabel+lineSpace.h"
#import "CJLabel.h"

@interface CJLineSpaceLabelController ()

@property (nonatomic, strong)UIScrollView *scrView;

@end

@implementation CJLineSpaceLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrView];
    
    [self configLabel0];
//    [self configLabel1];
}

//继承方式
- (void)configLabel0 {
    
    /**第一种 通过属性配置**/
    NSString *showText0 = @"我是懒得要死的菜鸟程序猿，你可千万别学我，不然就会拿着城市平均工资，过着月光的苦逼生活。程序猿千万不要久坐，不要久坐，不要久坐，不要久坐。不要熬夜，不要熬夜，不要熬夜";
    CJLabel *label0 = [[CJLabel alloc] initWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.view.bounds)-20, 0)];
    label0.cj_lineSpace = 5;
    label0.cj_alignment = NSTextAlignmentCenter;
    label0.cj_text = showText0;
    label0.backgroundColor = [UIColor lightGrayColor];
    [self.scrView addSubview:label0];
    
    /***第二种 通过init初始化***/
    NSString *showText1 = @"我是懒得要死的菜鸟程序猿，你可千万别学我，不然就会拿着城市平均工资，过着月光的苦逼生活。程序猿千万不要久坐，不要久坐，不要久坐，不要久坐。不要熬夜，不要熬夜，不要熬夜";
    CJLabel *label1 = [[CJLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label0.frame)+50, CGRectGetWidth(self.view.bounds)-20, 0) font:[UIFont systemFontOfSize:15] lineSpace:10 cjText:showText1];
    label1.textColor = [UIColor redColor];
    label1.layer.borderColor = [UIColor blueColor].CGColor;
    label1.layer.borderWidth = 2;
    label1.layer.masksToBounds = YES;
    [self.scrView addSubview:label1];
    
    
    /**第三种 通过config配置**/
    NSString *showText2 = @"我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。我只有两行。";
    CJLabel *label2 = [[CJLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label1.frame)+30, 200, 0)];
    label2.textColor = [UIColor blueColor];
    [label2 configCJText:showText2 lineSpace:10 font:[UIFont systemFontOfSize:11] maxLines:2];
    [self.scrView addSubview:label2];
    
    
    NSString *showText3 = @"我是居中。我是居中。我是居中。我是居中。我是居中。我是居中。我是居中。我是居中。";
    CJLabel *label3 = [[CJLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label2.frame)+50, 150, 0)];
    label3.textColor = [UIColor blackColor];
    [label3 configCJText:showText3 lineSpace:10 font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentCenter];
    [self.scrView addSubview:label3];
    
    
    NSString *showText4 = @"我只有两行且居右。我只有两行且居右。";
    CJLabel *label4 = [[CJLabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(label3.frame)+20, 150, 0)];
    label4.textColor = [UIColor greenColor];
    label4.backgroundColor = [UIColor lightGrayColor];
    [label4 configCJText:showText4 lineSpace:7 font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight maxLines:2];
    [self.scrView addSubview:label4];
    
    
    NSString *showText5 = @"我是彩色文字。我是绿色。我是蓝色。我是灰色。\n第二行开启";
    CJLabel *label5 = [[CJLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label4.frame)+20, CGRectGetWidth(self.view.bounds)-20, 0)];
    label5.textColor = [UIColor orangeColor];
    [label5 configCJText:showText5 lineSpace:7 font:[UIFont systemFontOfSize:13] colors:@[[UIColor greenColor],[UIColor blueColor],[UIColor grayColor]] colorTexts:@[@"我是绿色",@"我是蓝色",@"我是灰色"] textAlignment:NSTextAlignmentLeft];
    [self.scrView addSubview:label5];
    
    
    [self.scrView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(label5.frame)+10)];
}

//分类
- (void)configLabel1 {
    
    NSString *showText0 = @"通过分类我来实现换行和行间距。\n我是懒得要死的菜鸟程序猿，你可千万别学我，不然就会拿着城市平均工资，过着月光的苦逼生活。程序猿千万不要久坐，不要久坐，不要久坐，不要久坐。不要熬夜，不要熬夜，不要熬夜";
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(10, 88, CGRectGetWidth(self.view.bounds)-20, 0)];
    label0.text = showText0;
    label0.textColor = [UIColor orangeColor];
    label0.font = [UIFont systemFontOfSize:15];
    [self.scrView addSubview:label0];
    
    label0.lineSpace = 5;
    label0.alignment = NSTextAlignmentCenter;
    label0.maxLines = 5;
    [label0 cj_adjustment];
    
}




@end

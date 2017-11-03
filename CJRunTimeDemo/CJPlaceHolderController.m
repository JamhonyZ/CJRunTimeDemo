//
//  CJPlaceHolderController.m
//  CJRunTimeDemo
//
//  Created by 创建zzh on 2017/10/9.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "CJPlaceHolderController.h"
#import "UIView+cjPlaceHolder.h"
#import "CJDetailShowVC.h"

#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(weakSelf) strongSelf = weakSelf

@interface CJPlaceHolderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tbView;

@property (nonatomic, strong)NSArray *sourceData;

@property (nonatomic, assign)BOOL ifFirstLoad;

@end

@implementation CJPlaceHolderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"展位图功能";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tbView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tbView];
    
    kSelfWeak;
    [_tbView cj_showPlaceholderViewWithType:CJPlaceholderViewTypeLoadFaild reloadBlock:^{
        kSelfStrong;
        [strongSelf.tbView reloadData];
    }];
    
    _sourceData = @[@"检查网络",@"无数据",@"加载失败",@"自定义"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _sourceData[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CJDetailShowVC *vc = [CJDetailShowVC new];
    vc.type = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

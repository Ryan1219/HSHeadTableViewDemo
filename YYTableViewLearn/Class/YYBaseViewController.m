//
//  YYBaseViewController.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYBaseViewController.h"




@interface YYBaseViewController ()


@end

@implementation YYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

- (void)configBaseTableView {
    
    CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6 + 44;
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.showsVerticalScrollIndicator = false;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headHeight)];
    self.baseTableView.tableHeaderView = headView;
    self.baseTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:self.baseTableView];
    
}


@end

















































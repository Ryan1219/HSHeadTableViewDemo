//
//  YYDynamicViewController.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYDynamicViewController.h"

@interface YYDynamicViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation YYDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configBaseTableView];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
}

//MARK:- TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *dynamicCellIndentifier = @"dynamicCellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dynamicCellIndentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"dynamic %zd",indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


@end

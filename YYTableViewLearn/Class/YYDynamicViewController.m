//
//  YYDynamicViewController.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYDynamicViewController.h"

@interface YYDynamicViewController ()

@end

@implementation YYDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

//- (void)resetTableViewOffsetY:(CGFloat)offsetY {
//    
//    CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6;
//    if (self.tableView.contentOffset.y > headHeight && offsetY > self.tableView.contentOffset.y) {
//        return;
//    }
//    
//    [self.tableView setContentOffset:CGPointMake(0, offsetY)];
//}

//- (NSString *)description {
//    
//    return @"dynamic";
//}
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
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    
//     cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


@end

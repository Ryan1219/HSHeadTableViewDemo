//
//  YYBaseViewController.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYBaseViewController.h"




@interface YYBaseViewController ()



/* <#description#> */
//@property (nonatomic,assign) NSInteger index;
/* <#description#> */
//@property (nonatomic,assign) CGFloat headHeight;

@end

@implementation YYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6 + 44;
    
//    // UITableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headHeight)];
    self.tableView.tableHeaderView = headView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64+20)];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headHeight, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
}



//MARK:-UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (self.tableView.frame.origin.x / ScreenWidth != self.index) {
//        return;
//    }
    
    if (self.offset) {
        self.offset(scrollView.contentOffset.y, self);
    }
}

- (void)resetTableViewOffsetY:(CGFloat)offsetY {
    
    CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6;
    if (self.tableView.contentOffset.y > headHeight && offsetY > self.tableView.contentOffset.y) {
        return;
    }
    
    [self.tableView setContentOffset:CGPointMake(0, offsetY)];
}


@end

















































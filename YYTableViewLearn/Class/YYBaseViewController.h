//
//  YYBaseViewController.h
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YYBaseViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

/* <#description#> */
@property (nonatomic,strong) UITableView *tableView;
/* <#description#> */
@property (nonatomic,strong) void(^offset)(CGFloat offsetY, UIViewController *control);

- (void)resetTableViewOffsetY:(CGFloat)offsetY;

@end

//
//  YYMoreViewController.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYMoreViewController.h"

@interface YYMoreViewController ()

@end

@implementation YYMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}


//- (NSString *)description {
//    
//    return @"more";
//}

//MARK:- TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *moreCellIndentifier = @"moreCellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellIndentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"more %zd",indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 199.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor yellowColor];
    [cell.contentView addSubview:lineView];
    
//     cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


@end

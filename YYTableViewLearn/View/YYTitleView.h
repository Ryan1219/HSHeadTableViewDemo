//
//  YYTitleView.h
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYTitleView : UIView

/* <#description#> */
@property (nonatomic,strong) void(^clickTitleActionBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)resetCurrentTitleIndex:(NSInteger)index;



@end

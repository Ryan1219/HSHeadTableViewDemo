//
//  YYTitleView.h
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYTitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/* <#description#> */
@property (nonatomic,strong) void(^clickTitleActionBlock)(NSString *title,NSInteger index);

- (void)resetCurrentTitleIndex:(NSInteger)index;



@end

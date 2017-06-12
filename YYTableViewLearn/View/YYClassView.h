//
//  YYClassView.h
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYClassView : UIView

/* <#description#> */
@property (nonatomic,strong) void(^sliderScrollViewBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame childsController:(NSArray *)childsController;

- (void)resetCurrntControllerIndex:(NSInteger)index;

@end

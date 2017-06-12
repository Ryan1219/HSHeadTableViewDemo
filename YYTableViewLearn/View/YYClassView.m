//
//  YYClassView.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYClassView.h"

#define kWidth self.frame.size.width
#define kHeight self.frame.size.height

@interface YYClassView () <UIScrollViewDelegate>

/* <#description#> */
@property (nonatomic,strong) UIScrollView *contentScrollView;
/* <#description#> */
@property (nonatomic,strong) NSArray *childsControllerArray;


@end

@implementation YYClassView

- (instancetype)initWithFrame:(CGRect)frame childsController:(NSArray *)childsController {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.childsControllerArray = childsController;
        [self configLayoutWithChildsController:childsController];
    }
    return self;
}

//MARK:-界面创建
- (void)configLayoutWithChildsController:(NSArray *)childsController {
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsVerticalScrollIndicator = true;
    self.contentScrollView.showsHorizontalScrollIndicator = false;
    self.contentScrollView.pagingEnabled = true;
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    self.contentScrollView.contentSize = CGSizeMake(kWidth * childsController.count, 0);
    [self addSubview:self.contentScrollView];
    
}

//MARK:-Private Method
- (void)resetCurrntControllerIndex:(NSInteger)index {
    
    CGFloat viewCtrl_X = index * kWidth;
    UIViewController *viewCtrl = self.childsControllerArray[index];
    if (!viewCtrl.view.superview) {
        viewCtrl.view.frame = CGRectMake(viewCtrl_X, 0, kWidth, kHeight);
        [self.contentScrollView addSubview:viewCtrl.view];
    }
    [self.contentScrollView setContentOffset:CGPointMake(viewCtrl_X, 0) animated:false];
}

//MARK:-UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / kWidth;
    
    [self resetCurrntControllerIndex:index];
    
    if (self.sliderScrollViewBlock) {
        self.sliderScrollViewBlock(index);
    }
}


@end




































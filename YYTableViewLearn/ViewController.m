//
//  ViewController.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "ViewController.h"
#import "YYMoreViewController.h"
#import "YYDynamicViewController.h"
#import "YYArticleViewController.h"
#import "YYHeadView.h"

@interface ViewController () <UIScrollViewDelegate,UIGestureRecognizerDelegate>

/* <#description#> */
@property (nonatomic,strong) NSMutableArray *childsArray;
/* <#description#> */
@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) YYHeadView *headView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.childsArray = [NSMutableArray array];
    //
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsVerticalScrollIndicator = true;
    self.contentScrollView.showsHorizontalScrollIndicator = false;
    self.contentScrollView.pagingEnabled = true;
    self.contentScrollView.scrollEnabled = true;
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    self.contentScrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    [self.view addSubview:self.contentScrollView];
    

    //
    CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6 + 44;
    self.headView = [[YYHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headHeight)];
    [self.view addSubview:self.headView];
    __weak typeof(self) weakSelf = self;
    self.headView.clickTitleBtnActionBlock = ^(NSString *title, NSInteger index) {
        weakSelf.contentScrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        [weakSelf refreshMaxOffsetY];
    };
    
    //
    [self addChildController:YYDynamicViewController.class x:0];
    [self addChildController:YYArticleViewController.class x:ScreenWidth];
    [self addChildController:YYMoreViewController.class x:ScreenWidth*2];
    
    
}
//MARK:--------添加子控制器--------
- (void)addChildController:(Class)ctrl x:(CGFloat)x {
    
    YYBaseViewController *baseCtrl = [[ctrl alloc] init];
    [self.contentScrollView addSubview:baseCtrl.view];
    baseCtrl.view.frame = CGRectMake(x, 0, ScreenWidth, ScreenHeight);
    [self addChildViewController:baseCtrl];
    // 监听tableView的contentOffset变化
    [baseCtrl.baseTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
    
}
//MARK:--------Private--------
//刷新偏移量
- (void)refreshMaxOffsetY {
    
    CGFloat maxOffsetY = 0;
    for (YYBaseViewController *ctrl in self.childViewControllers) {
        if (ctrl.baseTableView.contentOffset.y > maxOffsetY) {
            maxOffsetY = ctrl.baseTableView.contentOffset.y;
        }
    }
    
    CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6;
    if (maxOffsetY > headHeight) {
        for (YYBaseViewController *ctrl in self.childViewControllers) {
            if (ctrl.baseTableView.contentOffset.y < headHeight) {
                ctrl.baseTableView.contentOffset = CGPointMake(0, headHeight);
            }
        }
    }
}

//MARK:-UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.contentScrollView) {
        NSInteger index = scrollView.contentOffset.x / ScreenWidth;
        [self.headView resetCurrentTitleIndex:index];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self refreshMaxOffsetY];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//
//    return true;
//}

//MARK:--------KVO--------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UITableView *baseTableView = object;
        CGFloat contentOffsetY = baseTableView.contentOffset.y;
        
        CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6;
        if (contentOffsetY < headHeight) {
            for (YYBaseViewController *ctrl in self.childViewControllers) {
                if (ctrl.baseTableView.contentOffset.y != baseTableView.contentOffset.y) {
                    ctrl.baseTableView.contentOffset = baseTableView.contentOffset;
                }
            }
            
            CGFloat headerY = -baseTableView.contentOffset.y;
            //
            [self.headView changeY:headerY];
        }
        else if (contentOffsetY >= headHeight) {
            [self.headView changeY:-headHeight];
        }
    }
}

- (void)dealloc {
    
    for (YYBaseViewController *ctrl in self.childViewControllers) {
        [ctrl.baseTableView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

@end





















































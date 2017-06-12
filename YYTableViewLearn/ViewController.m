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
#import "YYClassView.h"
#import "YYTitleView.h"
#import "YYLifeCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UIGestureRecognizerDelegate>

/* <#description#> */
//@property (nonatomic,strong) YYTitleView *titleView;
/* <#description#> */
@property (nonatomic,strong) UIView *titleView;
/* <#description#> */
@property (nonatomic,strong) UIView *lineView;
/* <#description#> */
@property (nonatomic,strong) YYClassView *classView;
/* <#description#> */
@property (nonatomic,strong) UICollectionView *collectionView;
/* <#description#> */
@property (nonatomic,strong) NSMutableArray *childsArray;
/* <#description#> */
@property (nonatomic,strong) NSArray *titleArray;
/* <#description#> */
@property (nonatomic,strong) NSMutableArray *titleBtnArray;
/* <#description#> */
@property (nonatomic,strong) UIScrollView *contentScrollView;

@end

@implementation ViewController

/* <#description#> */
- (NSMutableArray *)titleBtnArray {
    if (_titleBtnArray == nil) {
        _titleBtnArray = [NSMutableArray array];
    }
    return _titleBtnArray;
}


/*  <#description#>*/
- (NSArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [[NSArray alloc] initWithObjects:@"动态",@"文章",@"更多", nil];
    }
    return _titleArray;
}

/* <#description#> */
- (NSMutableArray *)childsArray {
    if (_childsArray == nil) {
        _childsArray = [NSMutableArray array];
    }
    return _childsArray;
}

//- (YYTitleView *)titleView {
//    if (!_titleView) {
//        
//        CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6;
//        _titleView  = [[YYTitleView alloc] initWithFrame:CGRectMake(0, headHeight, ScreenWidth, 44) titles:@[@"动态",@"文章",@"更多"]];
//        __weak typeof(self) weakSelf = self;
//        _titleView.clickTitleActionBlock = ^(NSInteger index) {
//            [weakSelf.classView resetCurrntControllerIndex:index];
//
//        };
//    }
//    return _titleView;
//}

- (YYClassView *)classView {
    if (!_classView) {
        
        _classView = [[YYClassView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) childsController:self.childsArray];
        __weak typeof(self) weakSelf = self;
        _classView.sliderScrollViewBlock = ^(NSInteger index) {
            [weakSelf selectTitleBtn:weakSelf.titleBtnArray[index]];
        };
    }
    return _classView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addChildController];
    
    [self.view addSubview:self.classView];
//    [self configContentScrollView];
    
    [self configCollectionView];
    [self configTitleView];
    
//    [self.view addSubview:self.titleView];
//    [self.titleView resetCurrentTitleIndex:0];
    [self selectTitleBtn:self.titleBtnArray[0]];
    [self.classView resetCurrntControllerIndex:0];
//    [self modifyChildViewController:0];
    
}

//MARK:-添加子控制器
- (void)addChildController {
    
    __weak typeof(self) weakSelf = self;
    CGFloat headHeight = (ScreenWidth - 30) / 2 + 20 + 6;
    
    void (^offset)(CGFloat offsetY,UIViewController *control) = ^(CGFloat offsetY, UIViewController *control) {
        CGRect titleFrame = weakSelf.titleView.frame;
        titleFrame.origin.y = headHeight - offsetY;
        if (titleFrame.origin.y <= 0) {
            titleFrame.origin.y = 0;
        }
        weakSelf.titleView.frame = titleFrame;
        
        CGRect collectViewFrame = weakSelf.collectionView.frame;
        collectViewFrame.size.height = titleFrame.origin.y;
        weakSelf.collectionView.frame = collectViewFrame;
        
        [weakSelf.childsArray enumerateObjectsUsingBlock:^(YYBaseViewController *control, NSUInteger idx, BOOL * _Nonnull stop) {
             [control resetTableViewOffsetY:offsetY];
        }];
        
    };
    
    YYDynamicViewController *dynamicCtrl = [[YYDynamicViewController alloc] init];
    dynamicCtrl.offset = offset;
    [self.childsArray addObject:dynamicCtrl];
    
    
    YYArticleViewController *articleCtrl = [[YYArticleViewController alloc] init];
    articleCtrl.offset = offset;
    [self.childsArray addObject:articleCtrl];
    
    YYMoreViewController *moreCtrl = [[YYMoreViewController alloc] init];
    moreCtrl.offset = offset;
    [self.childsArray addObject:moreCtrl];
}

//MARK:-configCollectionView
- (void)configCollectionView {
    
    //UICollectionView
    CGFloat cellW = (ScreenWidth - 30) / 2;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellW, cellW);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 16, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 10 ;
    
    CGFloat collectionH = cellW + 20 + 6;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, collectionH) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView registerClass:[YYLifeCollectionViewCell class] forCellWithReuseIdentifier:@"lifeColletionViewCellIndentifier"];
    [self.view addSubview:self.collectionView];
    
}

//MARK:-configTitleView
- (void)configTitleView {
    
    // 存放title的View
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), ScreenWidth, 44)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.titleView addSubview:lineView];
    
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        //
//        CGFloat btnTitleW = [self.titleArray[i] sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(ScreenWidth/3, 200)].width + 15;
        CGFloat btnY = 0;
        CGFloat btnH = 44;
        CGFloat btnW = ScreenWidth / 3;
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnW, btnY, btnW, btnH)];
        titleBtn.tag = 1990 + i;
        [titleBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [titleBtn addTarget:self action:@selector(clickLifeTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtnArray addObject:titleBtn];
        [self.titleView addSubview:titleBtn];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake((btnW-80)/2, btnH-1.5, 80, 1)];
        self.lineView.backgroundColor = [UIColor redColor];
        self.lineView.hidden = true;
        [self.titleView addSubview:self.lineView];
        
    }

}

//MARK:-configContentScrollView
- (void)configContentScrollView {
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsVerticalScrollIndicator = true;
    self.contentScrollView.showsHorizontalScrollIndicator = false;
    self.contentScrollView.pagingEnabled = true;
    self.contentScrollView.scrollEnabled = true;
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    self.contentScrollView.contentSize = CGSizeMake(ScreenWidth * self.titleArray.count, 0);
    [self.view addSubview:self.contentScrollView];
}

//MARK:-UIButton Action
- (void)clickLifeTitleBtn:(UIButton *)sender {
    
    [self selectTitleBtn:sender];
    
    NSInteger index = sender.tag - 1990;
    
//    [self modifyChildViewController:index];
    
    [self.classView resetCurrntControllerIndex:index];
}

//改变选中头部标题的颜色
- (void)selectTitleBtn:(UIButton *)sender {
    
    for (NSInteger i = 0; i < self.titleBtnArray.count; i++) {
        UIButton *selectBtn = (UIButton *)[sender.superview viewWithTag:1990+i];
        if (selectBtn.tag == sender.tag) {
            [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        } else {
            selectBtn.selected = false;
            [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
//    CGFloat titleWidth = [sender.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(ScreenWidth/3, 200)].width + 15;
    NSInteger index = sender.tag - 1990;
    CGFloat line_X = index * ScreenWidth/3 + (ScreenWidth/3 - 80) / 2;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.frame = CGRectMake(line_X , 42.5, 80, 1);
        self.lineView.hidden = false;
    } completion:^(BOOL finished) {
        
    }];
}



//MARK:-UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.contentScrollView) {
        NSInteger index = scrollView.contentOffset.x / ScreenWidth;
        [self selectTitleBtn:self.titleBtnArray[index]];
        [self modifyChildViewController:index];
    }
}

//改变选中控制器的位置
- (void)modifyChildViewController:(NSInteger)index {
    
    CGFloat viewCtrl_X = index * ScreenWidth;
    UIViewController *viewCtrl = self.childsArray[index];
    if (!viewCtrl.view.superview) {
        viewCtrl.view.frame = CGRectMake(viewCtrl_X, 0, ScreenWidth, ScreenHeight);
        [self.contentScrollView addSubview:viewCtrl.view];
    }
    [self.contentScrollView setContentOffset:CGPointMake(viewCtrl_X, 0) animated:false];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return true;
}


//MARK:-UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YYLifeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lifeColletionViewCellIndentifier" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"life %zd",indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"------indexPath---%zd",indexPath.row);
}

@end





















































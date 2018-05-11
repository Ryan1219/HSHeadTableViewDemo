//
//  YYHead/Users/ryan/Desktop/未命名文件夹 2/YYHeadTableView/YYTableViewLearnView.m
//  YYTableViewLearn
//
//  Created by Ryan on 2018/5/11.
//  Copyright © 2018年 Ryan. All rights reserved.
//

#import "YYHeadView.h"
#import "YYLifeCollectionViewCell.h"
#import "YYTitleView.h"

@interface YYHeadView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* <#description#> */
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) YYTitleView *titleView;

@end

@implementation YYHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
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
        [self addSubview:self.collectionView];
        
        self.titleView = [[YYTitleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), ScreenWidth, 44) titles:@[@"动态",@"文章",@"更多"]];
        __weak typeof(self) weakSelf = self;
        self.titleView.clickTitleActionBlock = ^(NSString *title, NSInteger index) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.clickTitleBtnActionBlock) {
                strongSelf.clickTitleBtnActionBlock(title,index);
            }
        };
        [self addSubview:self.titleView];
        
    }
    return self;
}

//MARK:--------Private--------
- (void)changeY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)resetCurrentTitleIndex:(NSInteger)index {
    
    [self.titleView resetCurrentTitleIndex:index];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end





















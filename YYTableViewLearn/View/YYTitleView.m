//
//  YYTitleView.m
//  YYTableViewLearn
//
//  Created by Ryan on 2017/6/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYTitleView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YYTitleView ()

/* <#description#> */
@property (nonatomic,strong) NSMutableArray *titleBtnArray;
/* <#description#> */
@property (nonatomic,strong) UIView *lineView;


@end

@implementation YYTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 1.0;
        self.titleBtnArray = [NSMutableArray array];
        [self configLayoutWithTitles:titles];
    }
    return self;
}

//MARK:-界面创建
- (void)configLayoutWithTitles:(NSArray *)titles {
    
    CGFloat btnW = ScreenWidth / titles.count;
    CGFloat btnH = 44;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnW, 0, btnW, btnH)];
        titleBtn.tag = 1990 + i;
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [titleBtn addTarget:self action:@selector(clickLifeTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtnArray addObject:titleBtn];
        [self addSubview:titleBtn];
        if (i == 0) {
             [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake((btnW-80)/2, btnH-1.5, 80, 1)];
    self.lineView.backgroundColor = [UIColor redColor];
//    self.lineView.hidden = true;
    [self addSubview:self.lineView];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, btnH-0.5, ScreenWidth, 0.5)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
    
}

//MARK:-Private Method
- (void)resetCurrentTitleIndex:(NSInteger)index {
    
    [self selectTitleBtn:self.titleBtnArray[index]];
}

//MARK:-UIButton Action
- (void)clickLifeTitleBtn:(UIButton *)sender {
    
    NSInteger index = sender.tag - 1990;
    if (self.clickTitleActionBlock) {
        self.clickTitleActionBlock(sender.titleLabel.text,index);
    }
    [self selectTitleBtn:sender];
    
}

//点击不同标题时标题颜色以及线条动画处理
- (void)selectTitleBtn:(UIButton *)sender {
    
    for (NSInteger i = 0; i < self.titleBtnArray.count; i++) {
        UIButton *selectBtn = (UIButton *)[sender.superview viewWithTag:1990+i];
        if (selectBtn.tag == sender.tag) {
            [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            selectBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } else {
            selectBtn.selected = false;
            [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            selectBtn.transform = CGAffineTransformIdentity;
            
        }
    }
    
    // 线条动画
//     CGFloat titleWidth = [sender.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(ScreenWidth/3, 200)].width + 15;
    NSInteger i = sender.tag - 1990;
    CGFloat line_X = i * ScreenWidth/3 + (ScreenWidth/3 - 80) / 2;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.frame = CGRectMake(line_X , self.frame.size.height-1.5, 80, 1);
//        self.lineView.hidden = false;
    } completion:^(BOOL finished) {
        
    }];
}


@end
































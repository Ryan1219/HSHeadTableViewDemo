//
//  YYHeadView.h
//  YYTableViewLearn
//
//  Created by Ryan on 2018/5/11.
//  Copyright © 2018年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YYHeadView : UIView

@property (nonatomic,copy) void (^clickTitleBtnActionBlock)(NSString *title,NSInteger index);

- (void)changeY:(CGFloat)y;

- (void)resetCurrentTitleIndex:(NSInteger)index;

@end

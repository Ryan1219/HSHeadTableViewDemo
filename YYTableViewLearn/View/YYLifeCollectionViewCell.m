//
//  YYLifeCollectionViewCell.m
//  NewFrogBabyThings
//
//  Created by Ryan on 2017/6/9.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYLifeCollectionViewCell.h"

@interface YYLifeCollectionViewCell ()
/* <#description#> */
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation YYLifeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView.userInteractionEnabled = true;
        self.imageView.backgroundColor = [UIColor whiteColor];
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.borderWidth = 1;
        self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.masksToBounds = true;
        [self addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2 - 10, self.frame.size.width, 20)];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor blackColor];
        [self addSubview:self.textLabel];
        
        
        
    }
    return self;
}

@end

//
//  WZBannerCell.m
//  WZBanner_Example
//
//  Created by 王钊 on 2019/8/13.
//  Copyright © 2019 sunnyYellow. All rights reserved.
//

#import "WZBannerCell.h"

@implementation WZBannerCell

- (void)initUIMethod{
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 100, 30);
        label.backgroundColor = [UIColor blackColor];
        [self addSubview:label];
    }
    return self;
}

@end

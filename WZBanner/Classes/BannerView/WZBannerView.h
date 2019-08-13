//
//  WZBannerView.h
//  WZBanner
//
//  Created by 王钊 on 2019/8/7.
//  Copyright © 2019 王钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZBannerDelegate.h"
#import "WZBannerScrollView.h"

@interface WZBannerView : UIView
@property (nonatomic, assign) float imageWidth;
@property (nonatomic, assign) float imageSpace;
@property (nonatomic, assign) float smallScale;
@property (nonatomic, assign) float imageAlpha;
@property (nonatomic, strong) NSArray * sources;
@property (nonatomic, weak) id<WZBannerDelegate> delegate;
@property (nonatomic, copy) void(^clickBannerBlock)(WZBannerScrollView * banner,NSInteger index);
- (void)reloadData;

@end


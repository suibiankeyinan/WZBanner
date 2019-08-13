//
//  WZBannerScrollView.h
//  WZBanner
//
//  Created by 王钊 on 2019/8/6.
//  Copyright © 2019 王钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZBannerDelegate.h"
@interface WZBannerScrollView : UIScrollView
@property (nonatomic, strong) NSArray * sources;
@property (nonatomic, assign) float imageAlpha;
@property (nonatomic, weak) id<WZBannerDelegate> bannerDelegate;
- (void)setBannerInforWidth:(float)width scale:(float)scale space:(float)space alpha:(float)alpha;
- (void)reloadData;
@property (nonatomic, copy) void(^clickBannerBlock)(WZBannerScrollView * banner,NSInteger index);

@end




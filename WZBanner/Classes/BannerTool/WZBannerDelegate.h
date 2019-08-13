//
//  WZBannerDelegate.h
//  WZBanner
//
//  Created by 王钊 on 2019/8/9.
//  Copyright © 2019 王钊. All rights reserved.
//

#import "WZCustomBannerCell.h"
@protocol WZBannerDelegate <NSObject>
@required
-(NSArray*)banerSourceWithbanerView:(UIScrollView *)banerView;
-(WZCustomBannerCell*)banerCellWithbanerView:(UIScrollView *)banerView;
@optional
-(void)banerView:(UIScrollView *)banerView didSelectRowAtIndex:(NSInteger)index;

@end

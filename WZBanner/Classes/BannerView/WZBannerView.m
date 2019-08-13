//
//  WZBannerView.m
//  WZBanner
//
//  Created by 王钊 on 2019/8/7.
//  Copyright © 2019 王钊. All rights reserved.
//

#import "WZBannerView.h"
#import "UIView+WZFrame.h"
@interface WZBannerView ()<UIScrollViewDelegate,WZBannerDelegate>
@property(nonatomic,strong)WZBannerScrollView * bannerScrollView;

@end

@implementation WZBannerView

- (instancetype)init{
    self = [super init];
    if (self) {
        _smallScale = 1;
        _imageAlpha = 1;
        _imageSpace = 0;
        self.clipsToBounds = YES;
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    [self addSubview:self.bannerScrollView];
}
- (WZBannerScrollView*)bannerScrollView{
    if (!_bannerScrollView) {
        _bannerScrollView = [[WZBannerScrollView alloc]init];
    }
    return _bannerScrollView;
}

- (void)setClickBannerBlock:(void (^)(WZBannerScrollView * _Nonnull, NSInteger))clickBannerBlock{
    _clickBannerBlock = clickBannerBlock;
    self.bannerScrollView.clickBannerBlock = clickBannerBlock;
}

-(NSArray*)banerSourceWithbanerView:(UIScrollView *)banerView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(banerSourceWithbanerView:)]) {
        return [self.delegate banerSourceWithbanerView:banerView];
    }
    return nil;
}
-(WZCustomBannerCell*)banerCellWithbanerView:(UIScrollView *)banerView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(banerCellWithbanerView:)]) {
        return [self.delegate banerCellWithbanerView:banerView];
    }
    return nil;
}
-(void)banerView:(UIScrollView *)banerView didSelectRowAtIndex:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(banerView:didSelectRowAtIndex:)]) {
        [self.delegate banerView:banerView didSelectRowAtIndex:index];
    }
}
- (void)reloadData{
    [self.bannerScrollView reloadData];
}
- (void)setSources:(NSArray *)sources{
    _sources = sources;
    self.bannerScrollView.sources = sources;
}
- (void)layoutSubviews{
    if (self.delegate) {
        self.bannerScrollView.bannerDelegate = self;
    }
    float width = self.imageWidth>0?_imageWidth+_imageSpace:self.width;
    self.bannerScrollView.frame = CGRectMake((self.width-width)/2, 0, width, self.height);
    [self.bannerScrollView setBannerInforWidth:width-_imageSpace scale:_smallScale space:_imageSpace alpha:_imageAlpha];
  
}
@end

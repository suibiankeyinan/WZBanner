//
//  WZBannerScrollView.m
//  WZBanner
//
//  Created by 王钊 on 2019/8/6.
//  Copyright © 2019 王钊. All rights reserved.
//

#import "WZBannerScrollView.h"
#import "WZCustomBannerCell.h"
@interface WZBannerScrollView ()<UIScrollViewDelegate>
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)float lastContentOffset;
@property (nonatomic, assign) float imageScale;
@property (nonatomic, assign) float imageWidth;
@property (nonatomic, assign) float imageSpace;
@property (nonatomic, strong)WZCustomBannerCell * firstBannerCell;
@property (nonatomic, strong)WZCustomBannerCell * middleBannerCell;
@property (nonatomic, strong)WZCustomBannerCell * lastBannerCell;
@end

@implementation WZBannerScrollView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.bounces = NO;
        self.delegate = self;
        self.clipsToBounds = NO;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
    }
    return self;
}
- (WZCustomBannerCell*)firstBannerCell{
    if (!_firstBannerCell) {
        _firstBannerCell = [self getCustomCell];
        [self addGesterWithView:_firstBannerCell];
    }
    return _firstBannerCell;
}
- (WZCustomBannerCell*)middleBannerCell{
    if (!_middleBannerCell) {
        _middleBannerCell = [self getCustomCell];
        [self addGesterWithView:_middleBannerCell];
    }
    return _middleBannerCell;
}
-(WZCustomBannerCell*)lastBannerCell{
    if (!_lastBannerCell) {
        _lastBannerCell = [self getCustomCell];
        [self addGesterWithView:_lastBannerCell];
    }
    return _lastBannerCell;
}

- (void)refreashCurrent:(NSInteger)index{
    [self setContentOffset:CGPointMake(self.frame.size.width, 0)];
    NSInteger leftIndex  = (index ==0)?_sources.count-1:index-1;
    NSInteger rightIndex = (index ==_sources.count-1)?0:index+1;
    [self.firstBannerCell setSourceInfor:_sources[leftIndex]];
    [self.middleBannerCell setSourceInfor:_sources[_currentIndex]];
    [self.lastBannerCell setSourceInfor:_sources[rightIndex]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint currentPoint = scrollView.contentOffset;
    float current = currentPoint.x/self.frame.size.width;
    if (current == 0) {
        _currentIndex = (_currentIndex == 0)?_sources.count-1:_currentIndex-1;
        [self refreashCurrent:_currentIndex];
    }else if (current == 2){
        _currentIndex = (_currentIndex == _sources.count-1)?0:_currentIndex+1;
        [self refreashCurrent:_currentIndex];
    }
    [self refreashSizeWihtScrollView:scrollView];
}

- (void)refreashSizeWihtScrollView:(UIScrollView *)scrollView{
    CGPoint currentPoint = scrollView.contentOffset;
    BOOL isLeft = (scrollView.contentOffset.x < _lastContentOffset )?YES:NO;
    float radio = isLeft?1-(currentPoint.x/self.width):(currentPoint.x-self.width)/self.width;
    float addWidth  = (1-_imageScale)*_imageWidth*radio;
    float addHeight = (1-_imageScale)*self.height*radio;
    float width = _imageWidth*_imageScale+addWidth;
    
    float middleHeight = self.height-addHeight;
    float middleX = (self.width+_imageSpace/2)+(isLeft?0:addWidth);
    float middleY = (self.height-middleHeight)/2;
    float middleWidth = _imageWidth-addWidth;
    float currentX =self.width-self.imageSpace/2-self.imageWidth*self.imageScale;
    _middleBannerCell.frame = CGRectMake(middleX, middleY, middleWidth, middleHeight);
    _middleBannerCell.alpha = _imageAlpha+(1-radio)*(1-_imageAlpha);
    
    float lastY = self.middleBannerCell.x+self.middleBannerCell.width+_imageSpace;
    if (scrollView.contentOffset.x < _lastContentOffset ){
        _firstBannerCell.frame = CGRectMake(currentX-addWidth, (self.height - (self.height*_imageScale+addHeight))/2, width, self.height*_imageScale+addHeight);
        _lastBannerCell.frame = CGRectMake(lastY, (self.height - (self.height*_imageScale))/2, _imageWidth*_imageScale, self.height*_imageScale);
        _firstBannerCell.alpha = _imageAlpha+radio*(1-_imageAlpha);

    }else{
        _firstBannerCell.frame = CGRectMake(currentX+addWidth, ((1-_imageScale)*self.height)/2, _imageWidth*_imageScale, self.height*_imageScale);
        _lastBannerCell.frame = CGRectMake(lastY, (self.height - (self.height*_imageScale+addHeight))/2, width, self.height*_imageScale+addHeight);
        _lastBannerCell.alpha = _imageAlpha+radio*(1-_imageAlpha);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _lastContentOffset = scrollView.contentOffset.x;
}

- (void)setBannerInforWidth:(float)width scale:(float)scale space:(float)space alpha:(float)alpha{
    _imageWidth = width;
    _imageScale = scale;
    _imageSpace = space;
    _imageAlpha = alpha;
    [self addSubview:self.firstBannerCell];
    [self addSubview:self.middleBannerCell];
    [self addSubview:self.lastBannerCell];
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(banerSourceWithbanerView:)]) {
        self.sources = [self.bannerDelegate banerSourceWithbanerView:self];
    }
    [self reloadData];
    self.contentSize = CGSizeMake(self.width*3, self.height*_imageScale);
    [self initBannerStatrShowState];
}
- (void)reloadData{
    _currentIndex = 0;
    self.scrollEnabled = _sources.count >1?YES:NO;
    [self.firstBannerCell setSourceInfor:_sources.lastObject];
    [self.middleBannerCell setSourceInfor:_sources[_currentIndex]];
    [self.lastBannerCell setSourceInfor:_sources.count >1?_sources[1]:_sources.firstObject];
}

- (void)initBannerStatrShowState{
    _middleBannerCell.alpha = 1;
    _firstBannerCell.alpha = _imageAlpha;
    _lastBannerCell.alpha = _imageAlpha;
    [self setContentOffset:CGPointMake(self.width, 0)];
    float wz_width  = _imageWidth*_imageScale;
    float wz_height = self.height*_imageScale;
    float cellY     = (self.height-wz_height)/2;
    float firstX    = self.width-_imageSpace/2-wz_width;
    float secondX   = self.width+_imageSpace/2;
    float thirdX    = self.width*2+_imageSpace/2;
    self.firstBannerCell.frame = CGRectMake(firstX, cellY, wz_width, wz_height);
    self.middleBannerCell.frame = CGRectMake(secondX, 0, _imageWidth, self.height);
    self.lastBannerCell.frame = CGRectMake(thirdX, cellY, wz_width, wz_height);
}
- (WZCustomBannerCell*)getCustomCell{
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(banerCellWithbanerView:)]) {
        return [self.bannerDelegate banerCellWithbanerView:self];
    }
    return [[WZCustomBannerCell alloc]init];
}
- (void)addGesterWithView:(UIView*)view{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBanner)];
    [view addGestureRecognizer:tap];
}
- (void)clickBanner{
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(banerView:didSelectRowAtIndex:)]) {
        [self.bannerDelegate banerView:self didSelectRowAtIndex:_currentIndex];
    }
    if (self.clickBannerBlock) {
        self.clickBannerBlock(self, _currentIndex);
    }
}
@end



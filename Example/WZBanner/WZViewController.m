//
//  WZViewController.m
//  WZBanner
//
//  Created by sunnyYellow on 08/13/2019.
//  Copyright (c) 2019 sunnyYellow. All rights reserved.
//

#import "WZViewController.h"
#import <WZbanner/WZBannerView.h>
#import "WZBannerCell.h"
@interface WZViewController ()<WZBannerDelegate>
@property(nonatomic,strong)NSArray * sources;

@end

@implementation WZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.sources = @[@"h1.jpg",@"h2.jpg",@"h3.jpg",@"h4.jpg"];
    self.sources = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",@"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"];
    [self createCustom];
}

- (void)createCustom{
    WZBannerView * view = [[WZBannerView alloc]init];
    view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200);
    view.imageWidth = [UIScreen mainScreen].bounds.size.width*0.4;
    view.imageSpace = 10;
    view.smallScale = 0.6;
    view.imageAlpha = 0.8;
    view.sources = self.sources;
    [view setClickBannerBlock:^(WZBannerScrollView * _Nonnull banner, NSInteger index) {
        NSLog(@"block点击%ld",(long)index);
    }];
    [self.view addSubview:view];
}
- (void)createUser{
    WZBannerView * view = [[WZBannerView alloc]init];
    view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200);
    view.sources = self.sources;
    view.delegate = self;
    [self.view addSubview:view];
}

-(NSArray*)banerSourceWithbanerView:(UIScrollView *)banerView{
    return self.sources;
}
-(WZCustomBannerCell*)banerCellWithbanerView:(UIScrollView *)banerView{
    return [[WZBannerCell alloc] init];
}
-(void)banerView:(UIScrollView *)banerView didSelectRowAtIndex:(NSInteger)index{
    NSLog(@"代理点击%ld",(long)index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

//
//  WZCustomBannerCell.m
//  WZBanner
//
//  Created by 王钊 on 2019/8/6.
//  Copyright © 2019 王钊. All rights reserved.
//

#import "WZCustomBannerCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface WZCustomBannerCell ()

@end

@implementation WZCustomBannerCell
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setSourceInfor:(id)source{
    if ([source isKindOfClass:[NSString class]]) {
        if ([self isUrlWithStr:source]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:source]];
            return;
        }
        self.imageView.image  = [self getImageWithName:source inBundle:[NSBundle mainBundle]];
    }
}
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    float wz_width = self.frame.size.width;
    float wz_height = self.frame.size.height;
    self.imageView.frame = CGRectMake(0, 0, wz_width, wz_height);
    self.imageView.center = CGPointMake(wz_width/2, wz_height/2);
}
- (UIImage*)getImageWithName:(NSString*)name inBundle:(nullable NSBundle *)bundle{
    NSArray *paths = [bundle pathsForResourcesOfType:@"bundle" inDirectory:@"."];
    for (NSString *path in paths) {
        NSString *file = [NSString stringWithFormat:@"%@/%@", path, name];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        if (image) return image;
    }
    return nil;
}
- (BOOL)isUrlWithStr:(NSString*)str{
    if(self == nil) {
        return NO;
    }
    NSString *url;
    if (str.length>4 && [[str substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }else{
        url = str;
    }
    NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

@end

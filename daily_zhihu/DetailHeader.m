//
//  DetailHeader.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/14/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//
#import "Helper.h"
#import "DetailHeader.h"
#include "UIImage+RTTint.h"
#import "UIImageView+WebCache.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@interface DetailHeader()

@property (strong, nonatomic) UILabel *Title;
@property (strong, nonatomic) UIImageView *DetailImg;
@end

@implementation DetailHeader

- (void)ConfigureHeader
{
    //加载UIImageView
    self.DetailImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
    self.DetailImg.translatesAutoresizingMaskIntoConstraints = NO;
    self.DetailImg.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.DetailImg];
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":self.DetailImg}];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]|" options:0 metrics:nil views:@{@"view":self.DetailImg}];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    //加载Title
    self.Title = [[UILabel alloc] init];
    self.Title.textColor = [UIColor whiteColor];
    self.Title.translatesAutoresizingMaskIntoConstraints = NO;
    self.Title.lineBreakMode = NSLineBreakByWordWrapping;
    self.Title.numberOfLines = 0;
    [self.DetailImg addSubview:self.Title];
    
    NSArray *constraint3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|" options:0 metrics:nil views:@{@"view":self.Title}];
    NSArray *constraint4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-20-|" options:0 metrics:nil views:@{@"view":self.Title}];
    [self addConstraints:constraint3];
    [self addConstraints:constraint4];
}

- (void)setImgURL:(NSString *)url Title:(NSString *)title
{
    [self ConfigureHeader];
    self.Title.text = title;
    [self.DetailImg sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIImage *tinted = [image rt_darkenWithLevel:0.2f];  //降低图片亮度
        UIImage *newImg = [Helper imageCompressForSize:tinted targetSize:CGSizeMake(SCREENWIDTH, 200)];
  //      UIImage *tmpImg = [Helper imageWithImage:tinted scaledToSize:CGSizeMake(SCREENWIDTH, SCREENWIDTH)];  //缩放图片
  //      UIImage *newImg = [Helper imageWithImage:tmpImg Rect:CGRectMake(0, 100, SCREENWIDTH, 200)];  //裁剪图片
        [self.DetailImg setImage:newImg];
    }];
}

@end

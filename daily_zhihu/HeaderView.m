//
//  HeaderView.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/13/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "HeaderView.h"
#import "Helper.h"
#import "TopItem.h"
#import "UIImageView+WebCache.h"
#import "ImagePlayerView.h"
#import "ShowVC.h"
#import "UIImage+RTTint.h"

#define SegueIdentifier @"showDetail"

@interface HeaderView() <ImagePlayerViewDelegate>
@property (weak, nonatomic) IBOutlet ImagePlayerView *TopStoryShow;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (retain, nonatomic) UILabel *Title;
@property (nonatomic, strong) NSArray *ImgURL;
@property (nonatomic, strong) NSArray *TopInfo;

@end

@implementation HeaderView

- (NSArray *)ImgURL
{
    if (!_ImgURL) {
        _ImgURL = [[NSArray alloc] init];
    }
    return _ImgURL;
}

- (NSArray *)TopInfo
{
    if (!_TopInfo) {
        _TopInfo = [[NSArray alloc] init];
    }
    return _TopInfo;
}

- (void)imagePlayerInit
{
    self.TopStoryShow.imagePlayerViewDelegate = self;
    self.TopStoryShow.scrollInterval = 5.0f;
    self.TopStoryShow.pageControlPosition = ICPageControlPosition_BottomCenter;
    self.TopStoryShow.hidePageControl = NO;
    [self.TopStoryShow reloadData];
}

- (void)TitleInit
{
    self.Title = [[UILabel alloc] init];
    self.Title.textColor = [UIColor whiteColor];
    self.Title.translatesAutoresizingMaskIntoConstraints = NO;
    self.Title.lineBreakMode = NSLineBreakByWordWrapping;
    self.Title.numberOfLines = 0;
    [self addSubview:self.Title];
    
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|" options:0 metrics:nil views:@{@"view":self.Title}];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-28-|" options:0 metrics:nil views:@{@"view":self.Title}];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
}

- (void)setInfo:(NSArray *)TopInfo
{
    self.TopInfo = TopInfo;
    self.ImgURL = [Helper createURLArray:TopInfo];
    [self imagePlayerInit];
    [self TitleInit];
    self.Title.text = [(TopItem *)self.TopInfo[0] Title];
}

- (void)awakeFromNib
{
    self.TitleLable.lineBreakMode = NSLineBreakByWordWrapping;      //Lable自动换行
    self.TitleLable.numberOfLines = 0;
}

#pragma mark - ImagePlayerViewDelegate

- (NSInteger)numberOfItems
{
    return self.ImgURL.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView sd_setImageWithURL:self.ImgURL[index] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIImage *tinted = [image rt_darkenWithLevel:0.3f];      //降低图片亮度
        [imageView setImage:tinted];
    }];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView currentPage:(NSInteger)index
{
    self.Title.text = [(TopItem *)self.TopInfo[index] Title];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    //从当前UIView得到UIViewController
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            [(ShowVC *)nextResponder performSegueWithIdentifier:SegueIdentifier
                                                         sender:[Helper NewsItemWithTopItem:self.TopInfo[index]]];
            break;
        }
    }
    NSLog(@"did tap index = %d", (int)index);
}

@end

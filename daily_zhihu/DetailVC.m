//
//  DetailVC.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/14/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "DetailVC.h"
#import "NewsItem.h"
#import "DetailHeader.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RTTint.h"
#import "ComUnit.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@interface DetailVC () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *WebShow;
@property (retain, nonatomic) UILabel *Title;
@end

@implementation DetailVC

- (void)WebViewInit:(NSString *)ImgURL
{
    DetailHeader *view = [[DetailHeader alloc] initWithFrame:CGRectMake(0, -20, SCREENWIDTH, 200)];
    NSLog(@"%f, %f", view.frame.origin.x, view.frame.origin.y);
    [view setImgURL:ImgURL Title:self.StoryItem.Title];
    [self.WebShow.scrollView addSubview:view];

  //  [self.WebShow.scrollView addSubview:view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.WebShow.scrollView.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.WebShow.scalesPageToFit = NO;
    [ComUnit FetchStoryDetail:self.StoryItem.NewsID DetailCallback:^(NSString *body, NSString *ImgURL, NSString *css, NSError *err) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:css]];
        [request setHTTPMethod:@"GET"];
        NSError *error = [NSError new];
        NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *CSS = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
        NSString* htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><style>%@</style></head><body>%@</body></html>", CSS, body];
        NSLog(@"%@",htmlString);
        [self WebViewInit:ImgURL];
        [self.WebShow loadHTMLString:htmlString baseURL:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y < 0) {
        scrollView.bounces = NO;
    } else {
        scrollView.bounces = YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

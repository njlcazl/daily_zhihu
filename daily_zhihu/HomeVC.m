//
//  HomeVC.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/11/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "HomeVC.h"
#import "ComUnit.h"

@interface HomeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;


@end

@implementation HomeVC

#define identifier @"showCollection"

//图片放大动画CABasicAnimation
- (void)beginAnimating
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 2;
    animation.repeatCount = 1;
    animation.autoreverses = NO;
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.5];
    [animation setDelegate:self];
    [self.homeImage.layer addAnimation:animation forKey:@"scale-layer"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //通讯第一步:获取首页图片
    NSURL *url = [NSURL URLWithString:[ComUnit FetchHomeImg]];
    [self.homeImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
    [self beginAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self performSegueWithIdentifier:identifier sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

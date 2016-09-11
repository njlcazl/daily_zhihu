//
//  ShowVC.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/11/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "ShowVC.h"
#import "ShowAlert.h"
#import "DetailVC.h"
#import "Helper.h"
#import "ComUnit.h"
#import "TopItem.h"
#import "StoryItemCell.h"
#import "HeaderView.h"

#define CellIdentifier @"StoryCell"
#define SegueIdentifier @"showDetail"

@interface ShowVC()
@property (nonatomic, strong) NSArray *ImgURL;
@property (nonatomic, strong) NSArray *NewsInfo;
@property (nonatomic, strong) NSArray *TopInfo;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (weak, nonatomic) IBOutlet UITableView *StoryList;
@property (weak, nonatomic) IBOutlet UIView *Header;

@end

@implementation ShowVC

//懒加载
- (NSArray *)ImgURL
{
    if (!_ImgURL) {
        _ImgURL = [[NSArray alloc] init];
    }
    return _ImgURL;
}

- (NSArray *)NewsInfo
{
    if (!_NewsInfo) {
        _NewsInfo = [[NSArray alloc] init];
    }
    return _NewsInfo;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //通讯第二步:得到新闻列表和表头列表信息
    [ComUnit FetchLatest:^(NSArray *NewList, NSArray *TopStory, NSError *err) {
        if (err) {
            [ShowAlert showErr:@"Connect Error!"];
        }
        else
        {
            self.ImgURL = [Helper createURLArray:TopStory];
            self.TopInfo = TopStory;
            self.NewsInfo = NewList;
            self.StoryList.delegate = self;
            self.StoryList.dataSource = self;
            //加载HeaderView
            HeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"Header" owner:nil options:nil] lastObject];
            [view setInfo:self.TopInfo];
            self.StoryList.tableHeaderView = view;
        }
    }];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;  //滑动返回相关
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;  //隐藏NavigationBar
    //注册重用Cell
    [self.StoryList registerNib:[UINib nibWithNibName:@"StoryItemCell" bundle:nil]
            forCellReuseIdentifier:CellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.StoryList reloadData];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.NewsInfo.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"今日热闻";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y == 0) {
        scrollView.bounces = NO;
    } else {
        scrollView.bounces = YES;
    }
    //通过滚动距离设置标题
    if (self.StoryList.contentOffset.y > self.StoryList.sectionHeaderHeight + self.StoryList.tableHeaderView.frame.size.height) {
        self.TitleLable.text = @"今日热闻";
    }
    else self.TitleLable.text = @"首页";
    
    //解除SectionHeader悬浮效果
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    TopItem *item = self.NewsInfo[indexPath.row];
    [cell setInfo:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:SegueIdentifier sender:[self.NewsInfo objectAtIndex:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailVC *desVC = [segue destinationViewController];
    desVC.navigationController.navigationBarHidden = YES;
    desVC.StoryItem = sender;
}






















@end

//
//  ComUnit.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/11/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "ComUnit.h"
#import "TopItem.h"
#import "NewsItem.h"

#define kFetchHomeImg @"http://news-at.zhihu.com/api/4/start-image/1080*1776"
#define kFetchLatest @"http://news-at.zhihu.com/api/4/news/latest"
#define kFetchStoryDetail(NewsID) @"http://news-at.zhihu.com/api/4/news/%@", NewsID

@implementation ComUnit

+ (NSString *)FetchHomeImg
{
    NSURL *url = [NSURL URLWithString:kFetchHomeImg];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSError *err = [[NSError alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *ret = [resultDic valueForKey:@"img"];
    return ret;
}

+ (void)FetchLatest:(FetchLatestNews)callback
{
    NSURL *url = [NSURL URLWithString:kFetchLatest];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            callback(nil, nil, connectionError);
        } else {
            NSMutableArray *NewsList = [NSMutableArray arrayWithCapacity:1];
            NSMutableArray *TopStoryList = [NSMutableArray arrayWithCapacity:1];
            @try {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSArray *tempNews = [resultDic valueForKey:@"stories"];
                NSArray *tempTop = [resultDic valueForKey:@"top_stories"];
                [tempNews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NewsItem *item = [NewsItem initWithObj:obj];
                    [NewsList addObject:item];
                }];
                [tempTop enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    TopItem *item = [TopItem initWithObj:obj];
                    [TopStoryList addObject:item];
                }];
            }
            @catch (NSException *exception) {
                connectionError = [NSError new];
            }
            @finally {
                for (int i = 0; i < [TopStoryList count]; i++) {
                    NSLog(@"%@\n", [TopStoryList objectAtIndex:i]);
                }
                callback(NewsList, TopStoryList, nil);
            }
            
            
        }
    }];
    
}

+ (void)FetchStoryDetail:(NSString *)NewsID DetailCallback:(FetchDetail)callback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kFetchStoryDetail(NewsID)]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            callback(nil, nil, nil, connectionError);
        } else {
            NSString *retBody;
            NSString *retImgURL;
            NSString *retCSS;
            @try {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                retBody = [resultDic valueForKey:@"body"];
                retImgURL = [resultDic valueForKey:@"image"];
                retCSS = [[resultDic valueForKey:@"css"] firstObject];
            }
            @catch (NSException *exception) {
                connectionError = [NSError new];
            }
            @finally {
                callback(retBody, retImgURL, retCSS, nil);
            }
        }
    }];
}

@end

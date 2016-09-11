//
//  NewsItem.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/12/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

- (id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if (self) {
        self.NewsID = [[obj valueForKey:@"id"] stringValue];
        self.ImgURL = [obj valueForKey:@"images"][0];
        self.Title = [obj valueForKey:@"title"];
    }
    return self;
}

+ (id)initWithObj:(NSDictionary *)obj
{
    NewsItem *item = [[NewsItem alloc] initWithObj:obj];
    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"NewsID:%@ ImageURL:%@ Title:%@", self.NewsID, self.ImgURL, self.Title];
}

@end

//
//  TopItem.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/12/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "TopItem.h"

@implementation TopItem
- (id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if (self) {
        self.NewsID = [[obj valueForKey:@"id"] stringValue];
        self.ImgURL = [obj valueForKey:@"image"];
        self.Title = [obj valueForKey:@"title"];
    }
    return self;
}

+ (id)initWithObj:(NSDictionary *)obj
{
    TopItem *item = [[TopItem alloc] initWithObj:obj];
    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"NewsID:%@ ImageURL:%@ Title:%@", self.NewsID, self.ImgURL, self.Title];
}

@end

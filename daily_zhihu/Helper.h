//
//  Helper.h
//  daily_zhihu
//
//  Created by 曾祺植 on 8/12/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class NewsItem, TopItem;
@interface Helper : NSObject

+ (NSArray *)createURLArray:(NSArray *)arr;
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (NewsItem *)NewsItemWithTopItem:(TopItem *)item;
@end

//
//  ComUnit.h
//  daily_zhihu
//
//  Created by 曾祺植 on 8/11/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FetchLatestNews) (NSArray *NewList, NSArray *TopStory, NSError *err);
typedef void(^FetchDetail) (NSString *body, NSString *ImgURL, NSString *css, NSError *err);

@interface ComUnit : NSObject

+ (NSString *)FetchHomeImg;
+ (void)FetchLatest:(FetchLatestNews)callback;
+ (void)FetchStoryDetail:(NSString *)NewsID DetailCallback:(FetchDetail)callback;
@end

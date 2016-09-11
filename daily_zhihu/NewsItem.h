//
//  NewsItem.h
//  daily_zhihu
//
//  Created by 曾祺植 on 8/12/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject
@property (nonatomic, strong) NSString *NewsID;
@property (nonatomic, strong) NSString *ImgURL;
@property (nonatomic, strong) NSString *Title;

+ (id)initWithObj:(NSDictionary *)obj;

@end

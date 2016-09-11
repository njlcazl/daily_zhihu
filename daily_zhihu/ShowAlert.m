//
//  ShowAlert.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/12/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//
#include <UIKit/UIKit.h>
#import "ShowAlert.h"

@implementation ShowAlert

+ (void)showErr:(NSString *)errText
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:errText
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

@end

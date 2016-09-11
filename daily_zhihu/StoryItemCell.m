//
//  StoryItemCell.m
//  daily_zhihu
//
//  Created by 曾祺植 on 8/14/15.
//  Copyright (c) 2015 曾祺植. All rights reserved.
//

#import "StoryItemCell.h"
#import "UIImageView+WebCache.h"
#import "TopItem.h"
@interface StoryItemCell()
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UIImageView *StoryImg;

@end

@implementation StoryItemCell

- (void)awakeFromNib {
    self.Title.lineBreakMode = NSLineBreakByWordWrapping;      //Lable自动换行
    self.Title.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(TopItem *)item
{
    self.Title.text = item.Title;
    [self.StoryImg sd_setImageWithURL:[NSURL URLWithString:item.ImgURL] placeholderImage:nil];
}

@end

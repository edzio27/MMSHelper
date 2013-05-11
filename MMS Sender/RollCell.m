//
//  RollCell.m
//  MMS Sender
//
//  Created by Edzio27 Edzio27 on 11.05.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "RollCell.h"

@implementation RollCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.thumbnailView = [[UIImageView alloc] init];
        self.thumbnailView.transform = CGAffineTransformMakeRotation(M_PI/5);
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

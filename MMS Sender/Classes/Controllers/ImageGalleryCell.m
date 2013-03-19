//
//  ImageGalleryCell.m
//  dysk
//
//  Created by Eugeniusz Keptia on 05.03.2013.
//  Copyright (c) 2013 Droids on Roids. All rights reserved.
//

#import "ImageGalleryCell.h"

#define IMAGE_WIDTH 70
#define IMAGE_HEIGHT 70

@implementation ImageGalleryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        _image1 = [[UIButton alloc] initWithFrame:CGRectMake(8, 5, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [self addSubview:_image1];
        
        _image2 = [[UIButton alloc] initWithFrame:CGRectMake(2 * 8 + IMAGE_WIDTH, 5, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [self addSubview:_image2];
        
        _image3 = [[UIButton alloc] initWithFrame:CGRectMake(3 * 8 + 2 * IMAGE_WIDTH, 5, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [self addSubview:_image3];
        
        _image4 = [[UIButton alloc] initWithFrame:CGRectMake(4 * 8 + 3 * IMAGE_WIDTH, 5, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [self addSubview:_image4];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

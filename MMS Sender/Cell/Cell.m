//
//  Cell.m
//  PSPDFKit
//
//  Copyright (c) 2012 Peter Steinberger. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        NSLog(@"width %f", frame.size.width);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:imageView];
        
        _tutorialLabel = [[UILabel alloc] init];
        _tutorialLabel.backgroundColor = [UIColor clearColor];
        _tutorialLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _tutorialLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _tutorialLabel.textAlignment = NSTextAlignmentCenter;
        _tutorialLabel.textColor = [UIColor colorWithRed:0.996 green:0.788 blue:0.027 alpha:1.0];
        _tutorialLabel.numberOfLines = 2;
        
        _tutorialImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_tutorialImageView];
        [self.contentView addSubview:_tutorialLabel];
        
        _imageView = imageView;
    }
    return self;
}

@end

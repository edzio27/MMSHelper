//
//  Cell.h
//  PSPDFKit
//
//  Copyright (c) 2012 Peter Steinberger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"

__unused  static NSString *cellIdentifier = @"myCell";

@interface Cell : PSUICollectionViewCell

@property (strong, nonatomic) UIImageView* imageView;
@property (nonatomic, strong) UIImageView *tutorialImageView;
@property (nonatomic, strong) UILabel *tutorialLabel;

@end

//
//  ImageRollViewController.h
//  dysk
//
//  Created by Eugeniusz Keptia on 05.03.2013.
//  Copyright (c) 2013 Droids on Roids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImageRollViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ALAssetsGroup:(ALAssetsGroup *)inputAssetGroup;

@end

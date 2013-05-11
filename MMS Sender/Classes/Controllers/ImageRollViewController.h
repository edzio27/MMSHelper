//
//  UploadViewController.m
//  dysk
//
//  Created by Eugeniusz Keptia on 18.02.2013.
//  Copyright (c) 2013 Edzio27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImageRollViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ALAssetsGroup:(ALAssetsGroup *)inputAssetGroup;

@end

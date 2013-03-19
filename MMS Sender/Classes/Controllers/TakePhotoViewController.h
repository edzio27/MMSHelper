//
//  TakePhotoViewController.h
//  MMS Sender
//
//  Created by edzio27 on 19.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *cameraPicker;
@property (nonatomic, strong) UIImage *imageSource;

@end

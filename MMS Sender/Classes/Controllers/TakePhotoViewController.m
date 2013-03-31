//
//  TakePhotoViewController.m
//  MMS Sender
//
//  Created by edzio27 on 19.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "EKAppDelegate.h"
#import "UIImage+ScaleImage.h"

static BOOL cameraViewWasShown;

@interface TakePhotoViewController ()

@end

@implementation TakePhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        cameraViewWasShown = NO;
        // Custom initialization
    }
    return self;
}

- (UIImage *)imageSource {
    if(_imageSource == nil) {
        _imageSource = [[UIImage alloc] init];
    }
    return _imageSource;
}

- (UIImagePickerController *)cameraPicker {
    if(_cameraPicker == nil) {
        _cameraPicker = [[UIImagePickerController alloc] init];
        [_cameraPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [_cameraPicker setDelegate:self];
    }
    return _cameraPicker;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor blackColor];
    [self performSelector:@selector(showImagePicker) withObject:self afterDelay:0.7];
}

- (void)showImagePicker {
    if(!cameraViewWasShown) {
        [self presentModalViewController:self.cameraPicker animated:NO];
        cameraViewWasShown = YES;
    }
}

- (void)dismissViewAndGoToMainTabBarController {
    [self dismissModalViewControllerAnimated:NO];
    EKAppDelegate * delegate  = (EKAppDelegate*) [[UIApplication sharedApplication] delegate];
    [delegate transitionToTabs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageSource = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissModalViewControllerAnimated:NO];
    EKAppDelegate * delegate  = (EKAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    NSData *data = [UIImage scaleImageData:UIImageJPEGRepresentation(self.imageSource, 1.0)];
    [delegate transitionToTabsAndOpenMMS:data];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewAndGoToMainTabBarController];
}


@end

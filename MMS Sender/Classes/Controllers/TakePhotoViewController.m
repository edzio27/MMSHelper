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
#import "EKMMSSenderViewController.h"

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
    
    /* title label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0];
    label.text = @"Photo";
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
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
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    [self.navigationController popViewControllerAnimated:NO];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    self.imageSource = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = [UIImage scaleImageData:UIImageJPEGRepresentation(self.imageSource, 1.0)];
    
    EKMMSSenderViewController *mms = [[EKMMSSenderViewController alloc] initWithNibName:@"EKMMSSenderViewController" bundle:nil imageToSemd:data];
    //[self performSelector:@selector(popToRootViewControllerMethod) withObject:self afterDelay:2.0];
    [self.navigationController pushViewController:mms animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewAndGoToMainTabBarController];
}


@end

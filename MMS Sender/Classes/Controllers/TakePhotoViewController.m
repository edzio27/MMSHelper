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

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundClear"]];
    //self.view.backgroundColor = [UIColor blackColor];
    [self performSelector:@selector(showImagePicker) withObject:self afterDelay:0.7];
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
    label.text = NSLocalizedString(@"Photo", @"");
    self.navigationItem.titleView = label;
    
    /* custom back button */
    UIView *buttonHoler = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIButton *backButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [backButton setBackgroundImage: [UIImage imageNamed: @"back"]  forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0] forState: UIControlStateNormal];
    [backButton setTitle: NSLocalizedString(@"Back button", nil) forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize: 13];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 5, 60, 34)];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0);
    backButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [buttonHoler addSubview: backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: buttonHoler];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    // Do any additional setup after loading the view from its nib.
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

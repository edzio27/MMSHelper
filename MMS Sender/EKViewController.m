//
//  EKViewController.m
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "EKViewController.h"
#import "UploadViewController.h"
#import "TakePhotoViewController.h"
#import "EKAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@interface EKViewController ()

@property (nonatomic, strong) UILabel *author;

@end

@implementation EKViewController

- (UILabel *)author {
    if(_author == nil) {
        _author = [[UILabel alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 100, 200, 30)];
        _author.textColor = [UIColor blackColor];
        _author.backgroundColor = [UIColor clearColor];
        _author.text = @"created by @edzio27";
    }
    return _author;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    //[self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    self.navigationItem.title = @"MMS Sender";
    
    /* title label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0];
    label.text = @"MMS Sender";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbar.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = label;

    //self.cameraButton.backgroundColor = [UIColor blackColor];
    //[self.view addSubview:self.author];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    //EKAppDelegate * delegate  = (EKAppDelegate*) [[UIApplication sharedApplication] delegate];
    //[delegate transitionToCamera];
    TakePhotoViewController *camera = [[TakePhotoViewController alloc] initWithNibName:@"TakePhotoViewController" bundle:nil];

    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:camera animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}
- (IBAction)selectImage:(id)sender {
    UploadViewController *image = [[UploadViewController alloc] init];
    [self.navigationController pushViewController:image animated:YES];
}

@end

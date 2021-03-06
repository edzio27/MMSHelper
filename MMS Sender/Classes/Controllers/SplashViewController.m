//
//  SplashViewController.m
//  MMS Sender
//
//  Created by Edzio27 Edzio27 on 12.05.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "SplashViewController.h"
#import "Cell.h"

@interface SplashViewController ()


@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *tutorialArray;

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)imageArray {
    if(_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc] init];
        [_imageArray addObject:@"tutorial1"];
        [_imageArray addObject:@"tutorial2"];
        [_imageArray addObject:@"tutorial3"];
    }
    return _imageArray;
}

- (NSMutableArray *)tutorialArray {
    if(_tutorialArray == nil) {
        _tutorialArray = [[NSMutableArray alloc] init];
        [_tutorialArray addObject:NSLocalizedString(@"tutorial1", @"")];
        [_tutorialArray addObject:NSLocalizedString(@"tutorial2", @"")];
        [_tutorialArray addObject:NSLocalizedString(@"tutorial3", @"")];
    }
    return _tutorialArray;
}

- (UIButton *)startButton {
    if(_startButton == nil) {
        _startButton = [[UIButton alloc] initWithFrame:CGRectMake(103, [[UIScreen mainScreen] bounds].size.height - 90, 114, 32)];
        [_startButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (void)dismiss {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES" forKey:@"wasInTutorial"];
    [self dismissModalViewControllerAnimated:YES];
}

- (UIPageControl *)pageControl {
    if(_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 60, self.view.frame.size.width, 30)];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"myCell"];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.startButton];
    //[self.view bringSubviewToFront:self.pageControl];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 3;
}

#pragma mark - PSTCollectionViewDelegate

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    cell.tutorialLabel.text = [self.tutorialArray objectAtIndex:indexPath.row];
    
    float height = [[UIScreen mainScreen] bounds].size.height;
    
    if(indexPath.row == 0) {
        cell.tutorialLabel.frame = CGRectMake(0, 0.03*height, 320, 50);
        cell.tutorialImageView.frame = CGRectMake(55, 73, self.view.frame.size.width - 2*55, 315);
        cell.tutorialImageView.image = [UIImage imageNamed:@"image_tutorial1.png"];
    }
    if(indexPath.row == 1) {
        cell.tutorialLabel.frame = CGRectMake(0, 0.68*height, 320, 50);
        cell.tutorialImageView.frame = CGRectMake(55, 20, self.view.frame.size.width - 2*55, 315);
        cell.tutorialImageView.image = [UIImage imageNamed:@"image_tutorial2.png"];
    }
    if(indexPath.row == 2) {
        cell.tutorialLabel.frame = CGRectMake(0, 0.70*height, 320, 50);
        cell.tutorialImageView.frame = CGRectMake(55, 10, self.view.frame.size.width - 2*55, 315);
        cell.tutorialImageView.image = [UIImage imageNamed:@"image_tutorial3.png"];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCollectionView:nil];
    [super viewDidUnload];
}
@end

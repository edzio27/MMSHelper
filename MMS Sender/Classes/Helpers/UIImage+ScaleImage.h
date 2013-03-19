//
//  UIImage+ScaleImage.h
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScaleImage)

+ (NSData *)scaleImage:(NSString *)imagePath;
+ (NSData *)scaleImageData:(NSData *)data;
+ (NSMutableData *) getRawDataFromALAsset:(NSString *) imagePath;

@end

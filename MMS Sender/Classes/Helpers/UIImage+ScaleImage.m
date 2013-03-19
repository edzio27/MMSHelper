//
//  UIImage+ScaleImage.m
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "UIImage+ScaleImage.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define MAX_BYTES 30000

@implementation UIImage (ScaleImage)

+ (NSData *)scaleImage:(NSString *)imagePath {
    UIImage *image = [UIImage imageWithData:[self getRawDataFromALAsset:imagePath]];
    NSData *imageData = nil;
    for(float i = 1; i <= 100; i+=0.2 ) {
        imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((image), 1.0/i)];
        if(imageData.length <= MAX_BYTES) {
            break;
        }
    }
    return imageData;
}

+ (NSData *)scaleImageData:(NSData *)data {
    UIImage *image = [UIImage imageWithData:data];
    
    if(image.size.width < image.size.height) {
        UIGraphicsBeginImageContext(CGSizeMake(640, 720));
        [image drawInRect:CGRectMake(0, 0, 640, 720)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    } else {
        UIGraphicsBeginImageContext(CGSizeMake(720, 640));
        [image drawInRect:CGRectMake(0, 0, 720, 640)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    
    NSData *imageData = nil;
    for(float i = 1; i <= 100; i+=0.2 ) {
        imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((image), 1.0/i)];
        NSLog(@"data %d", imageData.length);
        if(imageData.length <= MAX_BYTES) {
            break;
        }
    }
    return imageData;
}

+ (NSMutableData *) getRawDataFromALAsset:(NSString *) imagePath {
    
    __block NSMutableData* rawData;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(queue, ^{
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAsset* selectedAsset = myasset;
            int byteArraySize = selectedAsset.defaultRepresentation.size;
            rawData = [[NSMutableData alloc]initWithCapacity:byteArraySize];
            void* bufferPointer = [rawData mutableBytes];
            
            NSError* error=nil;
            [selectedAsset.defaultRepresentation getBytes:bufferPointer fromOffset:0 length:byteArraySize error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            rawData = [NSMutableData dataWithBytes:bufferPointer length:byteArraySize];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cachesDirectory = [paths objectAtIndex:0];
            NSString* filePath = [NSString stringWithFormat:@"%@/imageTemp.png",cachesDirectory];
            [rawData writeToFile:filePath atomically:YES];
            dispatch_semaphore_signal(semaphore);
        };
        
        NSURL *asseturl = [NSURL URLWithString:imagePath];
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        
        [assetslibrary assetForURL:asseturl
                       resultBlock:resultblock
                      failureBlock:^(NSError *error) {
                          NSLog(@"error couldn't get photo");
                      }];
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return rawData;
}

@end

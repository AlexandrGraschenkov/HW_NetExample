//
//  ImageSliceTool.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ImageSliceTool.h"

@implementation ImageSliceTool

+ (NSDictionary*)sliceUpImageToFiles:(UIImage*)img name:(NSString*)folderName colCount:(NSInteger)colCount rowCount:(NSInteger)rowCount
{
    NSURL *dirUrl = [self createDirectoryWithName:folderName];
    CGSize elemSize = CGSizeMake(img.size.width / rowCount, img.size.height / colCount);
    for(NSInteger col = 0; col < colCount; col++){
        for(NSInteger row = 0; row < rowCount; row++){
            NSString *fileName = [NSString stringWithFormat:@"%d_%d.png", col, row];
            NSURL *newImgPathURL = [dirUrl URLByAppendingPathComponent:fileName];
            CGRect cropFrame = CGRectMake(floorf(img.size.width * row / rowCount),
                                          floorf(img.size.height * col / colCount),
                                          ceilf(elemSize.width),
                                          ceilf(elemSize.height));
            UIImage *newImg = [self cropImage:img rect:cropFrame];
            NSData *data = UIImagePNGRepresentation(newImg);
            [data writeToURL:newImgPathURL atomically:YES];
        }
    }
    
    NSDictionary *info = @{@"elem_width" : @(elemSize.width), @"elem_height" : @(elemSize.height), @"folder_path" : dirUrl.absoluteString, @"columns_count" : @(colCount), @"rows_count" : @(rowCount)};
    return info;
}

// не учитывает imageOrientation
+ (UIImage*)cropImage:(UIImage*)img rect:(CGRect)cropRect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], cropRect);
    img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return img;
}

+ (NSURL*)createDirectoryWithName:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *pathUrl = [NSURL fileURLWithPath:documentsDirectory];
    pathUrl = [pathUrl URLByAppendingPathComponent:name isDirectory:YES];
    
    NSError *err;
    if ([pathUrl checkResourceIsReachableAndReturnError:nil])
        [[NSFileManager defaultManager] removeItemAtURL:pathUrl error:&err];
    [[NSFileManager defaultManager] createDirectoryAtURL:pathUrl withIntermediateDirectories:NO attributes:nil error:&err];
    
    assert(!err);
    return pathUrl;
}

@end

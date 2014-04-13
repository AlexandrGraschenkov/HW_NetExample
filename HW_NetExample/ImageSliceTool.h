//
//  ImageSliceTool.h
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSliceTool : NSObject

+ (NSDictionary*)sliceUpImageToFiles:(UIImage*)img
                                name:(NSString*)prefixFile
                            colCount:(NSInteger)colCount
                            rowCount:(NSInteger)rowCount;

@end

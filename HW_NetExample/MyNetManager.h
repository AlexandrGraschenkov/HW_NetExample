//
//  MyNetManager.h
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNetManager : NSObject

+ (instancetype)sharedInstance;

- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection;

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection;

@end
